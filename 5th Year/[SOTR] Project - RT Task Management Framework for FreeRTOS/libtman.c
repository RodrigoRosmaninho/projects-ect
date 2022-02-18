/* Standard includes. */
#include <stdio.h>
#include <string.h>

#include <xc.h>
#include <sys/attribs.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "queue.h"


/* App includes */
#include "../UART/uart.h"

#include "libtman.h"

#define SYSCLK  80000000L // System clock frequency, in Hz
#define PBCLOCK 40000000L // Peripheral Bus Clock frequency, in Hz


TMAN_Task task_list[31];
int task_list_len = 0;
TMANTick_t current_tick = -1;

// --- TMAN ---

int TMAN_Init(float factor) {
    /* Set Interrupt Controller for multi-vector mode */
    INTCONSET = _INTCON_MVEC_MASK;
    
    /* Enable Interrupt Exceptions */
    // Set the CP0 status IE bit high to turn on interrupts globally
    __builtin_enable_interrupts();
    
    // Set timer
    T3CONbits.ON = 0; // Stop timer
    T2CONbits.ON = 0;
    IFS0bits.T3IF=0; // Reset interrupt flag
    IFS0bits.T2IF=0;
    IPC3bits.T3IP=7; // Set interrupt priority
    IPC2bits.T2IP=7; 
    IEC0bits.T3IE = 1; // Enable interrupts
    IEC0bits.T2IE = 1; 
    
    // Timer period configuration
    T2CONbits.TCKPS = 7; // Divide by 256 pre-scaler
    T2CONbits.T32 = 1; // 32 bit timer operation
    
    // Max counter value configuration
    uint32_t timer_value = (40000000/256)*factor*0.001;
    PR3 = timer_value >> 16;
    PR2 = timer_value;
    
    TMR3=0;
    TMR2=0;
    
    return 0;
}

int TMAN_Start() {
    // Start the Hardware Timer
    T2CONbits.TON=1;
    return 0;
}

int TMAN_Close() {
    // Stop the Hardware Timer
    T2CONbits.TON=0;
    return 0;
}

void __ISR (_TIMER_3_VECTOR, IPL7SRS) TMAN_TimerISR(void)
{
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    
    current_tick++;
    
    for(int i = 0; i < task_list_len; i++){
        TMAN_Task *t = &(task_list[i]);
        // Consider only periodic tasks that have completed their execution since the most recent activation 
        if(!t->isActive && t->isPeriodic) {
            // Determine if the task should be woken up
            if (current_tick >= t->phase && (current_tick - t->phase) % t->period == 0) {
                // Wake up the task by DTT Notification
                // Notification lsb is reserved for notifications originating from the ISR (relating to the periodicity of the task)
                xTaskNotifyFromISR((t->task), 1, eSetBits, &xHigherPriorityTaskWoken);
            }
        }
    }
    
    IFS0bits.T3IF = 0; // Reset interrupt flag
    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}

int TMAN_TaskAdd(TaskFunction_t task, char * name, int priority) {
    TMAN_Task *t = &(task_list[task_list_len]);
    t->name = name;
    t->lastActivationTime = -1;
    t->stats.numActivations = 0;
    xTaskCreate( task, ( const signed char * const ) name, configMINIMAL_STACK_SIZE, (void *) (task_list_len), priority, &(t->task) );
    return task_list_len++;
}

int TMAN_TaskRegisterAttributes(int index, TMANTick_t period, TMANTick_t phase, TMANTick_t deadline) {
    TMAN_Task *t = &(task_list[index]);
    t->isPeriodic = 1;
    t->period = period;
    t->phase = phase;
    t->deadline = deadline;
    // dependenceMask lsb is reserved for notifications originating from the ISR (relating to the periodicity of the task)
    t->dependencesMask |= 1;
    return 0;
}

int TMAN_TaskAddPrecedence(int index, int precedenceIndex) {
    // Detect cyclic dependences (deadlock prevention)
    if (PrecedenceCycleDetection(index, precedenceIndex)) {
        printf("\nCyclic dependency detected!\nTo avoid deadlock, the %s -> %s precedence will not be enforced!\n\n", task_list[index].name, task_list[precedenceIndex].name);
        return 1;
    }

    TMAN_Task *t1 = &(task_list[index]);
    TMAN_Task *t2 = &(task_list[precedenceIndex]);

    t2->dependees[t2->numDependees] = index;
    t2->numDependees++;
    // Set the corresponding bit on the dependencesMask of the dependent task
    t1->dependencesMask |= 1 << precedenceIndex + 1;
    return 0;
}

int TMAN_TaskWaitPeriod(int index) {
    uint32_t notifyValue = 0;

    TMAN_Task *t = &(task_list[index]);
    
    if (t->stats.numActivations != 0) {
        // Detect deadline miss
        if ((current_tick - t->lastActivationTime) > t->deadline) {
            t->stats.numOverruns++;
        }
        
        // Notify all dependees that execution has ended
        for(int i = 0; i < t->numDependees; i++) {
            xTaskNotify(task_list[t->dependees[i]].task, 1 << (index + 1), eSetBits);
        }
    }
    
    t->isActive = 0;
    
    // Block until the value in the notification matches the dependencesMask
    // Or, in the case of a sporadic task without dependences, block until a precedence restriction is declared 
    while((notifyValue != t->dependencesMask) || t->dependencesMask == 0) {
        xTaskNotifyWait(pdFALSE,pdFALSE,&notifyValue,portMAX_DELAY);
    }
    // Clear the notification value
    ulTaskNotifyValueClear(t->task, 0xffffffff);
    
    t->isActive = 1;
    t->lastActivationTime = current_tick;
    t->stats.numActivations++;
    
    return 0;
}

TMAN_Stats TMAN_TaskStats(int index) {
    return task_list[index].stats;
}

TMANTick_t TMAN_GetTicks() {
    return current_tick;
}

// --- Auxiliary ---

// Search for cycles introduced by a new precedence: precedenceIndex depends on index, using iterative DFS
// returns 1 (true) if there is a cycle
int PrecedenceCycleDetection(int index, int precedenceIndex) {

    if (index == precedenceIndex) { // task can't depend on itself
        return 1;
    }
    
    int N = task_list_len;

    int visited[N]; // visited tasks (graph nodes)
    for(int i = 0; i < N; i++) visited[i] = 0;

    int stack[N]; // auxiliary stack
    int stackHead = -1;

    // push
    stackHead++;
    stack[stackHead] = precedenceIndex;

    while (stackHead >= 0) {
        // pop
        int current = stack[stackHead];
        stackHead--;

        if (!visited[current]) { // node not yet visited
            visited[current] = 1;
        }

        TMAN_Task *currTask = &(task_list[current]);

        for (unsigned int i = 0; i < currTask->numDependees; i++) { // search through all dependees of current node
            int depTask = currTask->dependees[i]; // dependee

            if (depTask == index) { // index already depends on precedenceIndex through dependees' subtree
                return 1;
            }

            if (!visited[depTask]) { // stack should never have the same task index twice because of visited
                // push
                stackHead++;
                stack[stackHead] = depTask;
            }
        }
    }

    return 0; // no cyclic precedence found
}


