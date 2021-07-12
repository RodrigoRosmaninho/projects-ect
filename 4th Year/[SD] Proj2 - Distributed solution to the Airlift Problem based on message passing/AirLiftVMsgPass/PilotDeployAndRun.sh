echo "Transfering data to the Pilot node."
sshpass -p "qwerty" scp -r genclass.jar pilot.zip sd106@l040101-ws07.ua.pt:/home/sd106
echo "Decompressing data sent to the pilot node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws07.ua.pt "unzip -qo pilot.zip"
echo "Executing program at the pilot node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws07.ua.pt 'java -classpath "genclass.jar:." clientSide.main.PilotMain'