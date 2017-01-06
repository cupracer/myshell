#!/bin/bash

if [ $# -eq 1 ]; then
	BASEDIR="$1"
else
	BASEDIR="."
fi

MISSINGFILES=0

if ! [ -r "${BASEDIR}/boot.txt" ]; then
	echo "* missing \"${BASEDIR}/boot.txt\""
	MISSINGFILES=1
fi

if ! [ -r "${BASEDIR}/basic-environment.txt" ]; then
	echo "* missing \"${BASEDIR}/basic-environment.txt\""
	MISSINGFILES=1
fi

if ! [ -r "${BASEDIR}/proc.txt" ]; then
	echo "* missing \"${BASEDIR}/proc.txt\""
	MISSINGFILES=1
fi

if [ $MISSINGFILES -ne 0 ]; then
	echo "aborting"
	exit 1
fi

SCDMESG=$(sed -n "/\#\ \/bin\/dmesg/,\$p" "${BASEDIR}/boot.txt" | sed "1d")
SCDATETIME="$(cat "${BASEDIR}/basic-environment.txt" |grep -A1 /bin/date |grep -v date)"
SCTIMESTAMP=$(date --date="${SCDATETIME}" +"%s")
SCUPTIME=$(grep -A1 "/proc/uptime" "${BASEDIR}/proc.txt" |grep -v uptime |cut -d" " -f1)

#echo "SCDATETIME  = ${SCDATETIME}"
#echo "SCTIMESTAMP = ${SCTIMESTAMP}"
#echo "SCUPTIME    = ${SCUPTIME}"

echo "${SCDMESG}" | perl -ne "BEGIN{\$a= ${SCTIMESTAMP}-${SCUPTIME}}; s/\[\s*(\d+)\.\d+\]/localtime(\$1 + \$a)/e; print \$_;"

