package entities;

import sharedRegions.*;

/**
 *   Pilot thread.
 *
 *   Used to simulate the Pilot life cycle.
 *   Static solution.
 */

public class Pilot extends Thread
{

	/**
	 *  Pilot identification.
	 */    
	
	private int pilotId;

    /**
     *  Pilot State.
     */
    
    private int pilotState;
    
    /**
     *  Reference to the Plane.
     */

    private final Plane plane;
    
    /**
     *  Reference to the Departure Airport.
     */
    
    private final DepartureAirport departureAirport;
    
    /**
     *  Reference to the Destination Airport.
     */
    
    private final DestinationAirport destinationAirport;
    
    /**
     *  Reference to the General Information Repository.
     */
    
    private final GeneralRepos repos; 
    
    /**
     *  Total number of passengers checked.
     *  This variable is later used to determine if all checked in passengers are at the destination airport, thus letting the pilot know if the plane is empty and the return flight can begin.
     */
    
    private int number_of_pass_checked_total;

    /**
     *   Instantiation of a Pilot thread.
     *
     *     @param name thread name
     *     @param pilotId ID of the pilot
     *     @param departingAirport reference to the Departure Airport
     *     @param plane reference to the Plane
     *     @param destinationAirport reference to the Destination Airport
     *     @param repos reference to the General Information Repository
     */

    public Pilot (String name, int pilotId, DepartureAirport departingAirport, Plane plane, DestinationAirport destinationAirport, GeneralRepos repos)
    {
        super (name);
        this.pilotId = pilotId;
        pilotState = PilotStates.AT_TRANSFER_GATE;
        this.plane = plane;
        this.departureAirport = departingAirport;
        this.repos = repos;
        this.destinationAirport = destinationAirport;
        number_of_pass_checked_total = 0;
    }

    /**
     *   Set Pilot ID.
     *
     *     @param id Pilot Id
     */

    public void setPilotId (int id)
    {
        pilotId = id;
    }


    /**
     *   Get Pilot ID.
     *
     *     @return pilot Id
     */
    
    public int getPilotId ()
    {
        return pilotId;
    }
    
    /**
     *   Get Total Number of Passengers Checked
     *
     *     @return number of pass checked total
     */
    
    public int getNumberOfPassCheckedTotal() {
    	return number_of_pass_checked_total;
    }

    
    /**
     *   Set Pilot State.
     *
     *     @param state Pilot State
     */

    public void setPilotState (int state)
    {
        pilotState = state;
    }

    
    /**
     *   Get Pilot State.
     *
     *     @return pilot state
     */
    
    public int getPilotState ()
    {
        return pilotState;
    }

    /**
     *   Regulates the life cycle of the Pilot.
     */

    @Override
    public void run ()
    {
        while(true) {
        	// Transition to 'READY_FOR_BOARDING'
            departureAirport.informPlaneReadyForBoarding();
            // Transition to 'WAITING_FOR_BOARDING'
            plane.waitForAllOnBoard();
            // Transition to 'FLYING_FORWARD'
            flyToDestinationPoint();
            // Transition to "DEBOARDING"
            destinationAirport.announceArrival();
            // Transition to 'FLYING_BACK'
            destinationAirport.flyToDeparturePoint();
            // Transition to 'AT TRANSFER GATE'
            if (departureAirport.parkAtTransferGate()) break;
        }
    }

    /**
     *   Transitions the pilot from the 'waiting for boarding' state to the 'flying forward' state and sleeps for a randomly selected time.
     */
    
    public void flyToDestinationPoint()
    {
    	// Update a local variable with the total number of pilots checked in so far
    	// This variable is later used to determine if all checked in passengers are at the destination airport, thus letting the pilot know if the plane is empty and the return flight can begin
    	number_of_pass_checked_total += departureAirport.getNumberOfPassChecked();
    	
    	// Set FLYING_FORWARD State
        setPilotState(PilotStates.FLYING_FORWARD);
        repos.setPilotState (PilotStates.FLYING_FORWARD);
        
        // Sleep for randomly selected time to emulate the passage of time during the flight
        try
        { sleep ((long) (1 + 100 * Math.random ()));
        }
        catch (InterruptedException e) {}
    }

    


}

