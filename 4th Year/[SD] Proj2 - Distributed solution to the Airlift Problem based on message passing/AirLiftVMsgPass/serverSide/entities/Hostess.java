package serverSide.entities;



/**
 *   Hostess thread.
 *
 *   Used to simulate the Hostess life cycle.
 *   Static solution.
 */


public interface Hostess
{  
    /**
     *   Set Hostess id.
     *
     *     @param id Hostess id
     */

    public void setHostessId (int id);

    
    /**
     *   Get Hostess id.
     *
     *     @return Hostess Id.
     */

    public int getHostessId ();

    
    
    /**
     *   Set Hostess state.
     *
     *     @param state Hostess state
     */

    public  void setHostessState (int state);


    /**
     *   Get Hostess state.
     *
     *     @return Hostess state.
     */
    
    public int getHostessState ();
}

