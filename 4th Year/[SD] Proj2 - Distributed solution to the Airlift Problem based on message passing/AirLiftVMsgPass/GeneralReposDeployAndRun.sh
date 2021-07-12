echo "Transfering data to the generalRepos node."
sshpass -p "qwerty" scp -r genclass.jar generalRepos.zip sd106@l040101-ws08.ua.pt:/home/sd106
echo "Decompressing data sent to the generalRepos node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws08.ua.pt "unzip -qo generalRepos.zip"
echo "Executing program at the generalRepos node."
sshpass -p "qwerty" ssh -q sd106@l040101-ws08.ua.pt 'java -classpath "genclass.jar:." serverSide.main.GeneralReposMain'
sshpass -p "qwerty" ssh -q sd106@l040101-ws08.ua.pt 'cat logger'