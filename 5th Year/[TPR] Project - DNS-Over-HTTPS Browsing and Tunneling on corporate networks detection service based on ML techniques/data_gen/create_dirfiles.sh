dir="randir"
nfiles=500
nf=$(( $nfiles-1 ))
maxbytes=1024
mkdir $dir

for i in `seq 0 1 $nf`
do
	fname=$(cat -n /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1 | tr -d '\n')
	rand=$(bc -l <<< $RANDOM/32768*$maxbytes )
	cnt=${rand%.*}
	
	dd if=/dev/urandom bs=1 count=$cnt of="$dir/$fname"
done
	
