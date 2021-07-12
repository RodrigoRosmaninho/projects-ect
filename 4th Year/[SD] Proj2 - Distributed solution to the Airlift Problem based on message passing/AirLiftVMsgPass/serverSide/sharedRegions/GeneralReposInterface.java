package serverSide.sharedRegions;

import genclass.GenericIO;
import commInfra.Message;
import serverSide.entities.*;

/**
 *    GeneralReposInterface.
 *
 *    It is responsible for the decoding of received messages, interaction with the Shared Region, and construction of the response message.
 *
 */

public class GeneralReposInterface implements SharedRegionInterface {
	
	/**
     *   Reference to the GeneralRepos Shared Region
     */
	
	private GeneralRepos rp;
	
	/**
     *   Boolean flag that indicates if the server has shutdown
     */
	
	private boolean shutdown;

	/**
	   *   Instantiation of a GeneralReposInterface object.
	   *
	   *     @param rp Reference to the GeneralReposInterface Shared Region
	   */
	
	public GeneralReposInterface(GeneralRepos rp) {
		this.rp = rp;
		this.shutdown = false;
	}
	
	public Message processAndReply(Message message) {
		
		Object res = null;
		Object[] state;
		
		switch(message.getOperation()) {
		case 16:
			GenericIO.writelnString ("-> setHostessState");
			rp.setHostessState((int) message.getParams()[0]);
			break;
		case 17:
			GenericIO.writelnString ("-> setPassengerState");
			rp.setPassengerState((int) message.getParams()[0], (int) message.getParams()[1]);
			break;
		case 18:
			GenericIO.writelnString ("-> setPilotState");
			rp.setPilotState((int) message.getParams()[0]);
			break;
		case 19:
			GenericIO.writelnString ("-> updatePassengersInPlane");
			rp.updatePassengersInPlane((int) message.getParams()[0]);
			break;
		case 20:
			GenericIO.writelnString ("-> updatePassengersArrived");
			rp.updatePassengersArrived((int) message.getParams()[0]);
			break;
		case 21:
			GenericIO.writelnString ("-> updatePassengersInDepartureQueue");
			rp.updatePassengersInDepartureQueue((int) message.getParams()[0]);
			break;
		case 22:
			GenericIO.writelnString ("-> logPassengerCheck");
			rp.logPassengerCheck((int) message.getParams()[0]);
			break;
		case 23:
			GenericIO.writelnString ("-> printSumUp");
			rp.printSumUp();
			break;
		case 24:
			shutdown = true;
			message = null;
			state = new Object[]{};
			break;
		default:
			throw new IllegalArgumentException();
		}
		
		return message;
	}
	
	public boolean hasShutdown() {
		return shutdown;
	}
	
}
