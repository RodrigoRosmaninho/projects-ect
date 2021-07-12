echo "Transfering data to the GeneralRepos node."
sshpass -p "qwerty" ssh sd106@l040101-ws08.ua.pt 'mkdir -p test/AirLift'
sshpass -p "qwerty" ssh sd106@l040101-ws08.ua.pt 'rm -rf test/AirLift/*'
sshpass -p "qwerty" scp -r genclass.jar dirGeneralRepos.zip sd106@l040101-ws08.ua.pt:/home/sd106/test/AirLift
echo "Decompressing data sent to the generalRepos node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws08.ua.pt "cd test/AirLift ; unzip -uq dirGeneralRepos.zip"
echo "Executing program at the generalRepos node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws08.ua.pt 'cd test/AirLift/dirGeneralRepos ; ./generalRepos.sh'
sshpass -p "qwerty" ssh -q sd106@l040101-ws08.ua.pt 'cd test/AirLift/dirGeneralRepos ; cat logger'