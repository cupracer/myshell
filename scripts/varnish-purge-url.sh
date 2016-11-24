#!/bin/bash

VARNISHIP="127.0.0.1"
VARNISHPORT="80"

if [ $# -eq 1 ]; then
	URL="$1"
elif [ $# -eq 3 ]; then
	VARNISHIP="$1"
	VARNISHPORT="$2"
	URL="$3"
else
        echo "usage: $(basename $0) [varnish-ip varnish-port] target-url"
        exit 1
fi

DOMAIN=$(echo $URL | awk -F/ '{print $3}')

curl -k --resolve $DOMAIN:$VARNISHPORT:$VARNISHIP -s -w "%{http_code}\\t%{url_effective}\\n" -X PURGE "$URL" -o /dev/null

