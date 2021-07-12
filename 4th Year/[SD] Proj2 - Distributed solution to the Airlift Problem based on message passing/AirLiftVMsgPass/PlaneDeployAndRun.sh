echo "Transfering data to the plane node."
sshpass -p "qwerty" scp -r genclass.jar plane.zip sd106@l040101-ws02.ua.pt:/home/sd106
echo "Decompressing data sent to the plane node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws02.ua.pt "unzip -qo plane.zip"
echo "Executing program at the plane node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws02.ua.pt 'java -classpath "genclass.jar:." serverSide.main.PlaneMain'