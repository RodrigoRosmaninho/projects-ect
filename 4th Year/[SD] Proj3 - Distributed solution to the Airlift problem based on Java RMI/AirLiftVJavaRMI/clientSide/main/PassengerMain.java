package clientSide.main;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import clientSide.entities.Passenger;
import commInfra.ExecConst;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import genclass.GenericIO;
import interfaces.DepartureAirportInterface;
import interfaces.GeneralReposInterface;
import interfaces.PlaneInterface;

/**
 *    Client side of the airlift project
 *
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on Java RMI.
 */

public class PassengerMain
{
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
     
     DepartureAirportInterface departureAirportStub = null;
     PlaneInterface planeStub = null;
     
     Registry registry = null;
     
     Passenger [] pass = new Passenger [ExecConst.N];

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
     
     
     
     for (int i = 0; i < ExecConst.N; i++)
         pass[i] = new Passenger ("passenger_" + (i+1), i, departureAirportStub, planeStub);

      /* start of the simulation */

     for (int i = 0; i < ExecConst.N; i++)
         pass[i].start ();
     
     /* wait for the end */
     for (int i = 0; i < ExecConst.N; i++)
     { try
     { pass[i].join ();
     }
     catch (InterruptedException e) {}
     System.out.println("The Passenger "+(i+1)+" just terminated");
     }
     
     try
     { planeStub.shutdown ();
     }
     catch (RemoteException e)
     { GenericIO.writelnString ("Customer generator remote exception on BarberShop shutdown: " + e.getMessage ());
       System.exit (1);
     }
    try
     { departureAirportStub.shutdown ();
     }
     catch (RemoteException e)
     { GenericIO.writelnString ("Customer generator remote exception on BarberShop shutdown: " + e.getMessage ());
       System.exit (1);
     }
     
     System.out.println("End of the Simulation");
      
  }
}
