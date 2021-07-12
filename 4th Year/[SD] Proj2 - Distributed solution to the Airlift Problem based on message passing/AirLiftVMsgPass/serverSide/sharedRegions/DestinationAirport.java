package serverSide.sharedRegions;

import serverSide.entities.*;
import serverSide.stubs.GeneralReposStub;

/**
 *    Destination Airport.
 *
 *    Shared Region responsible for the update of the number of passengers, and the state of the planes that keep arriving 
 *    Implemented as an implicit monitor (synchronized methods).
 *    All public methods are executed in mutual exclusion.
 *    There are two internal synchronization points: 
 *    	blocking point for the pilot, where he sleeps while all the passengers leave the plane and arrive to the airport;
 *      blocking point for the passenger, where they wait for an update from the Pilot that they have arrived
 */

public class DestinationAirport
{
    /**
     *   Number of passengers that have arrived to the destination.
     */
	
	//private int number_of_pass_arrived;
	

	/**
     *   Reference to the General Repository.
     */
	
    private final GeneralReposStub repos;

    /**
     *  Destination Airport instantiation.
     *
     *    @param repos reference to the general repository
     */

    public DestinationAirport(GeneralReposStub repos)
    {
    	//number_of_pass_arrived = 0;
        this.repos = repos;
    }
    
    
    /**
     *  
     *  It is called by the pilot in order to fly back to the departure airport.
     *
     */
    
    public synchronized void flyToDeparturePoint()
    {
    	((Pilot) Thread.currentThread ()).setPilotState(PilotStates.FLYING_BACK);
        repos.setPilotState (PilotStates.FLYING_BACK);
        try
        { Thread.sleep ((long) (1 + 100 * Math.random ()));
        }
        catch (InterruptedException e) {}
    }
    
    

}
