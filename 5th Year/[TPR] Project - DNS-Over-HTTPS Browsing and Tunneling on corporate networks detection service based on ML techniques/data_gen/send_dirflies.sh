dirname="randir"
nfiles=$(ls -l randir | egrep -c '^-')
nf=$(( 2*$nfiles  ))
filelist="$dirname"/*
flist=($filelist)
username="eurico"
send_ip="10.99.0.1"
max_sleept=11

for i in `seq 0 1 $nf`
do
	rand=$( bc -l <<< $RANDOM/32768*$nfiles )
	randsleept=$( bc -l <<< $RANDOM/32768*$max_sleept )
        index=${rand%.*}
	fname=${flist[$index]}
	echo "Sending $fname"
	sshpass -p 'salvador' scp -o StrictHostKeyChecking=no $fname $username@$send_ip:~/
	sleep $randsleept
done
