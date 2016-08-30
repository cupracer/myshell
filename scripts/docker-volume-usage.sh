#!/bin/bash

UNUSEDONLY=0
UNUSEDVIDONLY=0

function checkUtils() {
        ISERR=0

        which docker > /dev/null 2>&1
        if [ $? -ne 0 ]; then
                printf "No \"docker\" binary found in path.\n"
                ISERR=1
        fi

        which jq > /dev/null 2>&1
        if [ $? -ne 0 ]; then
                printf "No \"jq\" binary found in path.\n"
                ISERR=1
        fi

        if [ $ISERR -ne 0 ]; then
                printf "Exiting.\n"
                exit 1
        fi
}

function usage() {
        printf "Usage: $0 [ -u | -q | -h ]\n\n"
        printf "Options:\n\n"
        printf "%-10s %s\n" "  -u" "Print unused volumes only"
        printf "%-10s %s\n" "  -q" "Print unused volume ID's only"
        printf "\n"
}


function parseContainers() {
        V=$1
        VID=$2

        declare -a CONTAINERIDS
        declare -a CONTAINERNAMES

        for C in $(docker ps -aq); do
                CRAW=$(docker inspect ${C})
                echo $CRAW | grep -q ${VID}

                if [ $? -eq 0 ]; then
                        CNAME=$(echo ${CRAW} | jq -r '.[0].Name')
                        CONTAINERIDS+=("${C}")
                        CONTAINERNAMES+=("${CNAME}")
                fi
        done

        if [ ${#CONTAINERIDS[@]} -gt 0 ]; then
                if [ $UNUSEDONLY -ne 1 ]; then
                        for C in "${!CONTAINERIDS[@]}"; do
                                printf "%-65s %-13s %s\n" ${V} "${CONTAINERIDS[$C]}" "${CONTAINERNAMES[$C]}"
                        done
                fi
        else
                if [ $UNUSEDVIDONLY -ne 1 ]; then
                        printf "%-65s %-13s %s\n" ${V} "-" "(unused)"
                else
                        printf "${V}\n"
                fi
        fi
}

checkUtils

while getopts ":quh" opt; do
        case $opt in
                u)
                        UNUSEDONLY=1
                        ;;
                q)
                        UNUSEDONLY=1
                        UNUSEDVIDONLY=1
                        ;;
                h)
                        usage
                        exit 0
                        ;;
                \?)
                        echo "Invalid option: -$OPTARG" >&2
                        usage
                        exit 1
                        ;;
        esac
done


if [ $UNUSEDVIDONLY -ne 1 ]; then
        printf "%-65s %-13s %s\n" "VOLUME" "CONTAINER ID" "CONTAINER NAME"
fi

VOLUMES=$(docker volume ls -q | sort)

for V in ${VOLUMES}; do
        VRAW=$(docker volume inspect ${V})
        VID=$(echo ${VRAW} | jq -r '.[0].Name')
        parseContainers ${V} ${VID}
done
