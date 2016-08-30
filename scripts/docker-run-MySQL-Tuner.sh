#!/bin/bash

if [ $# -ne 3 ]; then
	echo "usage: $0 <container> <name> <docker-network>"
	exit 1
fi

if [ -z "${MYSHELL}" ]; then
	echo "Variable \$MYSHELL is unset"
	exit 1
fi

DBCONTAINER=$1
CONTAINERNAME=$2
CONTAINERNET=$3
MAXMEM=32768

docker run --rm -it --net=${CONTAINERNET} --link ${DBCONTAINER} -v ${MYSHELL}/vendor/MySQLTuner-perl:/MySQLTuner-perl mysql:latest \
	/MySQLTuner-perl/mysqltuner.pl --forcemem ${MAXMEM} --host ${CONTAINERNAME}

