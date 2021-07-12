echo "Transfering data to the RMIregistry node."
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'mkdir -p Public/classes/interfaces'
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'rm -rf Public/classes/interfaces/*'
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'mkdir -p Public/classes/commInfra'
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'rm -rf Public/classes/commInfra/*'
sshpass -p "qwerty" scp -r genclass.jar dirRMIRegistry.zip sd106@l040101-ws09.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the RMIregistry node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws09.ua.pt "cd test/AirLift ; unzip -uq dirRMIRegistry.zip"
echo "Executing program at the RMIregistry node."
sshpass -p "qwerty" ssh sd106@l040101-ws09.ua.pt 'cd test/AirLift/dirRMIRegistry ; cp interfaces/*.class /home/sd106/Public/classes/interfaces ; cp commInfra/*.class /home/sd106/Public/classes/commInfra ; cp rmiregistry.sh /home/sd106'
sshpass -p "qwerty" ssh -q sd106@l040101-ws09.ua.pt './rmiregistry.sh 22150'
