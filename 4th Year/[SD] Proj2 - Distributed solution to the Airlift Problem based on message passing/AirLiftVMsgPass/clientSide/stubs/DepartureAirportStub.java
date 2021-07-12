package clientSide.stubs;
import clientSide.entities.Hostess;
import clientSide.entities.HostessStates;
import clientSide.entities.Passenger;
import clientSide.entities.Pilot;
import commInfra.CommunicationChannel;
import commInfra.Message;

/**
 *  Stub to the departure airport.
 *
 *    It instantiates a remote reference to the departure airport.
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on a communication channel under the TCP protocol.
 */

public class DepartureAirportStub {
	
	
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

    public DepartureAirportStub (String hostName, int port)
    {
       serverHostName = hostName;
       serverPortNumb = port;
    }
    
    /**
     *   Places the Passenger in the FIFO Queue, transitions the Passenger from the 'going to Airport' state to the 'in queue' state, awakens the hostess, and sleeps while waiting to be called by the hostess
    **/
    
    public void waitInQueue()
    {
    	Passenger p = (Passenger) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getPassengerId();
    	state_fields[1] = p.getPassengerState();
    	
        Message m_toServer = new Message(4, params, 0, state_fields, 2, null);                                                          
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
     *   Wakes the Hostess to signal that the documents were shown and sleeps while waiting for the hostess to validate them
     */
    
    public void showDocuments()
    {
    	Passenger p = (Passenger) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getPassengerId();
    	state_fields[1] = p.getPassengerState();
    	
        Message m_toServer = new Message(5, params, 0, state_fields, 2, null);                                                          
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
     *	 Transitions the Passenger from the 'in queue' state to the 'in flight' state and awakens the hostess
     */
    
    public void boardThePlane()
    {
    	Passenger p = (Passenger) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getPassengerId();
    	state_fields[1] = p.getPassengerState();
    	
        Message m_toServer = new Message(6, params, 0, state_fields, 2, null);                                                          
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
     *   Sleeps while waiting for the pilot to signal the plane is ready for boarding, then transitions the Hostess from the 'wait for flight' state to the 'wait for passenger' state, and sleeps while waiting to be called by an arriving passenger
     *   
     *     @return Flag that specifies whether to terminate the Hostess thread (true) or not (false)
     */
    
    public boolean prepareForPassBoarding() {
    	Hostess p = (Hostess) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getHostessId();
    	state_fields[1] = p.getHostessState();
    	
        Message m_toServer = new Message(0, params, 0, state_fields, 2, null);                                                          
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
        boolean result = (Boolean) m_fromServer.getReturnValue();
        
        com.close ();
        return result;
    }
    
    /**
     *	 Dequeues a Passenger, transitions the Hostess from the 'wait for passenger' state to the 'check passenger' state, awakens the passenger, and sleeps while waiting for the passenger to show the requested documents.
     */
    
    public void checkDocuments() {
    	Hostess p = (Hostess) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getHostessId();
    	state_fields[1] = p.getHostessState();
    	
        Message m_toServer = new Message(1, params, 0, state_fields, 2, null);                                                          
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
     *	 Transitions the Hostess from the 'check passenger' state to the 'wait for passenger' state and wakes up the passenger that was just validated.
     *   Also verifies if either:
     *   1 - the queue is empty and the number of passengers aboard the plane allows for the flight to begin
     *   2 - the plane is full
     *   3 - the plane is not full and the queue is not empty
     *   If neither of these conditions are met, sleeps while waiting for either a checked in passenger to board the plane or for a new passenger to arrive to the airport queue.
     *   
     *     @return Flag that specifies whether to call the informPlaneReadyToTakeOff operation (true) or the checkDocuments operation (false)
     */
    
    
    public boolean waitForNextPassenger() {
    	Hostess p = (Hostess) Thread.currentThread ();
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[2];
    	state_fields[0] = p.getHostessId();
    	state_fields[1] = p.getHostessState();
    	
        Message m_toServer = new Message(2, params, 0, state_fields, 2, null);                                                          
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
        boolean result = (Boolean) m_fromServer.getReturnValue();
        
        com.close ();
        return result;
    }
    
    /**
    *
    *Method called at the start of the life cycle of the passenger in order to simulate a random traveling time between his home and the departure airport.
    *
    */

   public void waitForNextFlight(){
	   Hostess p = (Hostess) Thread.currentThread ();
	   CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
	   Object[] params = new Object[0];
	   Object[] state_fields = new Object[2];
	   state_fields[0] = p.getHostessId();
	   state_fields[1] = p.getHostessState();
   	
       Message m_toServer = new Message(3, params, 0, state_fields, 2, null);                                                          
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
    *   Transitions the pilot from the 'at transfer gate' state to the 'ready for boarding' state and awakens the hostess
    */
   
   public void informPlaneReadyForBoarding() {
	   Pilot p = (Pilot) Thread.currentThread ();
	   CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
	   Object[] params = new Object[0];
	   Object[] state_fields = new Object[2];
	   state_fields[0] = p.getPilotId();
	   state_fields[1] = p.getPilotState();
   	
       Message m_toServer = new Message(7, params, 0, state_fields, 2, null);                                                          
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
    *   Transitions the pilot from the 'waiting for boarding' state to the 'flying forward' state and sleeps for a randomly selected time.
    */
   
   public void flyToDestinationPoint() {
	   Pilot p = (Pilot) Thread.currentThread ();
	   CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
	   Object[] params = new Object[0];
	   Object[] state_fields = new Object[2];
	   state_fields[0] = p.getPilotId();
	   state_fields[1] = p.getPilotState();
	      	
       Message m_toServer = new Message(9, params, 0, state_fields, 2, null);                                                          
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
    *	 Transitions the Pilot from the 'flying back' state to the 'at transfer gate' state
    *
    *     @return Flag that specifies whether to terminate the Pilot thread (true) or not (false)
    */
   
   public boolean parkAtTransferGate() {
	   Pilot p = (Pilot) Thread.currentThread ();
   	   CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
   	   Object[] params = new Object[0];
   	   Object[] state_fields = new Object[2];
   	   state_fields[0] = p.getPilotId();
   	   state_fields[1] = p.getPilotState();
   	
       Message m_toServer = new Message(8, params, 0, state_fields, 2, null);                                                          
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
       boolean result = (Boolean) m_fromServer.getReturnValue();
       
       com.close ();
       return result; 
   }
   
   /**
   *
   *Method called to shutdown the departure airport server
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
