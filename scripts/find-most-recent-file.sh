#!/bin/bash

if [ $# -lt 1 ]; then
	echo "parameter missing."
	exit 1
fi

DIR="$1"
MAXDEPTH="-maxdepth 1"

if [ "$2" == "-r" ]; then
	MAXDEPTH=""
fi

find $DIR $MAXDEPTH -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f 2- | tail -n 1

