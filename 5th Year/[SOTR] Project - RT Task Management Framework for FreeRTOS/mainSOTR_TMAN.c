/*
 * Pedro Valério, nº 88734 
 * Rodrigo Rosmaninho, nº 88802
 *
 */

/* Standard includes. */
#include <stdio.h>
#include <string.h>

#include <xc.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"

/* App includes */
#include "../UART/uart.h"

#include "libtman.h"

#define MAXICOUNT 93
#define MAXJCOUNT 30


void taskA(void *pvParam)
{
    uint8_t message[80];
    int index = (int) pvParam;
    
    for(;;) {
        TMAN_TaskWaitPeriod(index);
        TickType_t currentTicks = xTaskGetTickCount();
        sprintf(message, "A, %d, %d\r\n", currentTicks, TMAN_TaskStats(index).numOverruns);
        PrintStr(message);

        int x = 2;
        for(int i = 0; i < MAXICOUNT; i++)
            for(int j = 0; j < MAXJCOUNT; j++)
                x++;
    }
}

void taskB(void *pvParam)
{
    uint8_t message[80];
    int index = (int) pvParam;

    for(;;) {
        TMAN_TaskWaitPeriod(index);
        TickType_t currentTicks = xTaskGetTickCount();
        sprintf(message, "B, %d\r\n", currentTicks);
        PrintStr(message);

        int x = 2;
        for(int i = 0; i < MAXICOUNT; i++)
            for(int j = 0; j < MAXJCOUNT; j++)
                x++;
    }
}

void taskC(void *pvParam)
{
    uint8_t message[80];
    int index = (int) pvParam;

    for(;;) {
        TMAN_TaskWaitPeriod(index);
        TickType_t currentTicks = xTaskGetTickCount();
        sprintf(message, "C, %d\r\n", currentTicks);
        PrintStr(message);

        int x = 2;
        for(int i = 0; i < MAXICOUNT; i++)
            for(int j = 0; j < MAXJCOUNT; j++)
                x++;
    }
}

void taskD(void *pvParam)
{
    uint8_t message[80];
    int index = (int) pvParam;

    for(;;) {
        TMAN_TaskWaitPeriod(index);
        TickType_t currentTicks = xTaskGetTickCount();
        sprintf(message, "D, %d\r\n", currentTicks);
        PrintStr(message);

        int x = 2;
        for(int i = 0; i < MAXICOUNT; i++)
            for(int j = 0; j < MAXJCOUNT; j++)
                x++;
    }
}

void taskE(void *pvParam)
{
    uint8_t message[80];
    int index = (int) pvParam;

    for(;;) {
        TMAN_TaskWaitPeriod(index);
        TickType_t currentTicks = xTaskGetTickCount();
        sprintf(message, "E, %d\r\n", currentTicks);
        PrintStr(message);

        int x = 2;
        for(int i = 0; i < MAXICOUNT; i++)
            for(int j = 0; j < MAXJCOUNT; j++)
                x++;
    }
}

void taskF(void *pvParam)
{
    uint8_t message[80];
    int index = (int) pvParam;

    for(;;) {
        TMAN_TaskWaitPeriod(index);
        TickType_t currentTicks = xTaskGetTickCount();
        sprintf(message, "F, %d\r\n", currentTicks);
        PrintStr(message);

        int x = 2;
        for(int i = 0; i < MAXICOUNT; i++)
            for(int j = 0; j < MAXJCOUNT; j++)
                x++;
    }
}


int mainTMAN( void )
{   
    // Init UART and redirect stdin/stdot/stderr to UART
    if(UartInit(configPERIPHERAL_CLOCK_HZ, 115200) != UART_SUCCESS) {
        PORTAbits.RA3 = 1; // If Led active error initializing UART
        while(1);
    }
    __XC_UART = 1; /* Redirect stdin/stdout/stderr to UART1*/
    
    printf("\nSTART\n");
    
    TMAN_Init(200);
    int indexA = TMAN_TaskAdd(taskA, "A", 4);
    int indexB = TMAN_TaskAdd(taskB, "B", 4);
    int indexC = TMAN_TaskAdd(taskC, "C", 3);
    int indexD = TMAN_TaskAdd(taskD, "D", 3);
    int indexE = TMAN_TaskAdd(taskE, "E", 2);
    int indexF = TMAN_TaskAdd(taskF, "F", 2);
    
    TMAN_TaskAddPrecedence(indexB, indexF);
    //TMAN_TaskAddPrecedence(indexC, indexA);
    //TMAN_TaskAddPrecedence(indexA, indexD);
    //TMAN_TaskAddPrecedence(indexE, indexF);
    
    TMAN_TaskRegisterAttributes(indexA, 1, 0, 0);
    TMAN_TaskRegisterAttributes(indexB, 1, 0, 0);
    TMAN_TaskRegisterAttributes(indexC, 3, 0, 0);
    TMAN_TaskRegisterAttributes(indexD, 3, 1, 0);
    TMAN_TaskRegisterAttributes(indexE, 4, 0, 0);
    TMAN_TaskRegisterAttributes(indexF, 4, 2, 0);
    
    //TMAN_TaskRegisterSporadic(indexC);

    printf("SCHED\n");
    TMAN_Start();
    vTaskStartScheduler();
    
    printf("END\n");
    
	return 0;
}