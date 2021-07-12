package sharedRegions;

import main.*;
import entities.*;
import genclass.GenericIO;
import genclass.TextFile;
import java.util.Objects;

/**
 *  General Repository.
 *
 *    It is responsible to keep the visible internal state of the problem and to provide means for it
 *    to be printed in the logging file.
 *    It is implemented as an implicit monitor.
 *    All public methods are executed in mutual exclusion.
 *    There are no internal synchronization points.
 */

public class GeneralRepos
{
  /**
   *  Name of the logging file.
   */

   private final String logFileName;


  /**
   *  State of the pilot.
   */

   private int pilotState;

  /**
   *  State of the hostess.
   */

   private int hostessState;
   
   
   /**
    *  States of the passengers.
    */

   private int [] passengerState;
   
   /**
    *  Counter with the number of passengers waiting on the departure airport queue
    */

   private int passengersInDepartureQueue;
   
   
   /**
    *  Counter with the number of passengers waiting in the plane
    */
   
   private int passengersInPlane;
   
   
   /**
    *  Counter with the number of passengers that have already arrived at the destination airport
    */
   
   private int passengersArrived;
   
   /**
    *  Counter with the current flight number.
    */
   
   private int flightnumber;
   
   /**
    *  Variable used to construct the final sum up print by concatenating string with the results from each flight.
    */
   
   private String sumUp = "Airlift sum up:";

  /**
   *   Instantiation of a general repository object.
   *
   *     @param logFileName name of the logging file
   */

   public GeneralRepos (String logFileName)
   {
      if ((logFileName == null) || Objects.equals (logFileName, ""))
         this.logFileName = "logger";
         else this.logFileName = logFileName;
      
      pilotState = PilotStates.AT_TRANSFER_GATE;
      hostessState = HostessStates.WAIT_FOR_NEXT_FLIGHT;
      passengerState = new int [ExecConst.N];
      for (int i = 0; i < ExecConst.N; i++)
        passengerState[i] = PassengerStates.GOING_TO_AIRPORT;

      passengersInDepartureQueue = 0;
      passengersInPlane = 0;
      passengersArrived = 0;
      flightnumber = 1;
      
      
      reportInitialStatus ();
   }


   /**
    *   Update Counter PassengersInDepartureQueue
    *
    *     @param value integer
    */

  public synchronized void updatePassengersInDepartureQueue (int value)
  {
      passengersInDepartureQueue = passengersInDepartureQueue+value;
  }
  
  /**
   *   Update Counter PassengersInPlane
   *
   *     @param value integer
   */

   public synchronized void updatePassengersInPlane (int value)
   {
      passengersInPlane = passengersInPlane+value;
   }
   
   /**
    *   Update Counter PassengersArrived
    *
    *     @param value integer
    */

   public synchronized void updatePassengersArrived (int value)
   {
      passengersArrived = passengersArrived+value;
   }

   
   /**
    *   Set pilot state.
    *
    *     @param state pilot state
    */

   public synchronized void setPilotState (int state)
   {
	  
	  switch(state) {
	  	case PilotStates.AT_TRANSFER_GATE:
	  		flightnumber++;
	  		break;
	  	case PilotStates.READY_FOR_BOARDING:
	  		printText("boarding started");
	  		break;
	  	case PilotStates.DEBOARDING:
	  		printText("arrived");
	  		break;
	  	case PilotStates.FLYING_BACK:
	  		printText("returning");
	  		break;
	  }
      pilotState = state;
      reportStatus ();
   }
   
   /**
    *   Write to the logging file that a passenger is starting to be checked.
    *
    *     @param id passenger id
    */

   
   public synchronized void logPassengerCheck(int id)
   {
	   printText("passenger " + id + " checked");
   }
   
   /**
    *   Set hostess state.
    *
    *     @param state hostess state
    */

   public synchronized void setHostessState (int state)
   {
	  if(state == HostessStates.READY_TO_FLY) {
		  printText("departed with " + passengersInPlane + " passengers");
		  sumUp += "\nFlight " + flightnumber + " transported " + passengersInPlane + " passengers";
	  }
      hostessState = state;
      reportStatus ();
   }

   
   /**
    *   Set passenger state.
    *
    *	  @param passengerId passenger id
    *     @param state passenger state
    */
   
   public synchronized void setPassengerState (int passengerId, int state)
   {
      passengerState[passengerId] = state;
      reportStatus ();
   }



  /**
   *  Write the header and the initial states to the logging file.
   *
   *  
   */

