echo "Transfering data to the DestinationAirport node."
sshpass -p "qwerty" ssh sd106@l040101-ws03.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws03.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirDestinationAirport.zip sd106@l040101-ws03.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the destinationAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws03.ua.pt "cd test/AirLift ; unzip -uq dirDestinationAirport.zip"
echo "Executing program at the destinationAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws03.ua.pt 'cd test/AirLift/dirDestinationAirport ; ./destinationAirport.sh'