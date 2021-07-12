package serverSide.sharedRegions;

import commInfra.Message;
import serverSide.entities.*;

/**
 *    SharedRegionInterface.
 *
 *    It is responsible for the decoding of received messages, interaction with the Shared Region, and construction of the response message.
 *
 */

public interface SharedRegionInterface {
	
	/**
	   *  Process received message, interact with the Shared Region, and construct and return the response message.
	   *
	   *	 @param message Received Message
	   *     @return message Response Message.
	   */
	
	public Message processAndReply(Message message);
	
	/**
	   *  Get flag to determine if the server has received a shutdown message.
	   *
	   *     @return hasShutdown boolean.
	   */
	
	public boolean hasShutdown();
	
}
