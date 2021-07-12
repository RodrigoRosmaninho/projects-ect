echo "Transfering data to the departureAirport node."
sshpass -p "qwerty" scp -r genclass.jar departureAirport.zip sd106@l040101-ws01.ua.pt:/home/sd106
echo "Decompressing data sent to the departureAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws01.ua.pt "unzip -qo departureAirport.zip"
echo "Executing program at the departureAirport node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws01.ua.pt 'java -classpath "genclass.jar:." serverSide.main.DepartureAirportMain'