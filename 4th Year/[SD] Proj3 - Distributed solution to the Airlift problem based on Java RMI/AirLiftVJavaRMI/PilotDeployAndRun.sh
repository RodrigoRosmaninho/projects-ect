echo "Transfering data to the Pilot node."
sshpass -p "qwerty" ssh sd106@l040101-ws07.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws07.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirPilot.zip sd106@l040101-ws07.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the pilot node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws07.ua.pt "cd test/AirLift ; unzip -uq dirPilot.zip"
echo "Executing program at the pilot node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws07.ua.pt 'cd test/AirLift/dirPilot ; ./pilot.sh'