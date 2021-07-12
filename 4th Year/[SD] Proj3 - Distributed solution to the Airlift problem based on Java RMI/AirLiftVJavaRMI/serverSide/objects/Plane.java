package serverSide.objects;

import java.rmi.RemoteException;

import clientSide.entities.HostessStates;
import clientSide.entities.PassengerStates;
import clientSide.entities.PilotStates;
import commInfra.ExecConst;
import commInfra.ReturnValue;
import genclass.GenericIO;
import interfaces.GeneralReposInterface;
import interfaces.PlaneInterface;
import serverSide.main.DepartureAirportMain;
import serverSide.main.PlaneMain;


/**
 *    Plane.
 *
 *    It is responsible for the the synchronization of the Pilot and Hostess during the boarding process
 *    and is implemented as an implicit monitor.
 *    
 *    There is one internal synchronization points: a single blocking point for the Pilot, where he waits for the Hostess to signal that all customers have boarded and the flight is ready to depart.
 */

public class Plane implements PlaneInterface
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

    private final GeneralReposInterface repos;
    
    /**
     *   Number of entity groups requesting the shutdown.
     */
    
    private int nEntities;

    /**
     *  Plane instantiation.
     *  
     *  @param reposStub Reference to the General Information Repository Stub
     */

    public Plane (GeneralReposInterface reposStub)
    {
        this.repos = reposStub;
        this.n_passengers = 0;
        nEntities = 0;
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
    
    public synchronized ReturnValue announceArrival() 
    {
        this.arrived = true;
        try {
			repos.setPilotState (PilotStates.DEBOARDING);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        notifyAll();

        while(n_passengers != 0){
            try {
                wait();
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        this.arrived = false;
        return new ReturnValue(false, PilotStates.DEBOARDING);
    }
    
    
    /**
     *  
     *  It is called by a passenger when he is waked by the pilot and needs to leave the plane.
     *
     */
    
    public synchronized ReturnValue leaveThePlane(int passId) 
    {
    	n_passengers -= 1;
    	try {
	        repos.updatePassengersInPlane (-1);
	        repos.updatePassengersArrived (1);
	        repos.setPassengerState (passId, PassengerStates.AT_DESTINATION);
	    } catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        notifyAll();
        return new ReturnValue(false, PassengerStates.AT_DESTINATION);
    }

    /**
     *   Transitions the hostess from the 'wait for passenger' state to the 'ready to fly' state and awakens the pilot
     */
    
    public synchronized ReturnValue informPlaneReadyToTakeOff()
    {
    	
    	// Set state
        try {
			repos.setHostessState (HostessStates.READY_TO_FLY);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        // Set flag and wake pilot
        setPlaneReadyToTakeOff(true);
        notifyAll();
        return new ReturnValue(false, HostessStates.READY_TO_FLY);
    }

    /**
     *   Transitions the pilot from the 'ready for boarding' state to the 'waiting for boarding' state and sleeps while waiting for the hostess to signal that the plane is ready to depart
     */

    public synchronized ReturnValue waitForAllOnBoard()
    {
    	// Set state
        try {
			repos.setPilotState (PilotStates.WAIT_FOR_BOARDING);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
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
        return new ReturnValue(false, PilotStates.WAIT_FOR_BOARDING);
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
    
    /**
     *   Operation server shutdown.
     *
     *   New operation.
     *
     *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
     *                             service fails
     */
    
    public synchronized void shutdown () throws RemoteException
    {
        nEntities += 1;
        if (nEntities >= ExecConst.E_Plane) {
        	
	        try
	    	{ repos.shutdown();
	    	}
	    	catch (RemoteException e)
	    	{ GenericIO.writelnString ("Customer generator remote exception on GeneralRepos shutdown: " + e.getMessage ());
	          System.exit (1);
	    	}
	        PlaneMain.shutdown ();
        }
        notifyAll ();                                       // the barber may now terminate
    }
}

