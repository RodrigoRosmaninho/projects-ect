package serverSide.main;

import java.net.SocketException;
import java.net.SocketTimeoutException;

import commInfra.ServerCom;
import genclass.GenericIO;
import serverSide.entities.ServiceProviderAgent;
import serverSide.sharedRegions.*;

/**
 *    Server side of the General Information Repository Shared Region.
 *
 *    Request serialization variant.
 *    It waits for the start of the message exchange.
 */

public class GeneralReposMain
{
  /**
   *    Main method.
   *
   *    @param args runtime arguments
   */

    public static void main (String[] args)
    {
      /* service is established */

       ServerCom serverCom, sconi;                                        // communication channels
       int portNumb = 22153;                                          // port nunber for listening to service requests

       serverCom = new ServerCom (portNumb);
       serverCom.start ();                             // service is instantiated
       serverCom.setSoTimeout(10000);
       GenericIO.writelnString ("Service is established!");
       GenericIO.writelnString ("Server is listening for service requests.");

       
       GeneralRepos generalRepos = new GeneralRepos("logger");
       SharedRegionInterface sharedRegionInterface = new GeneralReposInterface(generalRepos);
       
      /* service request processing */
                                        // service provider agent
       while (!sharedRegionInterface.hasShutdown())
       { 
    	 try {
	    	 sconi = serverCom.accept ();                                     // enter listening procedure
	         ServiceProviderAgent serviceProviderAgent = new ServiceProviderAgent (sconi, sharedRegionInterface);            // start a service provider agent to address
	         serviceProviderAgent.start ();      
    	 } 
    	 catch(SocketTimeoutException ste) {}
       }
       
       GenericIO.writelnString ("Service is closed!");
    }
}
