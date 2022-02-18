#include "FreeRTOS.h"
#include "task.h"

typedef uint32_t TMANTick_t;


typedef struct {
    uint32_t numActivations;
    uint32_t numOverruns;
} TMAN_Stats;

typedef struct {
    TaskHandle_t task;
    char * name;
    TMANTick_t period;
    TMANTick_t phase;
    TMANTick_t deadline;
    TMANTick_t lastActivationTime;
    TMAN_Stats stats;
    uint32_t dependencesMask;
    int numDependees;
    int dependees[31];
    int isActive;
    int isPeriodic;
} TMAN_Task;
