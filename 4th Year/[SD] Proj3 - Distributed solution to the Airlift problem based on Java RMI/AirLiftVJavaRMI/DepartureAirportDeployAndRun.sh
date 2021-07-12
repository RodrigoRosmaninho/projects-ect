echo "Transfering data to the DepartureAirport node."
sshpass -p "qwerty" ssh sd106@l040101-ws06.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws06.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirDepartureAirport.zip sd106@l040101-ws06.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the departureAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws06.ua.pt "cd test/AirLift ; unzip -uq dirDepartureAirport.zip"
echo "Executing program at the departureAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws06.ua.pt 'cd test/AirLift/dirDepartureAirport ; ./departureAirport.sh'