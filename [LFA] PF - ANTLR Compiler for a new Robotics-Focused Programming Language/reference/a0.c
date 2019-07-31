#include "CiberAV.h"

#include <stdio.h>

void gotoBeacon(int bn)
{
	/* rotating until facing target */
    while (beaconAngle(bn) < -10 || beaconAngle(bn) > 10)
    {
        motors(-80, 80);
        apply(1);
    }

    /* going to target, adjusting orientation if necessary */
	while (groundType() != bn)
	{
        if (beaconAngle(bn) < -5)
        {
            motors(80, 70);
        }
        else if (beaconAngle(bn) > 5)
        {
            motors(70, 80);
        }
        else
        {
            motors(80,80);
        }

		apply(1);
	}

    /* stopping */
    motors(0, 0);
    apply(5);
}

void gotoStart()
{
}

int main()
{
	/* connecting to server */
	init("Grimmy bear", 0);

    /* go to beacon number 1 */
    gotoBeacon(1);

	/* picking up its stone */
	pickup();
	
	/* anouncing the returning */
	returning();
	
    /* return to start position */
    gotoStart();
    	    	
	/* anouncing the end of the run */
	finish();
	
	/* ending the program */
	printStr("Bye!");
	return 0;
}

