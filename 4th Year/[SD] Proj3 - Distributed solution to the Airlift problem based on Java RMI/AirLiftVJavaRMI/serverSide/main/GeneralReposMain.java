package serverSide.main;

import java.rmi.AlreadyBoundException;
import java.rmi.NoSuchObjectException;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

import genclass.GenericIO;
import interfaces.GeneralReposInterface;
import interfaces.RegisterInterface;
import serverSide.objects.GeneralRepos;

/**
 *    Instantiation and registering of the general repository object.
 *
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on Java RMI.
 */

public class GeneralReposMain {
	
	/**
	   *  Flag signaling the end of operations.
	   */

	   private static boolean end = false;

	  /**
	   *  Main method.
	   *
	   *    @param args runtime arguments
	   *        args[0] - port number for listening to service requests
	   *        args[1] - name of the platform where is located the RMI registering service
	   *        args[2] - port nunber where the registering service is listening to service requests
	   */

	   public static void main(String[] args)
	   {
	      int portNumb = -1;                                             // port number for listening to service requests
	      String rmiRegHostName;                                         // name of the platform where is located the RMI registering service
	      int rmiRegPortNumb = -1;                                       // port number where the registering service is listening to service requests

	      if (args.length != 3)
	         { GenericIO.writelnString ("Wrong number of parameters!");
	           System.exit (1);
	         }
	      try
	      { portNumb = Integer.parseInt (args[0]);
	      }
	      catch (NumberFormatException e)
	      { GenericIO.writelnString ("args[0] is not a number!");
	        System.exit (1);
	      }
	      if ((portNumb < 4000) || (portNumb >= 65536))
	         { GenericIO.writelnString ("args[0] is not a valid port number!");
	           System.exit (1);
	         }
	      rmiRegHostName = args[1];
	      try
	      { rmiRegPortNumb = Integer.parseInt (args[2]);
	      }
	      catch (NumberFormatException e)
	      { GenericIO.writelnString ("args[2] is not a number!");
	        System.exit (1);
	      }
	      if ((rmiRegPortNumb < 4000) || (rmiRegPortNumb >= 65536))
	         { GenericIO.writelnString ("args[2] is not a valid port number!");
	           System.exit (1);
	         }

	     /* create and install the security manager */

	      if (System.getSecurityManager () == null)
	         System.setSecurityManager (new SecurityManager ());
	      GenericIO.writelnString ("Security manager was installed!");

	     /* instantiate a general repository object */

	      GeneralRepos repos = new GeneralRepos ("logger");                      // general repository object
	      GeneralReposInterface reposStub = null;                        // remote reference to the general repository object

	      try
	      { reposStub = (GeneralReposInterface) UnicastRemoteObject.exportObject (repos, portNumb);
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("General Repository stub generation exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }
	      GenericIO.writelnString ("Stub was generated!");

	     /* register it with the general registry service */

	      String nameEntryBase = "RegisterHandler";                      // public name of the object that enables the registration
	                                                                     // of other remote objects
	      String nameEntryObject = "GeneralRepository";                  // public name of the object general repository
	      Registry registry = null;                                      // remote reference for registration in the RMI registry service
	      RegisterInterface reg = null;                                           // remote reference to the object that enables the registration
	                                                                     // of other remote objects

	      try
	      { registry = LocateRegistry.getRegistry (rmiRegHostName, rmiRegPortNumb);
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("RMI registry creation exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }
	      GenericIO.writelnString ("RMI registry was created!");

	      try
	      { reg = (RegisterInterface) registry.lookup (nameEntryBase);
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("RegisterRemoteObject lookup exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }
	      catch (NotBoundException e)
	      { GenericIO.writelnString ("RegisterRemoteObject not bound exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }

	      try
	      { reg.bind (nameEntryObject, reposStub);
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("General Repository registration exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }
	      catch (AlreadyBoundException e)
	      { GenericIO.writelnString ("General Repository already bound exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }
	      GenericIO.writelnString ("General Repository object was registered!");

	     /* wait for the end of operations */

	      GenericIO.writelnString ("General Repository is in operation!");
	      try
	      { while (!end)
	          synchronized (Class.forName ("serverSide.main.GeneralReposMain"))
	          { try
	            { (Class.forName ("serverSide.main.GeneralReposMain")).wait ();
	            }
	            catch (InterruptedException e)
	            { GenericIO.writelnString ("General Repository main thread was interrupted!");
	            }
	          }
	      }
	      catch (ClassNotFoundException e)
	      { GenericIO.writelnString ("The data type GeneralReposMain was not found (blocking)!");
	        e.printStackTrace ();
	        System.exit (1);
	      }

	     /* server shutdown */

	      boolean shutdownDone = false;                                  // flag signalling the shutdown of the general repository service

	      try
	      { reg.unbind (nameEntryObject);
	      }
	      catch (RemoteException e)
	      { GenericIO.writelnString ("General Repository deregistration exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }
	      catch (NotBoundException e)
	      { GenericIO.writelnString ("General Repository not bound exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }
	      GenericIO.writelnString ("General Repository was deregistered!");

	      try
	      { shutdownDone = UnicastRemoteObject.unexportObject (repos, true);
	      }
	      catch (NoSuchObjectException e)
	      { GenericIO.writelnString ("General Repository unexport exception: " + e.getMessage ());
	        e.printStackTrace ();
	        System.exit (1);
	      }

	      if (shutdownDone)
	         GenericIO.writelnString ("General Repository was shutdown!");
	   }

	  /**
	   *  Close of operations.
	   */

	   public static void shutdown ()
	   {
	      end = true;
	      try
	      { synchronized (Class.forName ("serverSide.main.GeneralReposMain"))
	        { (Class.forName ("serverSide.main.GeneralReposMain")).notify ();
	        }
	      }
	     catch (ClassNotFoundException e)
	     { GenericIO.writelnString ("The data type GeneralReposMain was not found (waking up)!");
	       e.printStackTrace ();
	       System.exit (1);
	     }
	   }

}
