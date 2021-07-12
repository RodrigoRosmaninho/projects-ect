echo "Transfering data to the Registry node."
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirRegistry.zip sd106@l040101-ws09.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the registry node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws09.ua.pt "cd test/AirLift ; unzip -uq dirRegistry.zip"
echo "Executing program at the registry node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws09.ua.pt 'cd test/AirLift/dirRegistry ; ./registry.sh'