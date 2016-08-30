#!/bin/bash

if [ $# -ne 2 ]; then
	echo "usage: $0 /path/to/image.qcow2 <size>"
	exit 1
fi

[[ -x $(which qemu-img) ]] || { echo "missing qemu-img in path"; exit 1; }
[[ -d $(dirname $1) ]] || { echo "missing target directory"; exit 1; }

qemu-img create -f qcow2 -o preallocation=metadata ${1} ${2}G

