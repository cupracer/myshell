#!/bin/bash

if [ $# -ne 1 ]; then
	echo "parameter missing."
	exit 1
fi

RPM=$1

[[ -f ${RPM} ]] || { echo "invalid file"; exit 1; }
[[ -x $(which rpm2cpio) ]] || { echo "rpm2cpio missing."; exit 1; }
[[ -x $(which cpio) ]] || { echo "cpio missing."; exit 1; }

RPMNAME=$(echo ${RPM} | sed -e 's#\.rpm$##')

echo "* creating output dir ${RPMNAME}"
mkdir ${RPMNAME}
cd ${RPMNAME}

echo "* extracting RPM ${RPM}"
rpm2cpio ../${RPM} | cpio -idmv
cd -

