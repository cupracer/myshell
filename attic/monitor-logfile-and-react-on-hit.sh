#!/bin/bash

LOGFILE=/some/dir/some.log
WAIT_FOR_HITS=3
SEARCH_TERM="test 123"

################

if ! [ -r ${LOGFILE} ]; then
	echo "couldn't read ${LOGFILE}"
	exit 1
fi

COUNTER=0

while [ ${COUNTER} -lt ${WAIT_FOR_HITS} ];
do
	( tail -f -n0 ${LOGFILE} & ) | grep -q "${SEARCH_TERM}"
	let COUNTER=${COUNTER}+1
	echo "HIT ${COUNTER} - $(date +'%Y-%m-%d %H:%M:%S')"
done

################

echo "COUNTER REACHED"
cat ${LOGFILE}

