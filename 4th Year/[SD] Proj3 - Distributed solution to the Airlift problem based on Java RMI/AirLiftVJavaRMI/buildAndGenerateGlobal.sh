echo "Removing directories."
rm -rf dir*/*/
echo "Compiling source code."
javac -cp genclass.jar */*.java */*/*.java
echo "Distributing intermediate code to the different execution environments."
echo "  RMI registry"
rm -rf dirRMIRegistry/interfaces dirRMIRegistry/commInfra
mkdir -p dirRMIRegistry/interfaces dirRMIRegistry/commInfra
cp interfaces/*.class dirRMIRegistry/interfaces
cp commInfra/*.class dirRMIRegistry/commInfra
echo "  Register Remote Objects"
rm -rf dirRegistry/serverSide dirRegistry/interfaces dirRegistry/commInfra
mkdir -p dirRegistry/serverSide dirRegistry/serverSide/main dirRegistry/serverSide/objects dirRegistry/interfaces dirRegistry/commInfra
cp commInfra/* dirRegistry/commInfra
cp serverSide/main/RegisterRemoteObjectMain.class dirRegistry/serverSide/main
cp serverSide/objects/RegisterRemoteObject.class dirRegistry/serverSide/objects
cp interfaces/RegisterInterface.class dirRegistry/interfaces
echo "  General Repository of Information"
rm -rf dirGeneralRepos/serverSide dirGeneralRepos/clientSide dirGeneralRepos/interfaces
mkdir -p dirGeneralRepos/serverSide dirGeneralRepos/serverSide/main dirGeneralRepos/serverSide/objects dirGeneralRepos/interfaces \
         dirGeneralRepos/clientSide dirGeneralRepos/clientSide/entities dirGeneralRepos/commInfra
cp commInfra/* dirGeneralRepos/commInfra
cp serverSide/main/GeneralReposMain.class dirGeneralRepos/serverSide/main
cp serverSide/objects/GeneralRepos.class dirGeneralRepos/serverSide/objects
cp interfaces/RegisterInterface.class interfaces/GeneralReposInterface.class dirGeneralRepos/interfaces
cp clientSide/entities/PassengerStates.class clientSide/entities/HostessStates.class clientSide/entities/PilotStates.class dirGeneralRepos/clientSide/entities
echo "  Departure Airport"
rm -rf dirDepartureAirport/serverSide dirDepartureAirport/clientSide dirDepartureAirport/interfaces dirDepartureAirport/commInfra
mkdir -p dirDepartureAirport/serverSide dirDepartureAirport/serverSide/main dirDepartureAirport/serverSide/objects dirDepartureAirport/interfaces \
         dirDepartureAirport/clientSide dirDepartureAirport/clientSide/entities dirDepartureAirport/commInfra
cp serverSide/main/DepartureAirportMain.class dirDepartureAirport/serverSide/main
cp serverSide/objects/DepartureAirport.class dirDepartureAirport/serverSide/objects
cp interfaces/*.class dirDepartureAirport/interfaces
cp clientSide/entities/PassengerStates.class clientSide/entities/HostessStates.class clientSide/entities/PilotStates.class dirDepartureAirport/clientSide/entities
cp commInfra/* dirDepartureAirport/commInfra
echo "  Destination Airport"
rm -rf dirDestinationAirport/serverSide dirDestinationAirport/clientSide dirDestinationAirport/interfaces dirDestinationAirport/commInfra
mkdir -p dirDestinationAirport/serverSide dirDestinationAirport/serverSide/main dirDestinationAirport/serverSide/objects dirDestinationAirport/interfaces \
         dirDestinationAirport/clientSide dirDestinationAirport/clientSide/entities dirDestinationAirport/commInfra
cp commInfra/* dirDestinationAirport/commInfra
cp serverSide/main/DestinationAirportMain.class dirDestinationAirport/serverSide/main
cp serverSide/objects/DestinationAirport.class dirDestinationAirport/serverSide/objects
cp interfaces/*.class dirDestinationAirport/interfaces
cp clientSide/entities/PassengerStates.class clientSide/entities/PilotStates.class dirDestinationAirport/clientSide/entities
cp commInfra/*.class dirDestinationAirport/commInfra
echo "  Plane"
rm -rf dirPlane/serverSide dirPlane/clientSide dirPlane/interfaces dirPlane/commInfra
mkdir -p dirPlane/serverSide dirPlane/serverSide/main dirPlane/serverSide/objects dirPlane/interfaces \
         dirPlane/clientSide dirPlane/clientSide/entities dirPlane/commInfra
cp serverSide/main/PlaneMain.class dirPlane/serverSide/main
cp serverSide/objects/Plane.class dirPlane/serverSide/objects
cp interfaces/*.class dirPlane/interfaces
cp clientSide/entities/PassengerStates.class clientSide/entities/HostessStates.class clientSide/entities/PilotStates.class dirPlane/clientSide/entities
cp commInfra/*.class dirPlane/commInfra
echo "  Passenger"
rm -rf dirPassenger/clientSide dirPassenger/interfaces
mkdir -p dirPassenger/clientSide dirPassenger/clientSide/main dirPassenger/clientSide/entities \
         dirPassenger/interfaces dirPassenger/commInfra
cp clientSide/main/PassengerMain.class dirPassenger/clientSide/main
cp clientSide/entities/Passenger.class clientSide/entities/PassengerStates.class dirPassenger/clientSide/entities
cp interfaces/* dirPassenger/interfaces
cp commInfra/*.class dirPassenger/commInfra
echo "  Hostess"
rm -rf dirHostess/serverSide dirHostess/clientSide dirHostess/interfaces
mkdir -p dirHostess/clientSide dirHostess/clientSide/main dirHostess/clientSide/entities \
         dirHostess/interfaces dirHostess/commInfra
cp clientSide/main/HostessMain.class dirHostess/clientSide/main
cp clientSide/entities/Hostess.class clientSide/entities/HostessStates.class dirHostess/clientSide/entities
cp interfaces/* dirHostess/interfaces
cp commInfra/*.class dirHostess/commInfra
echo "  Pilot"
rm -rf dirPilot/clientSide dirPilot/interfaces
mkdir -p dirPilot/clientSide dirPilot/clientSide/main dirPilot/clientSide/entities \
         dirPilot/interfaces dirPilot/commInfra
cp clientSide/main/PilotMain.class dirPilot/clientSide/main
cp clientSide/entities/Pilot.class clientSide/entities/PilotStates.class dirPilot/clientSide/entities
cp interfaces/* dirPilot/interfaces
cp commInfra/*.class dirPilot/commInfra
echo "Compressing execution environments."
echo "  RMI registry"
rm -f  dirRMIRegistry.zip
zip -rq dirRMIRegistry.zip dirRMIRegistry
echo "  Register Remote Objects"
rm -f  dirRegistry.zip
zip -rq dirRegistry.zip dirRegistry
echo "  General Repository of Information"
rm -f  dirGeneralRepos.zip
zip -rq dirGeneralRepos.zip dirGeneralRepos
echo "  Departure Airport"
rm -f  dirDepartureAirport.zip
zip -rq dirDepartureAirport.zip dirDepartureAirport
echo "  Destination Airport"
rm -f  dirDestinationAirport.zip
zip -rq dirDestinationAirport.zip dirDestinationAirport
echo "  Plane"
rm -f  dirPlane.zip
zip -rq dirPlane.zip dirPlane
echo "  Passenger"
rm -f  dirPassenger.zip
zip -rq dirPassenger.zip dirPassenger
echo "  Hostess"
rm -f  dirHostess.zip
zip -rq dirHostess.zip dirHostess
echo "  Pilot"
rm -f  dirPilot.zip
zip -rq dirPilot.zip dirPilot


