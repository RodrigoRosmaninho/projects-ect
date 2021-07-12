package clientSide.entities;

import clientSide.entities.PilotStates;
import clientSide.stubs.*;

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

    private final PlaneStub plane;
    
    /**
     *  Reference to the Departure Airport.
     */
    
    private final DepartureAirportStub departureAirport;
    
    /**
     *  Reference to the Destination Airport.
     */
    
    private final DestinationAirportStub destinationAirport;
    
    
    /**
     *   Instantiation of a Pilot thread.
     *
     *     @param name thread name
     *     @param pilotId ID of the pilot
     *     @param departingAirport reference to the Departure Airport
     *     @param plane reference to the Plane
     *     @param destinationAirport reference to the Destination Airport
     */

    public Pilot (String name, int pilotId, DepartureAirportStub departingAirport, PlaneStub plane, DestinationAirportStub destinationAirport)
    {
        super (name);
        this.pilotId = pilotId;
        pilotState = PilotStates.AT_TRANSFER_GATE;
        this.plane = plane;
        this.departureAirport = departingAirport;
        this.destinationAirport = destinationAirport;
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
            departureAirport.flyToDestinationPoint();
            // Transition to "DEBOARDING"
            plane.announceArrival();
            // Transition to 'FLYING_BACK'
            destinationAirport.flyToDeparturePoint();
            // Transition to 'AT TRANSFER GATE'
            if (departureAirport.parkAtTransferGate()) break;
        }
        departureAirport.shutdown();
        plane.shutdown();
        destinationAirport.shutdown();
    }

   
   

    


}