   private void reportInitialStatus ()
   {
      TextFile log = new TextFile ();                      // instantiation of a text file handler

      if (!log.openForWriting (".", logFileName))
         { GenericIO.writelnString ("The operation of creating the file " + logFileName + " failed!");
           System.exit (1);
         }
      log.writelnString ("                                          Airlift - Description of the internal state");
      log.writelnString (" PT   HT   P00  P01  P02  P03  P04  P05  P06  P07  P08  P09  P10  P11  P12  P13  P14  P15  P16  P17  P18  P19  P20 InQ InF PTAL");
      if (!log.close ())
         { GenericIO.writelnString ("The operation of closing the file " + logFileName + " failed!");
           System.exit (1);
         }
      reportStatus ();
   }

  /**
   *  Write a state line at the end of the logging file.
   *
   *  The current state of entities is organized in a line to be printed.
   * 
   */

   private void reportStatus ()
   {
      TextFile log = new TextFile ();                      // instantiation of a text file handler

      String lineStatus = "";                              // state line to be printed

      if (!log.openForAppending (".", logFileName))
         { GenericIO.writelnString ("The operation of opening for appending the file " + logFileName + " failed!");
           System.exit (1);
         }

      switch (pilotState){
         case PilotStates.AT_TRANSFER_GATE: lineStatus += "ATRG ";
                                             break;
         case PilotStates.READY_FOR_BOARDING: lineStatus += "RDFB ";
                                             break;
         case PilotStates.WAIT_FOR_BOARDING: lineStatus += "WTFB ";
                                             break;
         case PilotStates.FLYING_FORWARD: lineStatus += "FLFW ";
                                             break;
         case PilotStates.DEBOARDING: lineStatus += "DRPP ";
                                             break;
         case PilotStates.FLYING_BACK: lineStatus += "FLBK ";
                                             break;
      }

      switch (hostessState){
         case HostessStates.WAIT_FOR_NEXT_FLIGHT: lineStatus += "WTFL ";
                                             break;
         case HostessStates.WAIT_FOR_PASSENGER: lineStatus += "WTPS ";
                                             break;
         case HostessStates.CHECK_PASSENGER: lineStatus += "CKPS ";
                                             break;
         case HostessStates.READY_TO_FLY: lineStatus += "RDTF ";
                                             break;
      }

      for (int i = 0; i < ExecConst.N; i++)
        switch (passengerState[i])
        { case PassengerStates.GOING_TO_AIRPORT:  lineStatus += "GTAP ";
                                             break;
          case PassengerStates.IN_QUEUE: lineStatus += "INQE ";
                                             break;
          case PassengerStates.IN_FLIGHT:      lineStatus += "INFL ";
                                             break;
          case PassengerStates.AT_DESTINATION:    lineStatus += "ATDS ";
                                             break;
        }
      
      lineStatus += " "+String.format("%2d", passengersInDepartureQueue)+"  "+String.format("%2d", passengersInPlane)+"  "+String.format("%2d", passengersArrived)+"\t";
      log.writelnString (lineStatus);
      if (!log.close ())
         { GenericIO.writelnString ("The operation of closing the file " + logFileName + " failed!");
           System.exit (1);
         }
   }
   
   /**
    *   Write to the logging file a message that is decorated with the current flight number.
    *
    *     @param msg String
    *     Auxiliary function
    */
   
   private void printText(String msg)
   {
	   TextFile log = new TextFile ();  

       if (!log.openForAppending (".", logFileName))
          { GenericIO.writelnString ("The operation of opening for appending the file " + logFileName + " failed!");
            System.exit (1);
          }
       
	   log.writelnString("\nFlight " + flightnumber + ": " + msg + ".");
	   
	   if (!log.close ())
       { GenericIO.writelnString ("The operation of closing the file " + logFileName + " failed!");
         System.exit (1);
       }
   }
   
   /**
    *   Write to the logging file the result of the sum up variable.
    *
    */
   
   public void printSumUp() 
   {
	   TextFile log = new TextFile ();  

       if (!log.openForAppending (".", logFileName))
          { GenericIO.writelnString ("The operation of opening for appending the file " + logFileName + " failed!");
            System.exit (1);
          }
       
	   log.writelnString("\n" + sumUp + ".");
	   
	   if (!log.close ())
       { GenericIO.writelnString ("The operation of closing the file " + logFileName + " failed!");
         System.exit (1);
       }
   }
}

