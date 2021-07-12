package interfaces;

import java.rmi.Remote;
import java.rmi.RemoteException;

import commInfra.ReturnValue;

/**
 *   Operational interface of a remote object of type Destination Airport.
 *
 *     It provides the functionality to access Destination Airport.
 */

public interface DestinationAirportInterface extends Remote{
	
	/**
     *  
     *  It is called by the pilot in order to fly back to the departure airport.
     *  
     *  @return next state that the Pilot will take
     *  @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     *
     */
	
	public ReturnValue flyToDeparturePoint() throws RemoteException;
	
	/**
     *   Operation server shutdown.
     *
     *   New operation.
     *
     *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
     *                             service fails
     */
	
	public void shutdown() throws RemoteException;

}
