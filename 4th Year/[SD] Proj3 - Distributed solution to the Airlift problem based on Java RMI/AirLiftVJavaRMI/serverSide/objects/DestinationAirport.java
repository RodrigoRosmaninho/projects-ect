package serverSide.objects;

import java.rmi.RemoteException;

import clientSide.entities.PilotStates;
import commInfra.ExecConst;
import commInfra.ReturnValue;
import genclass.GenericIO;
import interfaces.DestinationAirportInterface;
import interfaces.GeneralReposInterface;
import serverSide.main.DestinationAirportMain;

/**
 *    Destination Airport.
 *
 *    Shared Region responsible for the update of the number of passengers, and the state of the planes that keep arriving 
 *    Implemented as an implicit monitor (synchronized methods).
 *    All public methods are executed in mutual exclusion.
 *    There are two internal synchronization points: 
 *    	blocking point for the pilot, where he sleeps while all the passengers leave the plane and arrive to the airport;
 *      blocking point for the passenger, where they wait for an update from the Pilot that they have arrived
 */

public class DestinationAirport implements DestinationAirportInterface
{
    /**
     *   Number of passengers that have arrived to the destination.
     */
	
	//private int number_of_pass_arrived;
	

	/**
     *   Reference to the General Repository.
     */
	
    private final GeneralReposInterface repos;
    
    /**
     *   Number of entity groups requesting the shutdown.
     */

    private int nEntities; 
    
    /**
     *  Destination Airport instantiation.
     *
     *    @param reposStub reference to the general repository
     */
    


    public DestinationAirport(GeneralReposInterface reposStub)
    {
    	//number_of_pass_arrived = 0;
        this.repos = reposStub;
        nEntities = 0;
    }
    
    
    /**
     *  
     *  It is called by the pilot in order to fly back to the departure airport.
     *
     */
    
    public synchronized ReturnValue flyToDeparturePoint()
    {
        try {
			repos.setPilotState (PilotStates.FLYING_BACK);
		} catch (RemoteException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        try
        { Thread.sleep ((long) (1 + 100 * Math.random ()));
        }
        catch (InterruptedException e) {}
        return new ReturnValue(false, PilotStates.FLYING_BACK);
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
        if (nEntities >= ExecConst.E_DestAir) {
        	try
			{ repos.printSumUp();
			}
			catch (RemoteException e)
			{ GenericIO.writelnString ("Customer generator remote exception on GeneralRepos shutdown: " + e.getMessage ());
		      System.exit (1);
			}
        	
		    try
			{ repos.shutdown();
			}
			catch (RemoteException e)
			{ GenericIO.writelnString ("Customer generator remote exception on GeneralRepos shutdown: " + e.getMessage ());
		      System.exit (1);
			}
		    DestinationAirportMain.shutdown ();
        }
        notifyAll ();                                       // the barber may now terminate
    }
    
    

}
