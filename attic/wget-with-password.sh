#!/bin/bash

# This method can be used to hide a password (and username)
# during downloads. Without that, "ps", "top" and others 
# might show the used credentials in plain text.
# 
# (see --ask-password in newer wget versions)
#
# The urlencode function was taken from:
# https://newfivefour.com/unix-urlencode-urldecode-command-line-bash.html

urlencode() {
    # urlencode <string>

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 |
                   while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}

#####

read -p "URL: " URL
read -p "User: " MYUSER
read -p "Password: " -s MYPASS

MYENCUSER=$(urlencode "${MYUSER}")
MYENCPASS=$(urlencode "$MYPASS")
FULLURL=$(echo ${URL} | sed -e "s#://#://${MYENCUSER}:${MYENCPASS}@#")

# example for testing purposes!
WGETOPTS="--no-directories --recursive"

echo "${FULLURL}" | wget ${WGETOPTS} -i -

