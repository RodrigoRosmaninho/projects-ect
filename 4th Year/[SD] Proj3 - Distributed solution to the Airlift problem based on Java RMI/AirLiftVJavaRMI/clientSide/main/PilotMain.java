package clientSide.main;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import clientSide.entities.Pilot;
import genclass.GenericIO;
import interfaces.DepartureAirportInterface;
import interfaces.DestinationAirportInterface;
import interfaces.GeneralReposInterface;
import interfaces.PlaneInterface;


/**
 *    Client side of the airlift project
 *
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on Java RMI.
 */

public class PilotMain {
	
	/**
	   *  Main method.
	   *
	   *    @param args runtime arguments
	   *        args[0] - name of the platform where is located the RMI registering service
	   *        args[1] - port number where the registering service is listening to service requests
	   */
	
	public static void main(String args[])
	   {
	    /* get location of the generic registry service */

	     String rmiRegHostName;
	     int rmiRegPortNumb = -1;

	     /* getting problem runtime parameters */

	     if (args.length != 2)
	        { GenericIO.writelnString ("Wrong number of parameters!");
	          System.exit (1);
	        }
	     rmiRegHostName = args[0];
	     try
	     { rmiRegPortNumb = Integer.parseInt (args[1]);
	     }
	     catch (NumberFormatException e)
	     { GenericIO.writelnString ("args[1] is not a number!");
	       System.exit (1);
	     }
	     if ((rmiRegPortNumb < 4000) || (rmiRegPortNumb >= 65536))
	        { GenericIO.writelnString ("args[1] is not a valid port number!");
	          System.exit (1);
	        }

	    /* look for the remote object by name in the remote host registry */

	     String nameEntryDepartureAirport = "DepartureAirport";  
	     String nameEntryPlane = "Plane";
	     String nameEntryDestinationAirport = "DestinationAirport";
	     
	     DepartureAirportInterface departureAirportStub = null;
	     PlaneInterface planeStub = null;
	     DestinationAirportInterface destinationAirportStub = null;
	     
	     Registry registry = null;
	     
	     Pilot pilot;

	     try
	     { registry = LocateRegistry.getRegistry (rmiRegHostName, rmiRegPortNumb);
	     }
	     catch (RemoteException e)
	     { GenericIO.writelnString ("RMI registry creation exception: " + e.getMessage ());
	       e.printStackTrace ();
	       System.exit (1);
	     }
	     
	     //Lookup all the stubs
	     

	     try
	     { departureAirportStub = (DepartureAirportInterface) registry.lookup (nameEntryDepartureAirport);
	     }
	     catch (RemoteException e)
	     { 
	       e.printStackTrace ();
	       System.exit (1);
	     }
	     catch (NotBoundException e)
	     { 
	       e.printStackTrace ();
	       System.exit (1);
	     }
	     
	     try
	     { planeStub = (PlaneInterface) registry.lookup (nameEntryPlane);
	     }
	     catch (RemoteException e)
	     { 
	       e.printStackTrace ();
	       System.exit (1);
	     }
	     catch (NotBoundException e)
	     { 
	       e.printStackTrace ();
	       System.exit (1);
	     }
	     
	     try
	     { destinationAirportStub = (DestinationAirportInterface) registry.lookup (nameEntryDestinationAirport);
	     }
	     catch (RemoteException e)
	     { 
	       e.printStackTrace ();
	       System.exit (1);
	     }
	     catch (NotBoundException e)
	     { 
	       e.printStackTrace ();
	       System.exit (1);
	     }
	     
	     
	     
	     pilot = new Pilot("pilot_" + (1), 0, departureAirportStub, planeStub, destinationAirportStub);

	      /* start of the simulation */

	     pilot.start();
	     
	     /* wait for the end */
	     try
	     { pilot.join ();
	     }
	     catch (InterruptedException e) {}
	     System.out.println("The Pilot "+(1)+" just terminated");
	     
	     try
	      { departureAirportStub.shutdown ();
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("Customer generator remote exception on BarberShop shutdown: " + e.getMessage ());
	        System.exit (1);
	      }
	     try
	      { planeStub.shutdown ();
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("Customer generator remote exception on BarberShop shutdown: " + e.getMessage ());
	        System.exit (1);
	      }
	     try
	      { destinationAirportStub.shutdown ();
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("Customer generator remote exception on BarberShop shutdown: " + e.getMessage ());
	        System.exit (1);
	      }
	      
	     System.out.println("End of the Simulation");
	      
	  }

}
