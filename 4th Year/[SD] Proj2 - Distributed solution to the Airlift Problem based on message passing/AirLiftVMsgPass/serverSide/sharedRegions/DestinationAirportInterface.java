package serverSide.sharedRegions;

import genclass.GenericIO;
import commInfra.Message;
import serverSide.entities.*;

/**
 *    DestinationAirportInterface.
 *
 *    It is responsible for the decoding of received messages, interaction with the Shared Region, and construction of the response message.
 *
 */

public class DestinationAirportInterface implements SharedRegionInterface {
	
	/**
     *   Reference to the DestinationAirport Shared Region
     */
	
	private DestinationAirport da;
	
	/**
     *   Boolean flag that indicates if the server has shutdown
     */
	
	private boolean shutdown;
	
	/**
	   *   Instantiation of a DestinationAirportInterface object.
	   *
	   *     @param da Reference to the DestinationAirportInterface Shared Region
	   */
	
	public DestinationAirportInterface(DestinationAirport da) {
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
		case 15:
			pilot = (Pilot) Thread.currentThread();
			pilot.setPilotId((int) message.getStateFields()[0]);
			pilot.setPilotState((int) message.getStateFields()[1]);
			GenericIO.writelnString ("Pilot -> flyToDeparturePoint");
			da.flyToDeparturePoint();
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
