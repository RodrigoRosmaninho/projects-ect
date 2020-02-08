#!/bin/bash
# USAGE: ./allocAllInodes.sh DISK_PATH NUMBER_OF_INODES
# If no NUMBER_OF_INODES is specified, script assumes 63 Inodes (1000 block disk)

num_of_inodes=$2

if [ -z "$2" ]
  then
    echo "No argument supplied, assuming 63 Inodes"
    num_of_inodes=63
fi

if [ -z "$1" ]
  then
    echo "No disk path supplied, cannot proceed"
    exit 1
fi

for ((i=1; i<=num_of_inodes; i++));
do
  echo -e "ai\n1\n777" | ../../../bin/testtool -q1 $1
done