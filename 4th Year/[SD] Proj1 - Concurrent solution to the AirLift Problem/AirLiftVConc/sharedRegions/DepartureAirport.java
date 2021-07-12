package sharedRegions;

import main.*;
import entities.*;
import commInfra.*;
//import genclass.GenericIO;

/**
 *    Departure Airport.
 *
 *    It is responsible to keep a continuously updated account of the passengers in the queue inside the Departure Airport
 *    and is implemented as an implicit monitor.
 *    
 */

public class DepartureAirport
{
    /**
     *  Reference to passenger threads.
     */

    private final Passenger [] pass;

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

    private final GeneralRepos repos;


    /**
     *  Departure Airport instantiation.
     *
     *    @param repos reference to the General Information Repository
     */

    public DepartureAirport (GeneralRepos repos)
    {
        // Initialize the Passenger thread array
    	pass = new Passenger[ExecConst.N];
        for (int i = 0; i < ExecConst.N; i++)
            pass[i] = null;
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
        this.repos = repos;
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
     *   Get Number of Passengers Checked.
     *
     *     @return Number of Pass Checked
     */
    
    public int getNumberOfPassChecked(){ return number_of_pass_checked; }

    /**
     *   Transitions the pilot from the 'at transfer gate' state to the 'ready for boarding' state and awakens the hostess
     */
    
    public synchronized void informPlaneReadyForBoarding()
    {
    	// Set corresponding boolean flag
        planeReadyForBoarding = true;
        
        // Set state
        ((Pilot) Thread.currentThread ()).setPilotState(PilotStates.READY_FOR_BOARDING);
        repos.setPilotState(PilotStates.READY_FOR_BOARDING);
        
        // Wake Hostess thread
        notifyAll();
    }

    /**
     *   Places the Passenger in the FIFO Queue, transitions the Passenger from the 'going to Airport' state to the 'in queue' state, awakens the hostess, and sleeps while waiting to be called by the hostess
     */
    
    public synchronized void waitInQueue()
    {
    	// Place Passenger in FIFO Queue
        int passengerId;
        passengerId = ((Passenger) Thread.currentThread ()).getPassengerId ();
        pass[passengerId] = (Passenger) Thread.currentThread ();
        try {
            queue.write(passengerId);
        } catch (MemException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        // Set state
        pass[passengerId].setPassengerState (PassengerStates.IN_QUEUE);
        repos.updatePassengersInDepartureQueue (1);
        repos.setPassengerState (passengerId, PassengerStates.IN_QUEUE);

        // Wake Hostess thread
        notifyAll();
        
        // Sleep while waiting to be called by the Hostess
        while ( !(pass[passengerId].getSelected()) ){
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     *   Helper function to indicate if the FIFO Queue contains Passengers
     *   
     *     @return Flag that specifies whether the FIFO Queue contains Passengers (true) or not (false)
     */
    
    public synchronized boolean someoneArrived()
    {
        if (queue.getN() == 0){
            return false;
        }
        return true;
    }
    
    /**
     *	 Transitions the Passenger from the 'in queue' state to the 'in flight' state and awakens the hostess
     */
    
    public synchronized void boardThePlane()
    {
    	// Set state
    	Passenger p = ((Passenger) Thread.currentThread ());
        p.setPassengerState(PassengerStates.IN_FLIGHT);
        repos.updatePassengersInPlane (1);
        repos.setPassengerState (p.getPassengerId(), PassengerStates.IN_FLIGHT);
        
        // Increment the number of passengers that have boarded the flight currently at the gate
        number_of_pass_boarded++;
        
        // Wake the Hostess thread
        notifyAll();
    }
    
    /**
     *   Sleeps while waiting for the pilot to signal the plane is ready for boarding, then transitions the Hostess from the 'wait for flight' state to the 'wait for passenger' state, and sleeps while waiting to be called by an arriving passenger
     *   
     *     @return Flag that specifies whether to terminate the Hostess thread (true) or not (false)
     */

    public synchronized boolean prepareForPassBoarding()
    {
    	// Terminate Hostess Thread if all passengers have already flown
    	if (number_of_pass_checked_total == ExecConst.N) return true;
    	
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
        ((Hostess) Thread.currentThread ()).setHostessState(HostessStates.WAIT_FOR_PASSENGER);
        repos.setHostessState(HostessStates.WAIT_FOR_PASSENGER);
        
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
        
        return false;
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
    
    public synchronized boolean waitForNextPassenger()
    {
    	// Set state
        ((Hostess) Thread.currentThread ()).setHostessState(HostessStates.WAIT_FOR_PASSENGER);
        repos.setHostessState(HostessStates.WAIT_FOR_PASSENGER);
        
        // Wake up the passenger that was just validated
        notifyAll();
        
        
        while(true) {
        	
        	// Verify if either:
            //   - the queue is empty and the number of passengers aboard the plane allows for the flight to begin
            //   - the plane is full
            //   - the plane is not full and the queue is not empty
        	
	        if(checkNumberOfPassengers()) {
	        	if(number_of_pass_checked == ExecConst.MAX || queue.getN() == 0) {
	        		return true;
	        	}
	        }
	        if (queue.getN() != 0 && number_of_pass_checked != ExecConst.MAX ) {
	        	return false;
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

    public synchronized void showDocuments()
    {
    	// Set a flag on the Passenger to confirm the documents were shown
        Passenger t = ((Passenger) Thread.currentThread ());
        t.setEndedShow(true);
        
        // Wake the Hostess to signal that the documents were shown
        notifyAll();
        
        // Sleep while waiting for the hostess to validate them
        while (!t.getWasChecked()){
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
    
    public synchronized boolean parkAtTransferGate() 
    {
    	// Set state
    	((Pilot) Thread.currentThread ()).setPilotState(PilotStates.AT_TRANSFER_GATE);
        repos.setPilotState (PilotStates.AT_TRANSFER_GATE);
        
        // Terminate the Pilot thread if all passengers have been flown to the destination
        if (number_of_pass_checked_total == ExecConst.N) return true;
        return false;
    }

    /**
     *	 Dequeues a Passenger, transitions the Hostess from the 'wait for passenger' state to the 'check passenger' state, awakens the passenger, and sleeps while waiting for the passenger to show the requested documents.
     */
    
    public synchronized void checkDocuments()
    {
    	// Dequeue a Passenger
        int passengerId = 0;
        try {
            passengerId = queue.read();
        } catch (MemException e) {
            e.printStackTrace();
        }
        pass[passengerId].setSelected(true);
        
        // Set state and update repository
        ((Hostess) Thread.currentThread ()).setHostessState(HostessStates.CHECK_PASSENGER);
        repos.logPassengerCheck(passengerId);
        repos.updatePassengersInDepartureQueue(-1);
        repos.setHostessState(HostessStates.CHECK_PASSENGER);
        
        // Wake the selected passenger
        notifyAll();

        // Sleep while waiting for the passenger to show the requested documents
        while (!pass[passengerId].getEndedShow()){
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        // Update relevant flags and variables
        pass[passengerId].setWasChecked(true);
        
        number_of_pass_checked_total++;
        number_of_pass_checked++;
    }



}