#!/bin/bash
# USAGE: ./fillDataBlocks.sh DISK_PATH NUMBER_OF_BLOCKS
# If no NUMBER_OF_BLOCKS is specified, script assumes TAIL_CACHE_SIZE (170)

num_of_blocks=$2

if [ -z "$2" ]
then
    echo "No argument supplied, assuming TAIL_CACHE_SIZE (170 Blocks)"
    num_of_blocks=63
fi

if [ -z "$1" ]
then
    echo "No disk path supplied, cannot proceed"
    exit 1
fi

for ((i=1; i<=num_of_blocks; i++));
do
	echo -e "adb" | ../../../bin/testtool -q1 $1
done
