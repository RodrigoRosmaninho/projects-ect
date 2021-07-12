package entities;

import sharedRegions.*;


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
     *  Passenger Flag for the hostess inform that this thread is the next to be checked.
     */
    
    private boolean selected;
    
    
    /**
     *  Passenger Flag to inform the hostess the this thread is ready to show the documents needed.
     */
    
    private boolean endedShow;
    
    
    /**
     *  Passenger Flag for the hostess inform that this thread was already checked (ended check stage).
     */
    
    private boolean wasChecked;

    
    /**
     *  Reference to the departure airport.
     */
    
    private final DepartureAirport da;
    
    
    
    /**
     *  Reference to the destination airport.
     */

    private final DestinationAirport dta;

    /**
     *   Instantiation of a passenger thread.
     *
     *     @param name thread name
     *     @param passengerId passenger id
     *     @param da reference to the departure airport
     *     @param dta reference to the destination airport
     */

    public Passenger(String name, int passengerId, DepartureAirport da, DestinationAirport dta)
    {
        super (name);
        this.passengerId = passengerId;
        passengerState = PassengerStates.GOING_TO_AIRPORT;
        this.da = da;
        this.dta = dta;
        selected = false;
        endedShow = false;
        wasChecked = false;
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
     *   Get flag to know if this Passenger was selected by the hostess as the next to be checked.
     *
     *     @return Passenger Selected boolean.
     */

    public boolean getSelected(){ return selected;}
    
    
    /**
     *   Set flag to inform this Passenger when he wakes up that was chose to be checked.
     *
     *     @param s boolean
     */

    public void setSelected(boolean s){ selected = s;}
    
    
    /**
     *   Get flag to know if this Passenger ended the showing stage and then is ready to be checked.
     *
     *     @return Passenger EndedShow boolean.
     */

    public boolean getEndedShow(){ return endedShow;}
    
    
    /**
     *   Set flag to inform the hostess that this passenger is ready to be checked.
     *
     *     @param b boolean
     */

    public void setEndedShow(boolean b) { endedShow = b; }
    
    /**
     *  Get flag to know if this Passenger ended the checking stage and is now ready to go to the plane.
     *
     *     @return Passenger wasChecked boolean.
     */

    public boolean getWasChecked(){ return wasChecked;}
    
    
    /**
     *   Set flag to inform this Passenger when he wakes up that he was already checked.
     *
     *     @param b boolean
     */

    public void setWasChecked(boolean b) { wasChecked = b; }

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
        dta.waitForEndOfFlight();		//Passenger sleeps while the plane has not arrived the destination airport
        dta.leaveThePlane();			//Passenger wakes up, and leaves the plane, arriving also to the destination airport
    }

    /**
     *
     *Method called at the start of the life cycle of the passenger in order to simulate a random traveling time between his home and the departure airport.
     *
     */

    private void travelToAirport()
    {
        try
        { sleep ((long) (1 + 100 * Math.random ()));
        }
        catch (InterruptedException e) {}
    }


}
