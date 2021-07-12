package clientSide.entities;

import clientSide.stubs.DepartureAirportStub;
import clientSide.stubs.DestinationAirportStub;
import clientSide.stubs.PlaneStub;


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
    
    private final DepartureAirportStub da;
    
    /**
     *  Reference to the plane.
     */
    
    private final PlaneStub pl;
    


    /**
     *   Instantiation of a passenger thread.
     *
     *     @param name thread name
     *     @param passengerId passenger id
     *     @param da reference to the departure airport
     *     @param pl reference to the plane
     */

    public Passenger(String name, int passengerId, DepartureAirportStub da, PlaneStub pl)
    {
        super (name);
        this.passengerId = passengerId;
        passengerState = PassengerStates.GOING_TO_AIRPORT;
        this.da = da;
        this.pl = pl;
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
        da.waitInQueue();				//Passenger enters the queue and then waits for is turn to be checked
        da.showDocuments();				//Passenger starts preparing to show his documents to the hostess, waking her when this thread is ready
        da.boardThePlane();			    //Passenger goes to the plane after the end of the check stage
        pl.waitForEndOfFlight();		//Passenger sleeps while the plane has not arrived the destination airport
        pl.leaveThePlane();				//Passenger wakes up, and leaves the plane, arriving also to the destination airport
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

