listofsites=$(awk -F "\"*,\"*" '{print $2}' top500Domains.csv)

while :
do
	for item in [$listofsites]
	do
		nslookup $item
	done
done
