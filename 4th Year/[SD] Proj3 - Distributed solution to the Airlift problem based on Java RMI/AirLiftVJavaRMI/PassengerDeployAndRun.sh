echo "Transfering data to the Passenger node."
sshpass -p "qwerty" ssh sd106@l040101-ws05.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws05.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirPassenger.zip sd106@l040101-ws05.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the passenger node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws05.ua.pt "cd test/AirLift ; unzip -uq dirPassenger.zip"
echo "Executing program at the passenger node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws05.ua.pt 'cd test/AirLift/dirPassenger ; ./passenger.sh'