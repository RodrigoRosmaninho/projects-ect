#!/bin/bash
# Thanks to Eurico Dias :D

debug=false
dir="/home/rrosmaninho/Repos/bomberman-iia-88802-88753"

terminator -e "cd $dir && source venv/bin/activate && python3 server.py" &
sleep 1

while getopts "d" opt; do
	case "$opt" in 
		d)
			debug=true
	esac
done

cd $dir
source venv/bin/activate

if $debug; then
	python3 viewer.py
else
	terminator -e "cd $dir && source venv/bin/activate && python3 viewer.py" &
	sleep 1

	if [ -f "$dir/student.py" ]; then
		python3 student.py
	else
		python3 client.py
	fi
fi
