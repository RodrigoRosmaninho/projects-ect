echo "Transfering data to the destinationAirport node."
sshpass -p "qwerty" scp -r genclass.jar destinationAirport.zip sd106@l040101-ws03.ua.pt:/home/sd106
echo "Decompressing data sent to the destinationAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws03.ua.pt "unzip -qo destinationAirport.zip"
echo "Executing program at the destinationAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws03.ua.pt 'java -classpath "genclass.jar:." serverSide.main.DestinationAirportMain'