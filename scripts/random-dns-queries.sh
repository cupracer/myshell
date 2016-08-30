#!/bin/bash

CNT=1

while true; do
	DOMAIN="$(date "+%N" | md5sum -t | cut -d" " -f1).de"
	echo "Domain: $DOMAIN - Counter: $CNT"
	dig @127.0.0.1 $DOMAIN > /dev/null
	let CNT=$CNT+1
done

