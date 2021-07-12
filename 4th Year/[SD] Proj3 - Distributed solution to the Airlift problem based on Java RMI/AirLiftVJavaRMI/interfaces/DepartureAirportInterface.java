package interfaces;

import java.rmi.Remote;
import java.rmi.RemoteException;

import commInfra.ReturnValue;

/**
 *   Operational interface of a remote object of type Departure Airport.
 *
 *     It provides the functionality to access Departure Airport.
 */

public interface DepartureAirportInterface extends Remote{

    /**
     *   Transitions the pilot from the 'at transfer gate' state to the 'ready for boarding' state and awakens the hostess
     *   
     *   @return Next State that the pilot will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     *   
     */
    
    public ReturnValue informPlaneReadyForBoarding() throws RemoteException;

    /**
     *   Places the Passenger in the FIFO Queue, transitions the Passenger from the 'going to Airport' state to the 'in queue' state, awakens the hostess, and sleeps while waiting to be called by the hostess
     *   
     *   @param passId the passenger id that will be placed
     *   @return Next State that the passenger will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue waitInQueue(int passId) throws RemoteException ;
    
    /**
     *	 Transitions the Passenger from the 'in queue' state to the 'in flight' state and awakens the hostess
     *
     *   @param passId the passenger id from the passenger that will enter the plane
     *   @return Next State that the passenger will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue boardThePlane(int passId) throws RemoteException;
    
    /**
     *   Sleeps while waiting for the pilot to signal the plane is ready for boarding, then transitions the Hostess from the 'wait for flight' state to the 'wait for passenger' state, and sleeps while waiting to be called by an arriving passenger
     *   
     *     @return Flag that specifies whether to terminate the Hostess thread (true) or not (false)
     *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */

    public ReturnValue prepareForPassBoarding() throws RemoteException;
     

    /**
     *	 Transitions the Hostess from the 'check passenger' state to the 'wait for passenger' state and wakes up the passenger that was just validated.
     *   Also verifies if either:
     *   1 - the queue is empty and the number of passengers aboard the plane allows for the flight to begin
     *   2 - the plane is full
     *   3 - the plane is not full and the queue is not empty
     *   If neither of these conditions are met, sleeps while waiting for either a checked in passenger to board the plane or for a new passenger to arrive to the airport queue.
     *   
     *     @return Flag that specifies whether to call the informPlaneReadyToTakeOff operation (true) or the checkDocuments operation (false)
     *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue waitForNextPassenger() throws RemoteException;
    
    /**
     *   Wakes the Hostess to signal that the documents were shown and sleeps while waiting for the hostess to validate them
     *   
     *   @param passId the passengerId form the passenger that will show the documents
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */

    public void showDocuments(int passId) throws RemoteException;
    
    /**
     *	 Transitions the Pilot from the 'flying back' state to the 'at transfer gate' state
     *
     *     @return Flag that specifies whether to terminate the Pilot thread (true) or not (false)
     *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue parkAtTransferGate() throws RemoteException;

    /**
     *	 Dequeues a Passenger, transitions the Hostess from the 'wait for passenger' state to the 'check passenger' state, awakens the passenger, and sleeps while waiting for the passenger to show the requested documents.
     *   @return Next State that the Hostess will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue checkDocuments() throws RemoteException;
    
    /**
     *	 Transitions the Hostess to the 'wait for next flight' state
     *   @return Next State that the Hostess will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue waitForNextFlight() throws RemoteException;
    
    /**
     *	 Transitions the Pilot to the 'flying forward' state, and sleeps for randomly selected time to emulate the passage of time during the flight
     *   @return Next State that the Pilot will take
     *   @throws RemoteException if either the invocation of the remote method, or the communication with the registry
   *                             service fails
     */
    
    public ReturnValue flyToDestinationPoint() throws RemoteException;
    
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
