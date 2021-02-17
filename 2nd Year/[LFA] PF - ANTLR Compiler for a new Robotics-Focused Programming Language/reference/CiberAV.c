/* CiberAV08.c
 *
 * Interface ciber para a academia de verão de 2008.
 *
 * For more information about the CiberRato Robot Simulator 
 * please see http://microrato.ua.pt/ or contact us.
 */
#include "CiberAV.h"

#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <math.h>

#include "RobSock.h"

int i = 0;

static int __x0_, __y0_;


void printStr(char *s)
{
    fprintf(stdout, "%s", s); fflush(stdout);
}

void printValue(int v)
{
    fprintf(stdout, "%d", v); fflush(stdout);
}

int posX()
{
    return (int)(100.0*GetX()+0.5);
}

int posY()
{
    return (int)(100.0*GetY()+0.5);
}

void init(const char *name, int pos)
{
    init2(name, pos, "localhost");
}

void init2(const char *name, int pos, const char *host)
{
    /* connect to server/simulator */
    if (InitRobot((char*)name, pos, (char*)host) == -1)
    {
       fprintf(stderr, "Robô \"%s\" falhou a conexão ao simulador\n", name); 
        exit(1);
    }
    printf( "Robô \"%s\" connectado\n", name);

	/* print simulation parameters */
	ReadSensors();
	fprintf(stdout, "Tempo de ciclo = %d\n"
		"Nível de ruído nos motores = %g\n", 
		GetCycleTime(), GetNoiseMotors());
    __x0_ = posX();
    __y0_ = posY();

	/* wait for start signal */
	while (!GetStartButton())
	{
		ReadSensors();
	}
}

void apply(int time)
{
    //struct timeval tv0;
    //gettimeofday(&tv0, NULL);
	int cnt = (int)((100.0/GetCycleTime())*time + 0.5);
	while (cnt)
	{
		ReadSensors();
		cnt--;
	}
    //struct timeval tv1;
    //gettimeofday(&tv1, NULL);
    //fprintf(stdout, "tempo efectivamente transcorrido = %ld x 0,1 s\n", 
    //    (tv1.tv_sec - tv0.tv_sec) * 10 + (tv1.tv_usec - tv0.tv_usec) / 1000000);
}

int leftP = 0;
int rightP = 0;

void motors(int left, int right)
{
	if (left < -150) left = -150; else if (left > 150) left = 150;
	if (right < -150) right = -150; else if (right > 150) right = 150;
	DriveMotors(left/1000.0, right/1000.0);
    leftP = left;
    rightP = right;
}

void pickup()
{
    SetVisitingLed(1);
    motors(0,0);
    ReadSensors();
    SetVisitingLed(0);
    motors(leftP, rightP);
}

void returning()
{
    SetReturningLed(1);
}

void finish()
{
    Finish();
}

int obstacleDistance(int id)
{
    return (int)(100.0 * (1.0/GetObstacleSensor(id)) + 0.5);
}

int beaconAngle(int id)
{
    struct beaconMeasure bm = GetBeaconSensor(id-1);
    return (int)(bm.beaconDir+0.5);    
}

int northAngle()
{
    return (int)(GetCompassSensor()+0.5);
}

int groundType()
{
    return GetGroundSensor()+1;
}

bool onTarget(int id)
{
    return GetGroundSensor() == (id-1);
}

int numberOfBeacons()
{
	return GetNumberOfBeacons();
}

int ang(int x1, int y1, int x2, int y2)
{
    int dx = x2-x1;
    int dy = y2-y1;
    if (dx == 0 && dy == 0) return 0;
    return (int)(atan2(dy, dx)*180.0/M_PI + 0.5);
}

int startAngle()
{
    int theta1 = ang(posX(), posY(), __x0_, __y0_);
    int theta2 = GetCompassSensor();
    int theta = theta1 - theta2;
    if (theta > 180) theta -= 360;
    else if (theta < -180) theta += 360;
    return theta;
}

int startDistance()
{
    int dx = posX() - __x0_;
    int dy = posY() - __y0_;
    int dist = (int)(sqrt(dx*dx + dy*dy)+0.5);
    return dist;
}


