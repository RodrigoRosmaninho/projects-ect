echo "Transfering data to the Hostess node."
sshpass -p "qwerty" ssh sd106@l040101-ws06.ua.pt 'mkdir -p test/AirLift'
#sshpass -p "qwerty" ssh sd106@l040101-ws06.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirHostess.zip sd106@l040101-ws06.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the hostess node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws06.ua.pt "cd test/AirLift ; unzip -uq dirHostess.zip"
echo "Executing program at the hostess node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws06.ua.pt 'cd test/AirLift/dirHostess ; ./hostess.sh'