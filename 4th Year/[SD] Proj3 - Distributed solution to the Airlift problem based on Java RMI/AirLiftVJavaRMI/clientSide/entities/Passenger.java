package clientSide.entities;


import java.rmi.RemoteException;

import commInfra.ReturnValue;
import genclass.GenericIO;
import interfaces.DepartureAirportInterface;
import interfaces.PlaneInterface;


/**
 *   Passenger thread.
 *
 *   Used to simulate the Passenger life cycle.
 *   Static solution.
 */


public class Passenger extends Thread
{

	/**
	 *  Passenger identification.
	 */
	
    private int passengerId;
    
    
    /**
     *  Passenger State.
     */
    
    private int passengerState;
    

    /**
     *  Reference to the departure airport.
     */
    
    private final DepartureAirportInterface daStub;
    
    /**
     *  Reference to the plane.
     */
    
    private final PlaneInterface plStub;
    


    /**
     *   Instantiation of a passenger thread.
     *
     *     @param name thread name
     *     @param passengerId passenger id
     *     @param da reference to the departure airport
     *     @param pl reference to the plane
     */

    public Passenger(String name, int passengerId, DepartureAirportInterface da, PlaneInterface pl)
    {
        super (name);
        this.passengerId = passengerId;
        passengerState = PassengerStates.GOING_TO_AIRPORT;
        this.daStub = da;
        this.plStub = pl;
    }

    
    /**
     *   Set Passenger id.
     *
     *     @param id Passenger id
     */

    public void setPassengerId (int id)
    {
        passengerId = id;
    }

    
    /**
     *   Get Passenger id.
     *
     *     @return Passenger Id.
     */

    public int getPassengerId ()
    {
        return passengerId;
    }
    
    
    /**
     *   Set Passenger state.
     *
     *     @param state Passenger state
     */

    public void setPassengerState (int state)
    {
        passengerState = state;
    }

    
    /**
     *   Get Passenger state.
     *
     *     @return Passenger State.
     */

    public int getPassengerState ()
    {
        return passengerState;
    }


    /**
     *   Life cycle of the passenger.
     */

    @Override
    public void run ()
    {
        travelToAirport();				//Passenger takes some time to arrive to the departure airport
        waitInQueue();				//Passenger enters the queue and then waits for is turn to be checked
        showDocuments();				//Passenger starts preparing to show his documents to the hostess, waking her when this thread is ready
        boardThePlane();			    //Passenger goes to the plane after the end of the check stage
        waitForEndOfFlight();		//Passenger sleeps while the plane has not arrived the destination airport
        leaveThePlane();				//Passenger wakes up, and leaves the plane, arriving also to the destination airport
    }

    /**
     *
     *Method called at the start of the life cycle of the passenger in order to simulate a random traveling time between his home and the departure airport.
     *
     */
    private void waitInQueue() {
    	ReturnValue ret = null;
    	try
        { ret = daStub.waitInQueue(this.passengerId);
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.passengerState = ret.getStateValue();
    }
    
    /**
     *   Wakes the Hostess to signal that the documents were shown and sleeps while waiting for the hostess to validate them
     */
    
    private void showDocuments() {
    	try
        { daStub.showDocuments(this.passengerId);
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    }
    
    /**
     *	 Transitions the Passenger from the 'in queue' state to the 'in flight' state and awakens the hostess
     */
    
    private void boardThePlane() {
    	ReturnValue ret = null;
    	try
        { ret = daStub.boardThePlane(passengerId);
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.passengerState = ret.getStateValue();
    }
    
    /**
     *  
     *  It is called by the passengers to synchronize their thread sleeps with the arrival of the plane to the destination
     *
     */
    
    private void waitForEndOfFlight() {
    	try
        { plStub.waitForEndOfFlight();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    }
    
    /**
     *  
     *  It is called by a passenger when he is waked by the pilot and needs to leave the plane.
     *
     */
    
    private void leaveThePlane() {
    	ReturnValue ret = null;
    	try
        { ret = plStub.leaveThePlane(passengerId);
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.passengerState = ret.getStateValue();
    }
    
    
    /**
    *
    *Method called at the start of the life cycle of the passenger in order to simulate a random traveling time between his home and the departure airport.
    *
    */

    private void travelToAirport()
    {
        try
        { sleep ((long) (1 + 30000 * Math.random ()));
        }
        catch (InterruptedException e) {}
    }


}

