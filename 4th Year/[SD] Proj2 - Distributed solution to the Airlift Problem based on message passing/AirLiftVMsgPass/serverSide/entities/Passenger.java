package serverSide.entities;



/**
 *   Passenger thread.
 *
 *   Used to simulate the Passenger life cycle.
 *   Static solution.
 */


public interface Passenger
{
	
	/**
     *   Set Passenger id.
     *
     *     @param id Passenger id
     */
	
    public void setPassengerId (int id);
    
    /**
     *   Get Passenger id.
     *
     *     @return Passenger Id.
     */
    
    public int getPassengerId ();

    /**
     *   Set Passenger state.
     *
     *     @param state Passenger state
     */
    
    public void setPassengerState (int state);

    /**
     *   Get Passenger state.
     *
     *     @return Passenger State.
     */

    public int getPassengerState ();
    
    
    /**
     *   Get flag to know if this Passenger was selected by the hostess as the next to be checked.
     *
     *     @return Passenger Selected boolean.
     */

    public boolean getSelected();
    
    
    /**
     *   Set flag to inform this Passenger when he wakes up that was chose to be checked.
     *
     *     @param s boolean
     */

    public void setSelected(boolean s);
    
    
    /**
     *   Get flag to know if this Passenger ended the showing stage and then is ready to be checked.
     *
     *     @return Passenger EndedShow boolean.
     */

    public boolean getEndedShow();
    
    
    /**
     *   Set flag to inform the hostess that this passenger is ready to be checked.
     *
     *     @param b boolean
     */

    public void setEndedShow(boolean b);
    
    /**
     *  Get flag to know if this Passenger ended the checking stage and is now ready to go to the plane.
     *
     *     @return Passenger wasChecked boolean.
     */

    public boolean getWasChecked();
    
    
    /**
     *   Set flag to inform this Passenger when he wakes up that he was already checked.
     *
     *     @param b boolean
     */

    public void setWasChecked(boolean b);

}
