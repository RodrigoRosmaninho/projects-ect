#!/bin/bash
# USAGE: ./freeDataBlocks.sh DISK_PATH FIRST_BLOCK LAST_BLOCK
# If either of FIRST_BLOCK or LAST_BLOCK is unspecified, script assumes 5-175 (1000 block disk)

f_block=$2
l_block=$3

if [ -z "$2" ] || [ -z "$3" ]
then
    echo "No argument supplied, assuming 5 - 175 Blocks"
    f_block=5
    l_block=175
fi

if [ -z "$1" ]
then
    echo "No disk path supplied, cannot proceed"
    exit 1
fi

for ((block=f_block;block<l_block;block++))
do
	echo -e "fdb\n$block\n" | ../../../bin/testtool -q1 $1
done
