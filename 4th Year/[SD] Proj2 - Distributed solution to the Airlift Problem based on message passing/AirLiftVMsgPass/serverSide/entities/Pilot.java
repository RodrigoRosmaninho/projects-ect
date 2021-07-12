package serverSide.entities;


/**
 *   Pilot thread.
 *
 *   Used to simulate the Pilot life cycle.
 *   Static solution.
 */

public interface Pilot
{
	/**
     *   Set Pilot ID.
     *
     *     @param id Pilot Id
     */
	
    public void setPilotId (int id);

    /**
     *   Get Pilot ID.
     *
     *     @return pilot Id
     */
    
    public int getPilotId ();
    
    /**
     *   Set Pilot State.
     *
     *     @param state Pilot State
     */

    public void setPilotState (int state);
    
    /**
     *   Get Pilot State.
     *
     *     @return pilot state
     */
    
    public int getPilotState ();

}

