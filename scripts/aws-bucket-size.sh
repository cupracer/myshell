#!/bin/bash

if [ $# -ne 1 ]; then
	echo "usage: $0 <bucket>"
	exit 1
fi

aws s3api list-objects --bucket "$1" --output json --query "[sum(Contents[].Size), length(Contents[])]"

