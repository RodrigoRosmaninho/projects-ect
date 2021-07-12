package serverSide.objects;

import java.rmi.RemoteException;

import clientSide.entities.HostessStates;
import clientSide.entities.PassengerStates;
import clientSide.entities.PilotStates;
import commInfra.*;
import genclass.GenericIO;
import interfaces.DepartureAirportInterface;
import interfaces.GeneralReposInterface;
import serverSide.main.DepartureAirportMain;

//import genclass.GenericIO;

/**
 *    Departure Airport.
 *
 *    It is responsible to keep a continuously updated account of the passengers in the queue inside the Departure Airport
 *    and is implemented as an implicit monitor.
 *    
 */

public class DepartureAirport implements DepartureAirportInterface
{
    /**
     *  List with the passenger checked boolean status
     */

    private final boolean [] wasChecked;
    
    /**
     *  List with the passenger show stage boolean status
     */
    
    private final boolean [] endedShow;
    
    /**
     *  Reference to passenger threads.
     */
    
    private int selected;

    /**
     *  Number of passengers that have boarded the flight currently at the airport. That is, the number of passengers in the IN_FLIGHT state.
     *  This variable is later used to determine if all checked in passengers have actually boarded the aircraft, thus letting the hostess know if everything is ready for the flight to take place.
     */
    
    private int number_of_pass_boarded;
    
    /**
     *  Number of passengers checked in for the flight currently at the airport.
     *  This variable is later used to determine the occupation of the plane.
     */
    
    private int number_of_pass_checked;
    
    /**
     *  Total number of passengers checked in.
     *  This variable is later used to determine if all 21 passengers have checked in.
     */
    
    private int number_of_pass_checked_total;

    /**
     *  FIFO Queue for Passengers that have arrived at the Departure Airport and are waiting to check in.
     */

    private MemFIFO<Integer> queue;
    
    /**
     *  Boolean flag that indicates if the plane is ready for boarding
     */

    private boolean planeReadyForBoarding;

    /**
     *   Reference to the General Information Repository.
     */

    private final GeneralReposInterface repos;

    
    /**
     *   Number of entity groups requesting the shutdown.
     */

     private int nEntities;

    /**
     *  Departure Airport instantiation.
     *
     *    @param reposStub reference to the General Information Repository
     */

    public DepartureAirport (GeneralReposInterface reposStub)
    {
        // Initialize the Passenger thread array
    	wasChecked = new boolean[ExecConst.N];
    	endedShow = new boolean[ExecConst.N];
        for (int i = 0; i < ExecConst.N; i++) {
        	wasChecked[i] = false;
        	endedShow[i] = false;
        }
        try
        
        // Initialize the Passenger FIFO Queue
        { queue = new MemFIFO<> (new Integer [ExecConst.N]);
        }
        catch (MemException e)
        { // Instantiation of waiting FIFO failed
            queue = null;
            System.exit (1);
        }
        
        // Initialize other misc. variables
        planeReadyForBoarding = false;
        number_of_pass_checked = 0;
        number_of_pass_checked_total = 0;
        selected = -1;
        this.repos = reposStub;
        nEntities = 0;
    }

    /**
     *   Set Plane Ready For Boarding Flag.
     *
     *     @param ready Plane Ready For Boarding
     */
    
    public synchronized void setPlaneReadyForBoarding(boolean ready){ planeReadyForBoarding = ready;}

    /**
     *   Get Plane Ready For Boarding Flag.
     *
     *     @return Plane Ready For Boarding
     */
    
    public boolean getPlaneReadyForBoarding(){ return planeReadyForBoarding; }


    /**
     *   Transitions the pilot from the 'at transfer gate' state to the 'ready for boarding' state and awakens the hostess
     */
    
