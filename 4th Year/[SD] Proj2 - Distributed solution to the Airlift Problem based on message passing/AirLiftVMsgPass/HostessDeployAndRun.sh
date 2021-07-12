echo "Transfering data to the Hostess node."
sshpass -p "qwerty" scp -r genclass.jar hostess.zip sd106@l040101-ws06.ua.pt:/home/sd106
echo "Decompressing data sent to the hostess node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws06.ua.pt "unzip -qo hostess.zip"
echo "Executing program at the hostess node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws06.ua.pt 'java -classpath "genclass.jar:." clientSide.main.HostessMain'