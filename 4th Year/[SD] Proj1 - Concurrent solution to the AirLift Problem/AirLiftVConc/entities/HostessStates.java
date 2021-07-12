package entities;

/**
 *    Definition of the internal states of the hostess during his life cycle.
 */

public final class HostessStates
{
    /**
     * Hostess is sleeping while waits for the arrival of the next plane
     */

    public static final int WAIT_FOR_NEXT_FLIGHT = 0;

    /**
     * Hostess is sleeping while waits for the arrival of a passenger at the queue
     */

    public static final int WAIT_FOR_PASSENGER = 1;

    /**
     * Hostess is sleeping while waits for the passenger to start showing their documents
     */

    public static final int CHECK_PASSENGER = 2;

    /**
     * Hostess notifies the pilot that the plane is ready to fly
     */

    public static final int READY_TO_FLY = 3;
    
    /**
     *   It can not be instantiated.
     */

    private HostessStates ()
    { }
}