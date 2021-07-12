package entities;

import sharedRegions.*;


/**
 *   Hostess thread.
 *
 *   Used to simulate the Hostess life cycle.
 *   Static solution.
 */


public class Hostess extends Thread
{
	/**
	   *  Hostess identification.
	   */

    private int hostessId;

    
    /**
     *  Hostess State.
     */

    private int hostessState;

    
    /**
     *  Reference to the departure airport.
     */

    private final DepartureAirport da;
    
    
    /**
     *  Reference to the plane.
     */
    
    private final Plane pl;
    
    
    /**
     *  Reference to the general repository
     */
    
    private final GeneralRepos repos;

    /**
     *   Instantiation of a Hostess thread.
     *
     *     @param name thread name
     *     @param hostessId hostess id
     *     @param da reference to the departure airport
     *     @param pl reference to the plane
     *     @param repos reference to the general repository
     */

    public  Hostess(String name, int hostessId, DepartureAirport da, Plane pl,  GeneralRepos repos)
    {
        super (name);
        this.hostessId = hostessId;
        hostessState = HostessStates.WAIT_FOR_NEXT_FLIGHT;
        this.da = da;
        this.pl = pl;
        this.repos = repos;
    }

    
    /**
     *   Set Hostess id.
     *
     *     @param id Hostess id
     */

    public void setHostessId (int id)
    {
        hostessId = id;
    }

    
    /**
     *   Get Hostess id.
     *
     *     @return Hostess Id.
     */

    public int getHostessId ()
    {
        return hostessId;
    }

    
    
    /**
     *   Set Hostess state.
     *
     *     @param state Hostess state
     */

    public void setHostessState (int state)
    {
        hostessState = state;
    }


    /**
     *   Get Hostess state.
     *
     *     @return Hostess state.
     */
    
    public int getHostessState ()
    {
        return hostessState;
    }


    /**
     *   Life cycle of the hostess.
     *   
     *   Starts at the state wait_for_next_flight (waiting for the arrival of a plane)
     *   Ends when all the N passenger from the day have been checked and are ready to be sent to their destination (last plane sent)
     */

    @Override
    public void run () {
        while (hostessState == HostessStates.WAIT_FOR_NEXT_FLIGHT) {  //main cycle where hostess is waiting for the arrival of a plane to start deboarding
        	
			if(da.prepareForPassBoarding()) { // hostess sleeps for the next plane and then starts waiting for the passengers to enter the queue
				break;                        // if all the passenger have been checked then we break and end the life cycle
			}
			da.checkDocuments();			  // hostess is waken and then she calls the next passenger that is waiting in the queue to be checked
			while (true) { 					  // sub cycle while the plane can not fly
				if(da.waitForNextPassenger()) { // hostess now tests all the conditions to understand if she could send the next plane || needs to wait || needs to call the next passenger 
                	break;						// if the fly conditions are validated then we break the sub cycle
                }
				da.checkDocuments();		  //calls another passenger (hostess is waken and then she ... )
            }
		
        pl.informPlaneReadyToTakeOff();        // hostess wakes the pilot and notifies that the plane is ready to fly
        waitForNextFlight();                  //hostess prepares to wait for the next arrival
        }
    }

    
    
    /**
     *  Changes the Hostess State from ready_to_fly to wait_for_fight.
     *
     *  This function is called after the hostess sent the plane to the destination airport; 
     *  changes hostess to wait for the arrival of the next plane.
     */

    public void waitForNextFlight(){
        da.setPlaneReadyForBoarding(false);
        setHostessState(HostessStates.WAIT_FOR_NEXT_FLIGHT);
        repos.setHostessState (HostessStates.WAIT_FOR_NEXT_FLIGHT);
    }
}

