#!/bin/bash

if [ $# -ne 1 ]; then
	echo "missing parameter"
	exit 1
fi

ZONEFILE=$1

[[ -f ${ZONEFILE} ]] || { echo "$ZONEFILE does not exist."; exit 1; }

echo "* updating $ZONEFILE"
sed -i 's/[0-9]\{10\}.*serial$/'`date +%Y%m%d%H`' ; serial/g' $ZONEFILE

