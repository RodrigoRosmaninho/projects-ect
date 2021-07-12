package serverSide.sharedRegions;

import genclass.GenericIO;
import commInfra.Message;
import serverSide.entities.*;

/**
 *    DepartureAirportInterface.
 *
 *    It is responsible for the decoding of received messages, interaction with the Shared Region, and construction of the response message.
 *
 */

public class DepartureAirportInterface implements SharedRegionInterface {
	
	/**
     *   Reference to the DepartureAirport Shared Region
     */
	
	private DepartureAirport da;
	
	/**
     *   Boolean flag that indicates if the server has shutdown
     */
	
	private boolean shutdown;
	
	/**
	   *   Instantiation of a DepartureAirportInterface object.
	   *
	   *     @param da Reference to the DepartureAirport Shared Region
	   */

	public DepartureAirportInterface(DepartureAirport da) {
		this.da = da;
		this.shutdown = false;
	}
	
	public Message processAndReply(Message message) {
		
		Hostess hostess;
		Passenger passenger;
		Pilot pilot;
		Object res = null;
		Object[] state;
		
		switch(message.getOperation()) {
		case 0:
			hostess = (Hostess) Thread.currentThread();
			hostess.setHostessId((int) message.getStateFields()[0]);
			hostess.setHostessState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Hostess -> prepareForPassBoarding");
			res = da.prepareForPassBoarding();
			state = new Object[]{hostess.getHostessId(), hostess.getHostessState()};
			break;
		case 1:
			hostess = (Hostess) Thread.currentThread();
			hostess.setHostessId((int) message.getStateFields()[0]);
			hostess.setHostessState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Hostess -> checkDocuments");
			da.checkDocuments();
			state = new Object[]{hostess.getHostessId(), hostess.getHostessState()};
			break;
		case 2:
			hostess = (Hostess) Thread.currentThread();
			hostess.setHostessId((int) message.getStateFields()[0]);
			hostess.setHostessState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Hostess -> waitForNextPassenger");
			res = da.waitForNextPassenger();
			state = new Object[]{hostess.getHostessId(), hostess.getHostessState()};
			break;
		case 3:
			hostess = (Hostess) Thread.currentThread();
			hostess.setHostessId((int) message.getStateFields()[0]);
			hostess.setHostessState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Hostess -> waitForNextFlight");
			da.waitForNextFlight();
			state = new Object[]{hostess.getHostessId(), hostess.getHostessState()};
			break;
		case 4:
			passenger = (Passenger) Thread.currentThread();
			passenger.setPassengerId((int) message.getStateFields()[0]);
			passenger.setPassengerState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Passenger -> waitInQueue");
			da.waitInQueue();
			state = new Object[]{passenger.getPassengerId(), passenger.getPassengerState()};
			break;
		case 5:
			passenger = (Passenger) Thread.currentThread();
			passenger.setPassengerId((int) message.getStateFields()[0]);
			passenger.setPassengerState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Passenger -> showDocuments");
			da.showDocuments();
			state = new Object[]{passenger.getPassengerId(), passenger.getPassengerState()};
			break;
		case 6:
			passenger = (Passenger) Thread.currentThread();
			passenger.setPassengerId((int) message.getStateFields()[0]);
			passenger.setPassengerState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Passenger -> boardThePlane");
			da.boardThePlane();
			state = new Object[]{passenger.getPassengerId(), passenger.getPassengerState()};
			break;
		case 7:
			pilot = (Pilot) Thread.currentThread();
			pilot.setPilotId((int) message.getStateFields()[0]);
			pilot.setPilotState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Pilot -> informPlaneReadyForBoarding");
			da.informPlaneReadyForBoarding();
			state = new Object[]{pilot.getPilotId(), pilot.getPilotState()};
			break;
		case 8:
			pilot = (Pilot) Thread.currentThread();
			pilot.setPilotId((int) message.getStateFields()[0]);
			pilot.setPilotState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Pilot -> parkAtTransferGate");
			res = da.parkAtTransferGate();
			state = new Object[]{pilot.getPilotId(), pilot.getPilotState()};
			break;
		case 9:
			pilot = (Pilot) Thread.currentThread();
			pilot.setPilotId((int) message.getStateFields()[0]);
			pilot.setPilotState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Pilot -> flyToDestinationPoint");
			da.flyToDestinationPoint();
			state = new Object[]{pilot.getPilotId(), pilot.getPilotState()};
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
