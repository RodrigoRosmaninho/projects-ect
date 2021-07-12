package entities;

/**
 *    Definition of the internal states of the Pilot during his life cycle.
 */

public final class PilotStates
{
    /**
     *	The pilot has arrived to the Departure Airport and is at the Transfer Gate.	
     */

    public static final int AT_TRANSFER_GATE = 0;

    /**
     *	The pilot is announcing the plane is ready for boarding.
     */

    public static final int READY_FOR_BOARDING = 1;

    /**
     *	The pilot is waiting for all passengers to board the plane.
     */

    public static final int WAIT_FOR_BOARDING = 2;

    /**
     *	The Pilot is flying the plane from the Departure Airport to the Destination Airport.
     */

    public static final int FLYING_FORWARD = 3;

    /**
     *	The Pilot is waiting for all the passengers to exit the plane for the Destination Airport.
     */

    public static final int DEBOARDING = 4;

    /**
     *	The Pilot is flying the plane from the Destination Airport to the Departure Airport.
     */

    public static final int FLYING_BACK = 5;

    /**
     *  Instantiation is not possible.
     */

    private PilotStates ()
    { }
}

