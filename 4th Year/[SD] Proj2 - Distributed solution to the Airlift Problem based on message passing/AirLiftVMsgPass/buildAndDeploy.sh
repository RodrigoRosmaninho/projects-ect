mkdir -p bin
javac -cp genclass.jar commInfra/*.java serverSide/*/*.java -d bin
javac -cp genclass.jar commInfra/*.java clientSide/*/*.java -d bin
mkdir -p /tmp/commInfra
mkdir -p /tmp/serverSide
mkdir -p /tmp/clientSide
cp -rf bin/commInfra/* /tmp/commInfra
cp -rf bin/serverSide/* /tmp/serverSide
cp -rf bin/clientSide/* /tmp/clientSide
a=$(pwd)
cd /tmp
zip -rq $a/departureAirport.zip serverSide/main/DepartureAirportMain.class serverSide/main/ExecConst.class serverSide/entities/ServiceProviderAgent.class serverSide/sharedRegions/DepartureAirport.class serverSide/sharedRegions/DepartureAirportInterface.class serverSide/sharedRegions/SharedRegionInterface.class serverSide/entities/* serverSide/stubs/* commInfra/*
zip -rq $a/destinationAirport.zip serverSide/main/DestinationAirportMain.class serverSide/main/ExecConst.class serverSide/entities/ServiceProviderAgent.class serverSide/sharedRegions/DestinationAirport.class serverSide/sharedRegions/DestinationAirportInterface.class serverSide/sharedRegions/SharedRegionInterface.class serverSide/entities/* serverSide/stubs/* commInfra/*
zip -rq $a/plane.zip serverSide/main/PlaneMain.class serverSide/main/ExecConst.class serverSide/entities/ServiceProviderAgent.class serverSide/sharedRegions/Plane.class serverSide/sharedRegions/PlaneInterface.class serverSide/sharedRegions/SharedRegionInterface.class serverSide/entities/* serverSide/stubs/* commInfra/*
zip -rq $a/generalRepos.zip serverSide/main/GeneralReposMain.class serverSide/main/ExecConst.class serverSide/entities/ServiceProviderAgent.class serverSide/sharedRegions/GeneralRepos.class serverSide/sharedRegions/GeneralReposInterface.class serverSide/sharedRegions/SharedRegionInterface.class commInfra/* serverSide/entities/*States.class
zip -rq $a/passenger.zip clientSide/main/PassengerMain.class clientSide/main/ExecConst.class clientSide/stubs/* clientSide/entities/Passenger.class clientSide/entities/PassengerStates.class commInfra/*
zip -rq $a/hostess.zip clientSide/main/HostessMain.class clientSide/main/ExecConst.class clientSide/stubs/* clientSide/entities/Hostess.class clientSide/entities/HostessStates.class commInfra/*
zip -rq $a/pilot.zip clientSide/main/PilotMain.class clientSide/main/ExecConst.class clientSide/stubs/* clientSide/entities/Pilot.class clientSide/entities/PilotStates.class commInfra/*
cd $a
