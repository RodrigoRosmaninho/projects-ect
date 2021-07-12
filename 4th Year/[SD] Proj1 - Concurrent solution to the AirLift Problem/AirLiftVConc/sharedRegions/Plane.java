package sharedRegions;

import entities.*;
//import genclass.GenericIO;

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
     *   Reference to the General Information Repository.
     */

    private final GeneralRepos repos;

    /**
     *  Plane instantiation.
     *
     *    @param repos reference to the General Information Repository
     */

    public Plane (GeneralRepos repos)
    {
        this.repos = repos;
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
}

