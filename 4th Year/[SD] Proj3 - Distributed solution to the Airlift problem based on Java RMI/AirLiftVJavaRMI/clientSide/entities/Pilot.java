package clientSide.entities;

import java.rmi.RemoteException;

import commInfra.ReturnValue;
import interfaces.DepartureAirportInterface;
import interfaces.DestinationAirportInterface;
import interfaces.PlaneInterface;

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

    private final PlaneInterface planeStub;
    
    /**
     *  Reference to the Departure Airport.
     */
    
    private final DepartureAirportInterface departureAirportStub;
    
    /**
     *  Reference to the Destination Airport.
     */
    
    private final DestinationAirportInterface destinationAirportStub;
    
    
    /**
     *   Instantiation of a Pilot thread.
     *
     *     @param name thread name
     *     @param pilotId ID of the pilot
     *     @param departingAirportStub reference to the Departure Airport
     *     @param planeStub reference to the Plane
     *     @param destinationAirportStub reference to the Destination Airport
     */

    public Pilot (String name, int pilotId, DepartureAirportInterface departingAirportStub, PlaneInterface planeStub, DestinationAirportInterface destinationAirportStub)
    {
        super (name);
        this.pilotId = pilotId;
        pilotState = PilotStates.AT_TRANSFER_GATE;
        this.planeStub = planeStub;
        this.departureAirportStub = departingAirportStub;
        this.destinationAirportStub = destinationAirportStub;
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
            informPlaneReadyForBoarding();
            // Transition to 'WAITING_FOR_BOARDING'
            waitForAllOnBoard();
            // Transition to 'FLYING_FORWARD'
            flyToDestinationPoint();
            // Transition to "DEBOARDING"
            announceArrival();
            // Transition to 'FLYING_BACK'
            flyToDeparturePoint();
            // Transition to 'AT TRANSFER GATE'
            if (parkAtTransferGate()) break;
        }
    }
    
    /**
     *   Transitions the pilot from the 'at transfer gate' state to the 'ready for boarding' state and awakens the hostess
     */
    
    private void informPlaneReadyForBoarding() {
    	ReturnValue ret = null;
    	try
        { ret = departureAirportStub.informPlaneReadyForBoarding();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.pilotState = ret.getStateValue();
    }
    
    /**
     *   Transitions the pilot from the 'ready for boarding' state to the 'waiting for boarding' state and sleeps while waiting for the hostess to signal that the plane is ready to depart
     */
    
    private void waitForAllOnBoard() {
    	ReturnValue ret = null;
    	try
        { ret = planeStub.waitForAllOnBoard();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.pilotState = ret.getStateValue();
    }
    
    /**
     *   Transitions the pilot from the 'waiting for boarding' state to the 'flying forward' state and sleeps for a randomly selected time.
     */
    
    
    private void flyToDestinationPoint() {
    	ReturnValue ret = null;
    	try
        { ret = departureAirportStub.flyToDestinationPoint();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.pilotState = ret.getStateValue();
    }
    
    /**
     *  
     *  It is called by the pilot to inform all the passengers that the plane has arrived to the destination
     *  and then the pilot waits for all the passengers to leave in order to take the plane back
     *
     */
    
    private void announceArrival() {
    	ReturnValue ret = null;
    	try
        { ret = planeStub.announceArrival();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.pilotState = ret.getStateValue();
    }
    
    /**
     *   Transitions the pilot from the 'waiting for boarding' state to the 'flying forward' state and sleeps for a randomly selected time.
     */
    
    private void flyToDeparturePoint() {
    	ReturnValue ret = null;
    	try
        { ret = destinationAirportStub.flyToDeparturePoint();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.pilotState = ret.getStateValue();
    }
    
    /**
     *	 Transitions the Pilot from the 'flying back' state to the 'at transfer gate' state
     *
     *     @return Flag that specifies whether to terminate the Pilot thread (true) or not (false)
     */
    
    private boolean parkAtTransferGate() {
    	ReturnValue ret = null;
    	try
        { ret = departureAirportStub.parkAtTransferGate();
        }
        catch (RemoteException e)
        { 
          System.exit (1);
        }
    	this.pilotState = ret.getStateValue();
    	return ret.getBooleanValue();
    }

}


