#!/bin/bash

PROG=$1
printf "check\t${PROG}\n"

for lib in $(ldd $PROG | awk '{ print $3;}' | egrep ^\/); do
	[[ -f $lib ]] && { printf "ok\t"; } || { printf "miss\t"; }
	printf "$lib\n"
done

