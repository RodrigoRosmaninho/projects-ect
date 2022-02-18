listofsites=$(awk -F "\"*,\"*" '{print $2}' top500Domains.csv)

while :
do
	for item in [$listofsites]
	do
		nslookup $item
		rand=$(bc -l <<< "$RANDOM/32768*3")
		sleep $rand
	done
	echo "1" | sudo -S /etc/init.d/dns-clean restart
done
