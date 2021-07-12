package interfaces;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 *   Operational interface of a remote object of type General Repository.
 *
 *     It provides the functionality to access General Repository.
 */

public interface GeneralReposInterface extends Remote {
	
	 /**
	    *   Update Counter PassengersInDepartureQueue
	    *
	    *     @param value integer
	    *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
	    */
	
	public void updatePassengersInDepartureQueue (int value) throws RemoteException;
	
	/**
	   *   Update Counter PassengersInPlane
	   *
	   *     @param value integer
	   *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
	   */
	
	public void updatePassengersInPlane (int value) throws RemoteException;
	
	 /**
	    *   Update Counter PassengersArrived
	    *
	    *     @param value integer
	    *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
	    */
	
	public void updatePassengersArrived (int value) throws RemoteException;
	
	/**
	    *   Set pilot state.
	    *
	    *     @param state pilot state
	    *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
	    */
	
	public void setPilotState (int state) throws RemoteException;
	
	/**
	    *   Write to the logging file that a passenger is starting to be checked.
	    *
	    *     @param id passenger id
	    *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
	    */
	
	public void logPassengerCheck(int id) throws RemoteException;
	
	/**
	    *   Set hostess state.
	    *
	    *     @param state hostess state
	    *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
	    */
	
	public void setHostessState (int state) throws RemoteException;
	
	/**
	    *   Set passenger state.
	    *
	    *	  @param passengerId passenger id
	    *     @param state passenger state
	    *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
	    */
	
    public void setPassengerState (int passengerId, int state) throws RemoteException;
    
    /**
    *   Write to the logging file the result of the sum up variable.
    *   
    *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
    *
    */
    
    public void printSumUp() throws RemoteException;
    
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
