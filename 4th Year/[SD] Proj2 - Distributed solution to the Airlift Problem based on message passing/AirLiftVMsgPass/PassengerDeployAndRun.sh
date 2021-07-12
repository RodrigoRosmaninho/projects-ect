echo "Transfering data to the Passengers node."
sshpass -p "qwerty" scp -r genclass.jar passenger.zip sd106@l040101-ws05.ua.pt:/home/sd106
echo "Decompressing data sent to the passenger node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws05.ua.pt "unzip -qo passenger.zip"
echo "Executing program at the passenger node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws05.ua.pt 'java -classpath "genclass.jar:." clientSide.main.PassengerMain'