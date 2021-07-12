package commInfra;

/**
 *    Definition of the simulation parameters.
 */

public final class ExecConst
{
    /**
     *   Max Number of Passengers that a Plane can have.
     */

    public static final int MAX = 10;

    /**
     *   Min Number of Passengers that a Plane need to have in order to start flying.
     */

    public static final int MIN = 5;

    /**
     *   Number of Passengers that will arrive during the day.
     */

    public static final int N = 21;


    /**
     *   Number of entities requesting shutdown.
     */

     public static final int E_DepAir = 3;
     
	 /**
	  *   Number of entities requesting shutdown.
	  */
	
	  public static final int E_Plane = 3;
	  
	  /**
	   *   Number of entities requesting shutdown.
	   */
	
	   public static final int E_DestAir = 1;
	   
	   /**
	    *   Number of entities requesting shutdown.
	    */
	
	    public static final int E_Repos = 3;
    
    /**
     *   It can not be instantiated.
     */
    
    
    
    private ExecConst ()
    { }
}
