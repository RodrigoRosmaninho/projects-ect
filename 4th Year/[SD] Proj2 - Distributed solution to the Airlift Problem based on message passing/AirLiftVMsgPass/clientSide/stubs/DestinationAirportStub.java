package clientSide.stubs;

import clientSide.entities.Pilot;
import commInfra.CommunicationChannel;
import commInfra.Message;

/**
 *  Stub to the destination airport.
 *
 *    It instantiates a remote reference to the destination airport.
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on a communication channel under the TCP protocol.
 **/

public class DestinationAirportStub {
	
	    /**
	    *  Name of the computational system where the server is located.
	    */

	    private String serverHostName;

	    /**
	    *  Number of the listening port at the computational system where the server is located.
	    */

	    private int serverPortNumb;

	    /**
	    *  Instantiation of a remote reference
	    *
	    *    @param hostName name of the computational system where the server is located
	    *    @param port number of the listening port at the computational system where the server is located
	    */

	    public DestinationAirportStub (String hostName, int port)
	    {
	       serverHostName = hostName;
	       serverPortNumb = port;
	    }
	    
	    /**
	     *   Transitions the pilot from the 'waiting for boarding' state to the 'flying forward' state and sleeps for a randomly selected time.
	     */
	    
	    public void flyToDeparturePoint() {
		   Pilot p = (Pilot) Thread.currentThread ();
		   CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
		   Object[] params = new Object[0];
		   Object[] state_fields = new Object[2];
		   state_fields[0] = p.getPilotId();
		   state_fields[1] = p.getPilotState();
		      	
	       Message m_toServer = new Message(15, params, 0, state_fields, 2, null);                                                          
	       Message m_fromServer;            
	       
	       while (!com.open ())                                                      
	       { try
	         { Thread.currentThread ().sleep ((long) (10));
	         }
	         catch (InterruptedException e) {}
	       }
	       
	       com.writeObject (m_toServer);
	       
	       m_fromServer = (Message) com.readObject();                 
	      
	       p.setPilotState((Integer) m_fromServer.getStateFields()[1]);
	       
	       com.close ();
		}
	    
	    /**
	    *
	    *Method called to shutdown the destination airport server
	    *
	    */
	    
	    public void shutdown() {
	    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
	    	Object[] params = new Object[0];
	    	Object[] state_fields = new Object[0];
	    	
	        Message m_toServer = new Message(24, params, 0, state_fields, 0, null);                                                          
	        Message m_fromServer;            
	        
	        while (!com.open ())                                                      
	        { try
	          { Thread.currentThread ().sleep ((long) (10));
	          }
	          catch (InterruptedException e) {}
	        }
	        
	        com.writeObject (m_toServer);
	        
	        com.close ();
	    }

}
