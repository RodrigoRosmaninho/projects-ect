package serverSide.stubs;

import commInfra.CommunicationChannel;
import commInfra.Message;
import serverSide.entities.*;

/**
 *  Stub to the general repository.
 *
 *    It instantiates a remote reference to the general repository.
 *    Implementation of a client-server model of type 2 (server replication).
 *    Communication is based on a communication channel under the TCP protocol.
 */

public class GeneralReposStub {
	
	
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

    public GeneralReposStub (String hostName, int port)
    {
       serverHostName = hostName;
       serverPortNumb = port;
    }
    
/**
   *   Set hostess state.
   *
   *     @param state hostess state
   */

    public void setHostessState(int state)
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[1];
    	Object[] state_fields = new Object[0];
    	params[0] = state;
    	
        Message m_toServer = new Message(16, params, 1, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
   *   Set passenger state.
   *
   *     @param passengerId passenger id
   *     @param state passenger state
   */
    
    public void setPassengerState(int passengerId, int state)
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[2];
    	Object[] state_fields = new Object[0];
    	params[0] = passengerId;
    	params[1] = state;
    	
        Message m_toServer = new Message(17, params, 2, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
   *   Set pilot state.
   *
   *     @param state pilot state
   */
    
    public void setPilotState(int state)
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[1];
    	Object[] state_fields = new Object[0];
    	params[0] = state;
    	
        Message m_toServer = new Message(18, params, 1, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
   *   Update Counter PassengersInPlane
   *
   *     @param value integer
   */
    
    public void updatePassengersInPlane(int value)
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[1];
    	Object[] state_fields = new Object[0];
    	params[0] = value;
    	
        Message m_toServer = new Message(19, params, 1, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
    *   Update Counter PassengersArrived
    *
    *     @param value integer
    */
    
    public void updatePassengersArrived(int value)
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[1];
    	Object[] state_fields = new Object[0];
    	params[0] = value;
    	
        Message m_toServer = new Message(20, params, 1, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
    *   Update Counter PassengersInDepartureQueue
    *
    *     @param value integer
    */
    
    public void updatePassengersInDepartureQueue(int value)
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[1];
    	Object[] state_fields = new Object[0];
    	params[0] = value;
    	
        Message m_toServer = new Message(21, params, 1, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
    *   Write to the logging file that a passenger is starting to be checked.
    *
    *     @param id passenger id
    */
    
    public void logPassengerCheck(int id)
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[1];
    	Object[] state_fields = new Object[0];
    	params[0] = id;
    	
        Message m_toServer = new Message(22, params, 1, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
    *   Write to the logging file the result of the sum up variable.
    *
    */
    
    public void printSumUp()
    {
    	CommunicationChannel com = new CommunicationChannel (serverHostName, serverPortNumb);
    	Object[] params = new Object[0];
    	Object[] state_fields = new Object[0];
    	
        Message m_toServer = new Message(23, params, 0, state_fields, 0, null);                                                          
        Message m_fromServer;            
        
        while (!com.open ())                                                      
        { try
          { Thread.currentThread ().sleep ((long) (10));
          }
          catch (InterruptedException e) {}
        }
        
        com.writeObject (m_toServer);
        
        m_fromServer = (Message) com.readObject();                 
        
        com.close ();                                                             
    }

    /**
    *   Send shutdown message to the GeneraRepos server
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
