package clientSide.main;
import clientSide.entities.Passenger;
import clientSide.stubs.DepartureAirportStub;
import clientSide.stubs.DestinationAirportStub;
import clientSide.stubs.PlaneStub;

/**
 *    Client side of the Assignment 2 - Passenger.
 *    Static solution Attempt (number of threads controlled by global constants - ExecConst)
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on a communication channel under the TCP protocol.
 */

public class PassengerMain {
	
	/**
     *    Main method.
     *
     *    @param args runtime arguments
     */
	
	public static void main(String[] args) {
		Passenger[] passenger = new Passenger[ExecConst.N];    		    //array of references to the Passengers Threads
		
		DepartureAirportStub departureAirport;							//Reference to the Departure Airport
        PlaneStub plane;												//Reference to the Plane
        DestinationAirportStub destinationAirport;						//Reference to the Destination Airport
        
        departureAirport = new DepartureAirportStub("l040101-ws01.ua.pt", 22150);
        plane = new PlaneStub("l040101-ws02.ua.pt", 22151);
        destinationAirport = new DestinationAirportStub("l040101-ws03.ua.pt", 22152);
        
        for (int i = 0; i < ExecConst.N; i++)
            passenger[i] = new Passenger("Passenger_"+(i+1), i, departureAirport, plane);
        
        
        /* start threads */
        for (int i = 0; i < ExecConst.N; i++)
        	passenger[i].start ();
        
        
        /* wait for the end */
        for (int i = 0; i < ExecConst.N; i++)
        { try
        { passenger[i].join ();
        }
        catch (InterruptedException e) {}
        System.out.println("The Passenger "+(i+1)+" just terminated");
        }
        
        System.out.println("End of the Simulation");
        
	}

}
