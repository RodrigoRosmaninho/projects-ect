package interfaces;

import java.rmi.Remote;
import java.rmi.RemoteException;

import commInfra.ReturnValue;

/**
 *   Operational interface of a remote object of type Plane.
 *
 *     It provides the functionality to access Plane.
 */

public interface PlaneInterface extends Remote{
	
	/**
     *  
     *  It is called by the passengers to synchronize their thread sleeps with the arrival of the plane to the destination
     *  
     *  
     *  @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     *
     */
	
	public void waitForEndOfFlight() throws RemoteException;
    
    /**
     *  
     *  It is called by the pilot to inform all the passengers that the plane has arrived to the destination
     *  and then the pilot waits for all the passengers to leave in order to take the plane back
     *  
     *  @return Next State that the Pilot will take
     *  @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     *
     */
    
    public ReturnValue announceArrival() throws RemoteException;
    
    
    /**
     *  
     *  It is called by a passenger when he is waked by the pilot and needs to leave the plane.
     *  
     *  @param passId the passenger id that will leave
     *  @return Next State that the passenger will take
     *  @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     *
     */
    
    public ReturnValue leaveThePlane(int passId) throws RemoteException;

    /**
     *   Transitions the hostess from the 'wait for passenger' state to the 'ready to fly' state and awakens the pilot
     *   
     *   @return Next State that the Hostess will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue informPlaneReadyToTakeOff() throws RemoteException;

    /**
     *   Transitions the pilot from the 'ready for boarding' state to the 'waiting for boarding' state and sleeps while waiting for the hostess to signal that the plane is ready to depart
     *   
     *   @return Next State that the pilot will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */

    public ReturnValue waitForAllOnBoard() throws RemoteException;
    
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
