#ifndef _EXAMPLE_FILE_NAME_H    /* Guard against multiple inclusion */
#define _EXAMPLE_FILE_NAME_H
#endif


/* Standard includes. */
#include <stdio.h>
#include <string.h>

#include <xc.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "queue.h"

#include "structs.h"

/* App includes */
#include "../UART/uart.h"

int TMAN_Init(float factor);

int TMAN_Close();

int TMAN_TaskAdd(TaskFunction_t task, char * name, int priority);

int TMAN_TaskRegisterAttributes(int index, TMANTick_t period, TMANTick_t phase, TMANTick_t deadline);

int TMAN_TaskAddPrecedence(int index, int precedenceIndex);

int TMAN_TaskWaitPeriod(int index);

int TMAN_Start();

int PrecedenceCycleDetection(int index, int precedenceIndex);

TMANTick_t TMAN_GetTicks();

TMAN_Stats TMAN_TaskStats(int index);

