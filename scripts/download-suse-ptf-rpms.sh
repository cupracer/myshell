#!/bin/bash

INSTALL=0

usage() { 
	printf "\nUsage: $0 -a <username> -u <url> [-i]\n\n" 1>&2
	printf "Options:\n"
	printf "\t-a\tusername for HTTP authentication\n";
	printf "\t-u\tURL to PTF web directory\n";
	printf "\t-i\trun zypper install afterwards\n"
	exit 1;
}

while getopts ":a:u:i" opt; do
	case $opt in
		a)
			ACCOUNT="$OPTARG"
			;;
		u)
			URL="$OPTARG"
			;;
		i)
			INSTALL=1
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
		:)
			echo "Option -$OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done

if [ -z "${ACCOUNT}" ] || [ -z "${URL}" ]; then
    usage
fi

##################################################

wget --help | grep "ask-password" > /dev/null
[[ $? -eq 0 ]] || { echo "Parameter --ask-password is not supported on this platform"; exit 1; }

wget --user=${ACCOUNT} \
	--ask-password \
	--no-directories \
	--recursive \
	--accept '*.rpm' \
	--no-parent \
	${URL}

if [ "${INSTALL}" == "1" ]; then
        zypper install ./*.rpm
fi

