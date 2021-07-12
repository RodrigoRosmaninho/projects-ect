package serverSide.entities;

import commInfra.Message;
import commInfra.ServerCom;
import genclass.GenericIO;
import serverSide.entities.*;
import serverSide.sharedRegions.DepartureAirportInterface;
import serverSide.sharedRegions.SharedRegionInterface;

/**
 *    Service provider agent.
 */

public class ServiceProviderAgent extends Thread implements Pilot, Hostess, Passenger
{
   /**
    *  Communication channel.
    */

    private ServerCom com;
    
    /**
     *  Reference to the provided service.
     */
    
    private SharedRegionInterface shi;

   /**
    *  Service to be provided.
    */

   /**
    *  Instantiation.
    *
    *     @param com communication channel
    *     @param shi reference to provided service
    */

    public ServiceProviderAgent (ServerCom com, SharedRegionInterface shi)
    {
       this.com = com;
       this.shi = shi;
    }

   /**
    *  Life cycle of the service provider agent.
    */

    @Override
    public void run ()
    {

       /* service providing */
       Message message = (Message) com.readObject();
       message = shi.processAndReply(message);
       if (message != null) {
    	   com.writeObject(message);
       }
       
    }
    
  /**
   *  Hostess identification.
   */

  private int hostessId;

  
  /**
   *  Hostess State.
   */

  private int hostessState;

  
  /**
   *   Set Hostess id.
   *
   *     @param id Hostess id
   */

  public void setHostessId (int id)
  {
      hostessId = id;
  }

  
  /**
   *   Get Hostess id.
   *
   *     @return Hostess Id.
   */

  public int getHostessId ()
  {
      return hostessId;
  }

  
  
  /**
   *   Set Hostess state.
   *
   *     @param state Hostess state
   */

  public void setHostessState (int state)
  {
      hostessState = state;
  }


  /**
   *   Get Hostess state.
   *
   *     @return Hostess state.
   */
  
  public int getHostessState ()
  {
      return hostessState;
  }
    
  /**
   *  Pilot identification.
   */
	
  private int pilotId;
  
  /**
   *  Pilot state.
   */
  
  private int pilotState;
  
  public void setPilotId (int id)
  {
      pilotId = id;
  }


  /**
   *   Get Pilot ID.
   *
   *     @return pilot Id
   */
  
  public int getPilotId ()
  {
      return pilotId;
  }
     
  /**
   *   Set Pilot State.
   *
   *     @param state Pilot State
   */

  public void setPilotState (int state)
  {
      pilotState = state;
  }

  
  /**
   *   Get Pilot State.
   *
   *     @return pilot state
   */
  
  public int getPilotState ()
  {
      return pilotState;
  }
  
  /**
	 *  Passenger identification.
	 */
  
  private int passengerId;
  
  
  /**
   *  Passenger State.
   */
  
  private int passengerState;
  
  
  /**
   *  Passenger Flag for the hostess inform that this thread is the next to be checked.
   */
  
  private boolean selected;
  
  
  /**
   *  Passenger Flag to inform the hostess the this thread is ready to show the documents needed.
   */
  
  private boolean endedShow;
  
  
  /**
   *  Passenger Flag for the hostess inform that this thread was already checked (ended check stage).
   */
  
  private boolean wasChecked;

  
  /**
   *   Set Passenger id.
   *
   *     @param id Passenger id
   */

  public void setPassengerId (int id)
  {
      passengerId = id;
  }

  
  /**
   *   Get Passenger id.
   *
   *     @return Passenger Id.
   */

  public int getPassengerId ()
  {
      return passengerId;
  }
  
  
  /**
   *   Set Passenger state.
   *
   *     @param state Passenger state
   */

  public void setPassengerState (int state)
  {
      passengerState = state;
  }

  
  /**
   *   Get Passenger state.
   *
   *     @return Passenger State.
   */

  public int getPassengerState ()
  {
      return passengerState;
  }
  
  
  /**
   *   Get flag to know if this Passenger was selected by the hostess as the next to be checked.
   *
   *     @return Passenger Selected boolean.
   */

  public boolean getSelected(){ return selected;}
  
  
  /**
   *   Set flag to inform this Passenger when he wakes up that was chose to be checked.
   *
   *     @param s boolean
   */

  public void setSelected(boolean s){ selected = s;}
  
  
  /**
   *   Get flag to know if this Passenger ended the showing stage and then is ready to be checked.
   *
   *     @return Passenger EndedShow boolean.
   */

  public boolean getEndedShow(){ return endedShow;}
  
  
  /**
   *   Set flag to inform the hostess that this passenger is ready to be checked.
   *
   *     @param b boolean
   */

  public void setEndedShow(boolean b) { endedShow = b; }
  
  /**
   *  Get flag to know if this Passenger ended the checking stage and is now ready to go to the plane.
   *
   *     @return Passenger wasChecked boolean.
   */

  public boolean getWasChecked(){ return wasChecked;}
  
  
  /**
   *   Set flag to inform this Passenger when he wakes up that he was already checked.
   *
   *     @param b boolean
   */

  public void setWasChecked(boolean b) { wasChecked = b; }

}
