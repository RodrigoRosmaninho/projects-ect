package serverSide.sharedRegions;

import genclass.GenericIO;
import commInfra.Message;
import serverSide.entities.*;

/**
 *    PlaneInterface.
 *
 *    It is responsible for the decoding of received messages, interaction with the Shared Region, and construction of the response message.
 *
 */

public class PlaneInterface implements SharedRegionInterface {
	
	/**
     *   Reference to the Plane Shared Region
     */
	
	private Plane pl;
	
	/**
     *   Boolean flag that indicates if the server has shutdown
     */
	
	private boolean shutdown;
	
	/**
	   *   Instantiation of a PlaneInterface object.
	   *
	   *     @param pl Reference to the PlaneInterface Shared Region
	   */
	
	public PlaneInterface(Plane pl) {
		this.pl = pl;
		this.shutdown = false;
	}
	
	public Message processAndReply(Message message) {
		
		Hostess hostess;
		Passenger passenger;
		Pilot pilot;
		Object res = null;
		Object[] state;
		
		switch(message.getOperation()) {
		case 10:
			hostess = (Hostess) Thread.currentThread();
			hostess.setHostessId((int) message.getStateFields()[0]);
			hostess.setHostessState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Hostess -> informPlaneReadyToTakeOff");
			pl.informPlaneReadyToTakeOff();
			state = new Object[]{hostess.getHostessId(), hostess.getHostessState()};
			break;
		case 11:
			passenger = (Passenger) Thread.currentThread();
			passenger.setPassengerId((int) message.getStateFields()[0]);
			passenger.setPassengerState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Passenger -> waitForEndOfFlight");
			pl.waitForEndOfFlight();
			state = new Object[]{passenger.getPassengerId(), passenger.getPassengerState()};
			break;
		case 12:
			passenger = (Passenger) Thread.currentThread();
			passenger.setPassengerId((int) message.getStateFields()[0]);
			passenger.setPassengerState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Passenger -> leaveThePlane");
			pl.leaveThePlane();
			state = new Object[]{passenger.getPassengerId(), passenger.getPassengerState()};
			break;
		case 13:
			pilot = (Pilot) Thread.currentThread();
			pilot.setPilotId((int) message.getStateFields()[0]);
			pilot.setPilotState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Pilot -> waitForAllOnBoard");
			pl.waitForAllOnBoard();
			state = new Object[]{pilot.getPilotState(), pilot.getPilotState()};
			break;
		case 14:
			pilot = (Pilot) Thread.currentThread();
			pilot.setPilotId((int) message.getStateFields()[0]);
			pilot.setPilotState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Pilot -> announceArrival");
			pl.announceArrival();
			state = new Object[]{pilot.getPilotState(), pilot.getPilotState()};
			break;
		case 24:
			shutdown = true;
			message = null;
			state = new Object[]{};
			break;
		default:
			throw new IllegalArgumentException();
		}
		
		if (message != null) {
			message.setStateFields(state);
			message.setSizeStateFields(state.length);
			message.setReturnValue(res);
		}
		return message;
	}
	
	public boolean hasShutdown() {
		return shutdown;
	}
	
}
