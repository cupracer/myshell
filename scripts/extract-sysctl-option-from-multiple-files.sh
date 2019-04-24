#!/bin/bash

# filter for Excel: =UND(IDENTISCH(B65;C65);IDENTISCH(B65;D65))

for i in $(find . -name env.txt); do 
	OUTFILE="$(echo $i | cut -d"/" -f2|cut -d"_" -f3).txt"
	cat $i | sed $(($(grep -n "# /sbin/sysctl -a" $i | cut -d":" -f1)+1))','$(($(grep -n "# /usr/bin/getconf -a" $i | cut -d":" -f1)-3))'!d' > $OUTFILE
done

LONGEST_FILE=$(wc -l *.txt|sort -nr|grep -v total|head -n1|awk '{print $2}')

printf "option"
for file in $(ls -1 *.txt); do
	printf ";$(echo ${file} | sed -e 's/.txt$//')"
done
printf "\n"

for option in $(cat $LONGEST_FILE | awk '{print $1}' | uniq); do
	echo $option | egrep ^net >> /dev/null || continue
	printf "${option}"
	for file in $(ls -1 *.txt); do
		printf ";$(grep "$option =" $file | cut -d"=" -f2- )"
	done
	printf "\n"
done

