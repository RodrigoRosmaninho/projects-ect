package clientSide.stubs;

import clientSide.entities.Hostess;
import clientSide.entities.Passenger;
import clientSide.entities.Pilot;
import commInfra.CommunicationChannel;
import commInfra.Message;

/**
 *  Stub to the plane.
 *
 *    It instantiates a remote reference to the plane.
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on a communication channel under the TCP protocol.
 */

public class PlaneStub {
	
	
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

    public PlaneStub (String hostName, int port)
    {
       serverHostName = hostName;
       serverPortNumb = port;
    }
    
    /**
     *  
     *  It is called by the passengers to synchronize their thread sleeps with the arrival of the plane to the destination
     *
     */
    
    public void waitForEndOfFlight()
    {
    	Passenger p = (Passenger) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getPassengerId();
    	state_fields[1] = p.getPassengerState();
    	
        Message m_toServer = new Message(11, params, 0, state_fields, 2, null);                                                          
        Message m_fromServer;            
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
       
        p.setPassengerState((Integer) m_fromServer.getStateFields()[1]);
        
        com.close ();                                                                                 // close the connection
    }
    
    /**
     *  
     *  It is called by a passenger when he is waked by the pilot and needs to leave the plane.
     *
     */
    
    public void leaveThePlane()
    {
    	Passenger p = (Passenger) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getPassengerId();
    	state_fields[1] = p.getPassengerState();
    	
        Message m_toServer = new Message(12, params, 0, state_fields, 2, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
       
        p.setPassengerState((Integer) m_fromServer.getStateFields()[1]);
        
        com.close ();                      
    }
    
    /**
     *   Transitions the hostess from the 'wait for passenger' state to the 'ready to fly' state and awakens the pilot
     */
    
    public void informPlaneReadyToTakeOff() {
    	Hostess p = (Hostess) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getHostessId();
    	state_fields[1] = p.getHostessState();
    	
        Message m_toServer = new Message(10, params, 0, state_fields, 2, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
       
        p.setHostessState((Integer) m_fromServer.getStateFields()[1]);
        
        com.close ();
    }
    
    /**
     *   Transitions the pilot from the 'ready for boarding' state to the 'waiting for boarding' state and sleeps while waiting for the hostess to signal that the plane is ready to depart
     */
    
    public void waitForAllOnBoard() {
       Pilot p = (Pilot) Thread.currentThread ();
 	   CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
 	   Object[] params = new Object[0];
 	   Object[] state_fields = new Object[2];
 	   state_fields[0] = p.getPilotId();
 	   state_fields[1] = p.getPilotState();
    	
        Message m_toServer = new Message(13, params, 0, state_fields, 2, null);                                                          
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
     *  It is called by the pilot to inform all the passengers that the plane has arrived to the destination
     *  and then the pilot waits for all the passengers to leave in order to take the plane back
     *
     */
    
    public void announceArrival() {
       Pilot p = (Pilot) Thread.currentThread ();
  	   CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
  	   Object[] params = new Object[0];
  	   Object[] state_fields = new Object[2];
  	   state_fields[0] = p.getPilotId();
  	   state_fields[1] = p.getPilotState();
     	
         Message m_toServer = new Message(14, params, 0, state_fields, 2, null);                                                          
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
    * Method called to shutdown the plane server
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
