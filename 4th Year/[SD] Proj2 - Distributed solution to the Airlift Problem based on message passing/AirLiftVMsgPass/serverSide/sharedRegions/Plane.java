package serverSide.sharedRegions;

import serverSide.entities.*;
//import genclass.GenericIO;
import serverSide.stubs.GeneralReposStub;

/**
 *    Plane.
 *
 *    It is responsible for the the synchronization of the Pilot and Hostess during the boarding process
 *    and is implemented as an implicit monitor.
 *    
 *    There is one internal synchronization points: a single blocking point for the Pilot, where he waits for the Hostess to signal that all customers have boarded and the flight is ready to depart.
 */

public class Plane
{
    /**
     *   Boolean flag that indicates if the plane is ready to depart.
     */

    private boolean planeReadyToTakeOff;
    
    /**
     *   Flag to inform if a plane has arrived to the airport.
     */
	
	private boolean arrived;
	
	/**
     *   .
     */

	private int n_passengers;

    /**
     *   Reference to the General Information Repository.
     */

    private final GeneralReposStub repos;

    /**
     *  Plane instantiation.
     *  
     *  @param repos Reference to the General Information Repository Stub
     */

    public Plane (GeneralReposStub repos)
    {
        this.repos = repos;
        this.n_passengers = 0;
    }
    
    
    /**
     *  
     *  It is called by the passengers to synchronize their thread sleeps with the arrival of the plane to the destination
     *
     */
    
    public synchronized void waitForEndOfFlight() 
    {
    	n_passengers += 1;
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

        while(n_passengers != 0 ){
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
     *  It is called by a passenger when he is waked by the pilot and needs to leave the plane.
     *
     */
    
    public synchronized void leaveThePlane() 
    {
    	n_passengers -= 1;
        ((Passenger) Thread.currentThread ()).setPassengerState(PassengerStates.AT_DESTINATION);
        repos.updatePassengersInPlane (-1);
        repos.updatePassengersArrived (1);
        repos.setPassengerState (((Passenger) Thread.currentThread ()).getPassengerId(), PassengerStates.AT_DESTINATION);

        notifyAll();
    }

    /**
     *   Transitions the hostess from the 'wait for passenger' state to the 'ready to fly' state and awakens the pilot
     */
    
    public synchronized void informPlaneReadyToTakeOff()
    {
    	
    	// Set state
    	((Hostess) Thread.currentThread ()).setHostessState(HostessStates.READY_TO_FLY);
        repos.setHostessState (HostessStates.READY_TO_FLY);
        
        // Set flag and wake pilot
        setPlaneReadyToTakeOff(true);
        notifyAll();
    }

    /**
     *   Transitions the pilot from the 'ready for boarding' state to the 'waiting for boarding' state and sleeps while waiting for the hostess to signal that the plane is ready to depart
     */

    public synchronized void waitForAllOnBoard()
    {
    	// Set state
        ((Pilot) Thread.currentThread ()).setPilotState(PilotStates.WAIT_FOR_BOARDING);
        repos.setPilotState (PilotStates.WAIT_FOR_BOARDING);
        
        // Sleep while waiting for the hostess to signal that the plane is ready to depart
        while(!planeReadyToTakeOff)
        {
            try {
                wait();
            } catch (InterruptedException e) {
            	e.printStackTrace();
            }
        }
        
        // Reset flag
        planeReadyToTakeOff = false;
    }


    /**
     *   Set Plane Ready To Take Off Flag.
     *
     *     @param b Plane Ready To Take Off
     */
    
    public synchronized void setPlaneReadyToTakeOff(boolean b){ planeReadyToTakeOff = b; }

    /**
     *   Get Plane Ready To Take Off Flag.
     *
     *     @return Plane Ready To Take Off
     */
    
    public boolean getPlaneReadyToTakeOff(){ return planeReadyToTakeOff; }
    
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

