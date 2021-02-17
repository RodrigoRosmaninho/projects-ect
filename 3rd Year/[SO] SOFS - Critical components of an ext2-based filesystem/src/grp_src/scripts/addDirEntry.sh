#!/bin/bash
# USAGE: ./addDirEntry.sh DISK_PATH LOWER_BOUND UPPER_BOUND
# If bounds are not specified, script assumes 0 and 31

lower=$2
upper=$3

if [ -z "$2" ] || [ -z "$3" ]
then
    echo "No argument supplied, assuming 0 - 31 dirEntries"
    lower=0
    upper=31
fi

if [ -z "$1" ]
  then
    echo "No disk path supplied, cannot proceed"
    exit 1
fi

for n in $(seq $lower $upper); do
  echo -e "ade\n0\na$n\n1\n0" | ../../../bin/testtool -r 202-202 -q1 $1 -p0-0
done
