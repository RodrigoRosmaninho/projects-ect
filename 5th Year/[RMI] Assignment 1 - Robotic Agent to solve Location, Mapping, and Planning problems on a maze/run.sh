#!/bin/bash

challenge="1"
host="localhost"
robname="theAgent"
pos="0"
outfile="mapping.out"

while getopts "c:h:r:p:f:" op
do
    case $op in
        "c")
            challenge=$OPTARG
            ;;
        "h")
            host=$OPTARG
            ;;
        "r")
            robname=$OPTARG
            ;;
        "p")
            pos=$OPTARG
            ;;
        "f")
            outfile=$OPTARG
            ;;
        default)
            echo "ERROR in parameters"
            ;;
    esac
done

shift $(($OPTIND-1))

case $challenge in
    1)
        # how to call agent for challenge 1
        python3 mainRob1.py -h "$host" -p "$pos" -r "$robname"
        ;;
    2)
        # how to call agent for challenge 2
        python3 mainRob2.py -h "$host" -p "$pos" -r "$robname" -f "$outfile" # assuming -f is the option for the map
        ;;
    3)
        # how to call agent for challenge 3
        python3 mainRob3.py -h "$host" -p "$pos" -r "$robname" -f "$outfile" # assuming -f is the option for the path
        ;;
esac

