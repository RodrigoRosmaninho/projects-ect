package clientSide.entities;

import java.rmi.RemoteException;

import commInfra.ReturnValue;
import interfaces.DepartureAirportInterface;
import interfaces.PlaneInterface;


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
    
    private final DepartureAirportInterface daStub;
    
    /**
     *  Reference to the plane.
     */
    
    private final PlaneInterface plStub;
    

    /**
     *   Instantiation of a Hostess thread.
     *
     *     @param name thread name
     *     @param hostessId hostess id
     *     @param daStub reference to the departure airport
     *     @param plStub reference to the plane
     */

    public Hostess(String name, int hostessId, DepartureAirportInterface daStub, PlaneInterface plStub)
    {
        super(name);
        this.hostessId = hostessId;
        hostessState = HostessStates.WAIT_FOR_NEXT_FLIGHT;
        this.daStub = daStub;
        this.plStub = plStub;
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
        	
			if(prepareForPassBoarding()) { // hostess sleeps for the next plane and then starts waiting for the passengers to enter the queue
				break;                        // if all the passenger have been checked then we break and end the life cycle
			}
			checkDocuments();			  // hostess is waken and then she calls the next passenger that is waiting in the queue to be checked
			while (true) { 					  // sub cycle while the plane can not fly
				if(waitForNextPassenger()) { // hostess now tests all the conditions to understand if she could send the next plane || needs to wait || needs to call the next passenger 
                	break;						// if the fly conditions are validated then we break the sub cycle
                }
				checkDocuments();		  //calls another passenger (hostess is waken and then she ... )
            }
		
        informPlaneReadyToTakeOff();        // hostess wakes the pilot and notifies that the plane is ready to fly
        waitForNextFlight();                  //hostess prepares to wait for the next arrival
        }
    }
    
    /**
     *   Sleeps while waiting for the pilot to signal the plane is ready for boarding, then transitions the Hostess from the 'wait for flight' state to the 'wait for passenger' state, and sleeps while waiting to be called by an arriving passenger
     *   
     *     @return Flag that specifies whether to terminate the Hostess thread (true) or not (false)
     */
    
    private boolean prepareForPassBoarding() {
    	ReturnValue ret = null;
    	try
        { ret = daStub.prepareForPassBoarding();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.hostessState = ret.getStateValue();
    	return ret.getBooleanValue();
    }
    
    /**
     *	 Dequeues a Passenger, transitions the Hostess from the 'wait for passenger' state to the 'check passenger' state, awakens the passenger, and sleeps while waiting for the passenger to show the requested documents.
     */
    
    private void checkDocuments() {
    	ReturnValue ret = null;
    	try
        { ret = daStub.checkDocuments();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.hostessState = ret.getStateValue();
    }
    
    /**
     *	 Transitions the Hostess from the 'check passenger' state to the 'wait for passenger' state and wakes up the passenger that was just validated.
     *   Also verifies if either:
     *   1 - the queue is empty and the number of passengers aboard the plane allows for the flight to begin
     *   2 - the plane is full
     *   3 - the plane is not full and the queue is not empty
     *   If neither of these conditions are met, sleeps while waiting for either a checked in passenger to board the plane or for a new passenger to arrive to the airport queue.
     *   
     *     @return Flag that specifies whether to call the informPlaneReadyToTakeOff operation (true) or the checkDocuments operation (false)
     */
    
    private boolean waitForNextPassenger() {
    	ReturnValue ret = null;
    	try
        { ret = daStub.waitForNextPassenger();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.hostessState = ret.getStateValue();
    	return ret.getBooleanValue();
    }
    
    /**
     *   Transitions the pilot from the 'at transfer gate' state to the 'ready for boarding' state and awakens the hostess
     */
    
    private void informPlaneReadyToTakeOff() {
    	ReturnValue ret = null;
    	try
        { ret = plStub.informPlaneReadyToTakeOff();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.hostessState = ret.getStateValue();
    }
    
    /**
    *
    *Method called at the start of the life cycle of the passenger in order to simulate a random traveling time between his home and the departure airport.
    *
    */
    
    private void waitForNextFlight() {
    	ReturnValue ret = null;
    	try
        { ret = daStub.waitForNextFlight();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.hostessState = ret.getStateValue();
    }
    
    


}