    public synchronized ReturnValue informPlaneReadyForBoarding()
    {
    	// Set corresponding boolean flag
        planeReadyForBoarding = true;
        
        // Set state
        try {
			repos.setPilotState(PilotStates.READY_FOR_BOARDING);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        // Wake Hostess thread
        notifyAll();
        
        return new ReturnValue(false, PilotStates.READY_FOR_BOARDING);
    }

    /**
     *   Places the Passenger in the FIFO Queue, transitions the Passenger from the 'going to Airport' state to the 'in queue' state, awakens the hostess, and sleeps while waiting to be called by the hostess
     */
    
    public synchronized ReturnValue waitInQueue(int passId)
    {
    	// Place Passenger in FIFO Queue
        try {
            queue.write(passId);
        } catch (MemException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        try {
        	// Set state
	        repos.updatePassengersInDepartureQueue (1);
	        repos.setPassengerState (passId, PassengerStates.IN_QUEUE);
	    } catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Wake Hostess thread
        notifyAll();
        
        // Sleep while waiting to be called by the Hostess
        while ( selected != passId ){
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        return new ReturnValue(false, PassengerStates.IN_QUEUE);

    }
    
    /**
     *	 Transitions the Passenger from the 'in queue' state to the 'in flight' state and awakens the hostess
     */
    
    public synchronized ReturnValue boardThePlane(int passId)
    {
    	try {
    		// Set state
	        repos.updatePassengersInPlane (1);
	        repos.setPassengerState (passId, PassengerStates.IN_FLIGHT);
	    } catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Increment the number of passengers that have boarded the flight currently at the gate
        number_of_pass_boarded++;
        
        // Wake the Hostess thread
        notifyAll();
        
        return new ReturnValue(false, PassengerStates.IN_FLIGHT);
    }
    
    /**
     *   Sleeps while waiting for the pilot to signal the plane is ready for boarding, then transitions the Hostess from the 'wait for flight' state to the 'wait for passenger' state, and sleeps while waiting to be called by an arriving passenger
     *   
     *     @return Flag that specifies whether to terminate the Hostess thread (true) or not (false)
     */

    public synchronized ReturnValue prepareForPassBoarding()
    {
    	// Terminate Hostess Thread if all passengers have already flown
    	if (number_of_pass_checked_total == ExecConst.N) return new ReturnValue(true, HostessStates.WAIT_FOR_NEXT_FLIGHT);
    	
    	// Sleeps while waiting for the pilot to signal the plane is ready for boarding
        while (!planeReadyForBoarding) {
            try {
				wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
        }
        // Reset corresponding flag for later use
        planeReadyForBoarding = false;
        
        // Set state
        try {
			repos.setHostessState(HostessStates.WAIT_FOR_PASSENGER);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        // Reset numbers of checked and boarded passengers, given a new plane is at the gate 
        number_of_pass_checked = 0;
        number_of_pass_boarded = 0;
        
        
        // Sleep while waiting to be called by an arriving passenger
        while(queue.getN() == 0) {
        	try {
				wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        
        return new ReturnValue(false, HostessStates.WAIT_FOR_PASSENGER);
    }
    
    /**
     *   Helper function to indicate if the number of passengers aboard the plane allows for the flight to begin
     *   
     *     @return Flag that specifies whether the number of passengers aboard the plane allows for the flight to begin (true) or not (false)
     */
    
    private boolean checkNumberOfPassengers() 
    {
    	// Check if all checked in passengers have actually boarded the plane yet
    	if(number_of_pass_checked == number_of_pass_boarded) {
    		
    		// Check if all 21 passengers have been checked in to a flight
	        if (number_of_pass_checked_total == ExecConst.N){
	            return true;
	        }
	        
	        // Check if at least the minimum number of passengers have been check in to the current flight
	        else if (number_of_pass_checked >= ExecConst.MIN) {
                return true;
            }
	        
    		return false;
    	}
    	return false;
    }

    /**
     *	 Transitions the Hostess from the 'check passenger' state to the 'wait for passenger' state and wakes up the passenger that was just validated.
     *   Also verifies if either:
     *   1 - the queue is empty and the number of passengers aboard the plane allows for the flight to begin
     *   2 - the plane is full
     *   3 - the plane is not full and the queue is not empty
     *   If neither of these conditions are met, sleeps while waiting for either a checked in passenger to board the plane or for a new passenger to arrive to the airport queue.
     *   
     *     @return Flag that specifies whether to call the informPlaneReadyToTakeOff operation (true) or the checkDocuments operation (false)
     */
    
    public synchronized ReturnValue waitForNextPassenger()
    {
    	// Set state
        try {
			repos.setHostessState(HostessStates.WAIT_FOR_PASSENGER);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        // Wake up the passenger that was just validated
        notifyAll();
        
        
        while(true) {
        	
        	// Verify if either:
            //   - the queue is empty and the number of passengers aboard the plane allows for the flight to begin
            //   - the plane is full
            //   - the plane is not full and the queue is not empty
        	
	        if(checkNumberOfPassengers()) {
	        	if(number_of_pass_checked == ExecConst.MAX || queue.getN() == 0) {
	        		return new ReturnValue(true, HostessStates.WAIT_FOR_PASSENGER);
	        	}
	        }
	        if (queue.getN() != 0 && number_of_pass_checked != ExecConst.MAX ) {
	        	return new ReturnValue(false, HostessStates.WAIT_FOR_PASSENGER);
	        }
	        
	        // Sleep while waiting for either a checked in passenger to board the plane or for a new passenger to arrive to the airport queue
	        try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
        }
    
    }
    
    /**
     *   Wakes the Hostess to signal that the documents were shown and sleeps while waiting for the hostess to validate them
     */

    public synchronized void showDocuments(int passId)
    {
    	// Set a flag on the Passenger to confirm the documents were shown
        endedShow[passId] = true;
        
        // Wake the Hostess to signal that the documents were shown
        notifyAll();
        
        // Sleep while waiting for the hostess to validate them
        while (!wasChecked[passId]){
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     *	 Transitions the Pilot from the 'flying back' state to the 'at transfer gate' state
     *
     *     @return Flag that specifies whether to terminate the Pilot thread (true) or not (false)
     */
    
    public synchronized ReturnValue parkAtTransferGate() 
    {
    	// Set state
        try {
			repos.setPilotState (PilotStates.AT_TRANSFER_GATE);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        // Terminate the Pilot thread if all passengers have been flown to the destination
        if (number_of_pass_checked_total == ExecConst.N) {
        	return new ReturnValue(true, PilotStates.AT_TRANSFER_GATE);
        }
        return new ReturnValue(false, PilotStates.AT_TRANSFER_GATE);
    }

    /**
     *	 Dequeues a Passenger, transitions the Hostess from the 'wait for passenger' state to the 'check passenger' state, awakens the passenger, and sleeps while waiting for the passenger to show the requested documents.
     */
    
    public synchronized ReturnValue checkDocuments()
    {
    	// Dequeue a Passenger
        int passengerId = 0;
        try {
            passengerId = queue.read();
        } catch (MemException e) {
            e.printStackTrace();
        }
        selected = passengerId;
        
        try {
	        // Set state and update repository
	        repos.logPassengerCheck(passengerId);
	        repos.updatePassengersInDepartureQueue(-1);
	        repos.setHostessState(HostessStates.CHECK_PASSENGER);
	    } catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        // Wake the selected passenger
        notifyAll();

        // Sleep while waiting for the passenger to show the requested documents
        while (!endedShow[passengerId]){
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        // Update relevant flags and variables
        wasChecked[passengerId] = true;
        
        number_of_pass_checked_total++;
        number_of_pass_checked++;
        
        return new ReturnValue(false, HostessStates.CHECK_PASSENGER);
    }
    
    /**
     *	 Transitions the Hostess to the 'wait for next flight' state
     */
    
    public ReturnValue waitForNextFlight(){
        setPlaneReadyForBoarding(false);
        try {
			repos.setHostessState (HostessStates.WAIT_FOR_NEXT_FLIGHT);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return new ReturnValue(false, HostessStates.WAIT_FOR_NEXT_FLIGHT);
    }
    
    /**
     *	 Transitions the Pilot to the 'flying forward' state, and sleeps for randomly selected time to emulate the passage of time during the flight
     */
    
    public ReturnValue flyToDestinationPoint()
    {
        // Set FLYING_FORWARD State
        try {
			repos.setPilotState (PilotStates.FLYING_FORWARD);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

        // Sleep for randomly selected time to emulate the passage of time during the flight
        try
        { Thread.currentThread().sleep ((long) (1 + 100 * Math.random ()));
        }
        catch (InterruptedException e) {}
        
        return new ReturnValue(false, PilotStates.FLYING_FORWARD);
    }
    
    /**
     *   Operation server shutdown.
     *
     *   New operation.
     *
     *     @throws RemoteException if either the invocation of the remote method, or the communication with the registry
     *                             service fails
     */
    
    public synchronized void shutdown () throws RemoteException
    {
        nEntities += 1;
        if (nEntities >= ExecConst.E_DepAir) {
        	
        	try
        	{ repos.shutdown();
        	}
        	catch (RemoteException e)
        	{ GenericIO.writelnString ("Customer generator remote exception on GeneralRepos shutdown: " + e.getMessage ());
	          System.exit (1);
        	}
        	DepartureAirportMain.shutdown ();
        }
        notifyAll ();                                       // the barber may now terminate
    }

}