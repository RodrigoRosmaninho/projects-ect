echo "Transfering data to the Plane node."
sshpass -p "qwerty" ssh sd106@l040101-ws02.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws02.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirPlane.zip sd106@l040101-ws02.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the plane node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws02.ua.pt "cd test/AirLift ; unzip -uq dirPlane.zip"
echo "Executing program at the plane node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws02.ua.pt 'cd test/AirLift/dirPlane ; ./plane.sh'