package sharedRegions;

import entities.*;

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
	
	private int number_of_pass_arrived;
	
	
	/**
     *   Flag to inform if a plane has arrived to the airport.
     */
	
	private boolean arrived;
	
	
	/**
     *   Reference to the General Repository.
     */
	
    private final GeneralRepos repos;

    /**
     *  Destination Airport instantiation.
     *
     *    @param repos reference to the general repository
     */

    public DestinationAirport (GeneralRepos repos)
    {
    	number_of_pass_arrived = 0;
        this.repos = repos;
    }
    
    /**
     *  
     *  It is called by the pilot to inform all the passengers that the plane has arrived to the destination
     *  and then the pilot waits for all the passengers to leave in order to take the plane back
     *
     */
    
    public synchronized  void announceArrival()
    {
        this.arrived = true;
        ((Pilot) Thread.currentThread ()).setPilotState(PilotStates.DEBOARDING);
        repos.setPilotState (PilotStates.DEBOARDING);
        notifyAll();

        while(number_of_pass_arrived != ((Pilot) Thread.currentThread ()).getNumberOfPassCheckedTotal()){
            try {
                wait();
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        this.arrived = false;
    }
    
    /**
     *  
     *  It is called by the passengers to synchronize their thread sleeps with the arrival of the plane to the destination
     *
     */
    
    public synchronized void waitForEndOfFlight()
    {
        while ( !(getArrived()) ){
            try {
                wait();
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    /**
     *  
     *  It is called by a passenger when he is waked by the pilot and needs to leave the plane.
     *
     */
    
    public synchronized void leaveThePlane()
    {
        number_of_pass_arrived++;

        ((Passenger) Thread.currentThread ()).setPassengerState(PassengerStates.AT_DESTINATION);
        repos.updatePassengersInPlane (-1);
        repos.updatePassengersArrived (1);
        repos.setPassengerState (((Passenger) Thread.currentThread ()).getPassengerId(), PassengerStates.AT_DESTINATION);

        notifyAll();
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
    
    /**
     *   Get flag to know if a plane has arrived.
     *
     *     @return Arrived boolean.
     */
    
    public synchronized boolean getArrived(){ return arrived; }

    /**
     *   Set flag to inform that a plane just arrived to the airport.
     *
     *     @param b boolean
     */
    
    public synchronized void setArrived(boolean b){ arrived = b;}

}
