#!/bin/bash

if [ $# -ne 1 ]; then
	echo "usage: $0 chroot-mountpoint"
	exit 1
fi

BASEDIR=$(echo ${1} | sed -e 's#\/*$##')

function doBindMount() {
	[[ -d ${2}${1} ]] && { mount -o bind ${1} ${2}${1}; } || { echo "missing ${2}${1}"; exit 1; }
	echo "mounted ${1} on ${2}${1}"
}

doBindMount /dev $BASEDIR
doBindMount /proc $BASEDIR
doBindMount /sys $BASEDIR

