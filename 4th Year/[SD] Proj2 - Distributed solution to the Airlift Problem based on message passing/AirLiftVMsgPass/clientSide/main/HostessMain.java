package clientSide.main;
import clientSide.entities.Hostess;
import clientSide.stubs.DepartureAirportStub;
import clientSide.stubs.DestinationAirportStub;
import clientSide.stubs.PlaneStub;


/**
 *    Client side of the Assignment 2 - Hostess.
 *    Static solution Attempt (number of threads controlled by global constants - ExecConst)
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on a communication channel under the TCP protocol.
 */

public class HostessMain {
	
	 /**
     *    Main method.
     *
     *    @param args runtime arguments
     */
	
	public static void main(String[] args) {
		Hostess hostess;  												//reference to the Hostess Thread
		
		DepartureAirportStub departureAirport;							//Reference to the Departure Airport
        PlaneStub plane;												//Reference to the Plane
        DestinationAirportStub destinationAirport;						//Reference to the Destination Airport
        
        departureAirport = new DepartureAirportStub("l040101-ws01.ua.pt", 22150);
        plane = new PlaneStub("l040101-ws02.ua.pt", 22151);
        
        hostess = new Hostess("Hostess_1", 0, departureAirport, plane);  
        
        /* start thread */
        hostess.start ();
        
        /* wait for the end */
        try
        { hostess.join ();
        }
        catch (InterruptedException e) {}
        System.out.println("The Hostess 1 just terminated");
        
        System.out.println("End of the Simulation");
        
	}

}

