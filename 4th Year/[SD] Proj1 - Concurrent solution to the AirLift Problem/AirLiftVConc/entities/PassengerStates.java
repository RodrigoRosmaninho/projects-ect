package entities;

/**
 *    Definition of the internal states of the barber during his life cycle.
 */

public final class PassengerStates
{
    /**
     * Passenger takes some time to arrive to the airport
     */

    public static final int GOING_TO_AIRPORT = 0;

    /**
     * Passenger is sleeping while waits for the hostess to select him and wake him
     */

    public static final int IN_QUEUE = 1;

    /**
     * Passenger is sleeping at the plane while waits for the pilot to wake him and inform him that they arrived to the destination
     */

    public static final int IN_FLIGHT = 2;

    /**
     * Passenger arrives the destination airport
     */

    public static final int AT_DESTINATION = 3;

    /**
     *   It can not be instantiated.
     */

    private PassengerStates ()
    { }
}

