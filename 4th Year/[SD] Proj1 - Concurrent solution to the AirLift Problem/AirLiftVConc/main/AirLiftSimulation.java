package main;

import entities.*;
import sharedRegions.*;
//import genclass.GenericIO;
//import genclass.FileOp;

/**
 *   Simulation of the Assignment 1 - AirLiftSimulation.
 *   Static solution Attempt (number of threads controlled by global constants - ExecConst)
 */

public class AirLiftSimulation
{
    /**
     *    Main method.
     *
     *    @param args runtime arguments
     */

    public static void main (String [] args)
    {
        Pilot pilot;												//Reference to the Pilot Thread
        Hostess hostess;											//Reference to the Hostess Thread
        Passenger[] passenger = new Passenger[ExecConst.N];    		//array of references to the Passengers Threads
        DepartureAirport departureAirport;							//Reference to the Departure Airport
        Plane plane;												//Reference to the Plane
        DestinationAirport destinationAirport;						//Reference to the Destination Airport
        GeneralRepos repos;                             			//Reference to the General Repository

        System.out.println("AirLiftSimulation");
        /* problem initialization */
        repos = new GeneralRepos("logger");
        departureAirport = new DepartureAirport(repos);
        plane = new Plane(repos);
        destinationAirport = new DestinationAirport(repos);

        pilot = new Pilot("Pilot_1", 0, departureAirport, plane, destinationAirport, repos);
        hostess = new Hostess("Hostess_1", 0, departureAirport, plane, repos);
        for (int i = 0; i < ExecConst.N; i++)
            passenger[i] = new Passenger("Passenger_"+(i+1), i, departureAirport, destinationAirport);
        
        /* start of the simulation */
        pilot.start();
        hostess.start();
        for (int i = 0; i < ExecConst.N; i++)
        	passenger[i].start ();

        /* waiting for the end of the simulation */
        for (int i = 0; i < ExecConst.N; i++)
        { try
        { passenger[i].join ();
        }
        catch (InterruptedException e) {}
        System.out.println("The Passenger "+(i+1)+" just terminated");
        }
        
        try {
			pilot.join();
		} catch (InterruptedException e) {}
        System.out.println("The pilot has terminated");
        
        try {
        	hostess.join();	
		} catch (InterruptedException e) {}
        System.out.println("The hostess has terminated");
        
        repos.printSumUp();

        System.out.println("End of the Simulation");
    }
}

