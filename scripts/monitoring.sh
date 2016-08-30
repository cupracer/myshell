#!/bin/bash

export PATH=/usr/lib/nagios/plugins:$PATH

IS_WARNING=0
IS_CRITICAL=0

# checks

LOAD=$(check_load -w 12,12,12 -c 15,15,15)
[[ $LOAD =~ ^OK ]] || { [[ $LOAD =~ ^WARN ]] && { IS_WARNING=1; } || { IS_CRITICAL=1; } }

SWAP=$(check_swap -w 30% -c 20%)
[[ $SWAP =~ ^SWAP\ OK ]] || { [[ $SWAP =~ ^SWAP\ WARN ]] && { IS_WARNING=1; } || { IS_CRITICAL=1; } }

#BIND=$(check_bind -s /var/lib/named/var/log)
#[[ $BIND =~ ^Bind9\ is\ running ]] && { BIND="OK - $BIND"; } || { IS_CRITICAL=1; }

DISK_ROOT=$(check_disk -w 20% -c 10% /)
[[ $DISK_ROOT =~ ^DISK\ OK ]] || { [[ $DISK_ROOT =~ ^DISK\ WARN ]] && { IS_WARNING=1; } || { IS_CRITICAL=1; } }

DISK_BOOT=$(check_disk -w 20% -c 10% /boot)
[[ $DISK_BOOT =~ ^DISK\ OK ]] || { [[ $DISK_BOOT =~ ^DISK\ WARN ]] && { IS_WARNING=1; } || { IS_CRITICAL=1; } }

DISK_OPT=$(check_disk -w 20% -c 10% /opt)
[[ $DISK_OPT =~ ^DISK\ OK ]] || { [[ $DISK_OPT =~ ^DISK\ WARN ]] && { IS_WARNING=1; } || { IS_CRITICAL=1; } }

DISK_DOCKER=$(check_disk -w 10% -c 5% /var/lib/docker)
[[ $DISK_DOCKER =~ ^DISK\ OK ]] || { [[ $DISK_DOCKER =~ ^DISK\ WARN ]] && { IS_WARNING=1; } || { IS_CRITICAL=1; } }

#SMART_SDA=$(check_smart -i auto -d /dev/sda)
#[[ $SMART_SDA =~ ^OK ]] || { IS_CRITICAL=1; }

#SMART_SDB=$(check_smart -i auto -d /dev/sdb)
#[[ $SMART_SDB =~ ^OK ]] || { IS_CRITICAL=1; }

MAILQ=$(check_mailq -w 5 -c 10)
[[ $MAILQ =~ ^OK ]] || { [[ $MAILQ =~ ^WARN ]] && { IS_WARNING=1; } || { IS_CRITICAL=1; } }


# resulting actions

if [ $IS_WARNING -eq 0 ] && [ $IS_CRITICAL -eq 0 ]; then
	exit 0
else
	if [ $IS_CRITICAL -eq 1 ]; then
		MAIL_SUBJECT="CRITICAL errors detected on $(hostname -f)"
	else
		MAIL_SUBJECT="WARNING(s) detected on $(hostname -f)"
	fi

	mail -s "$MAIL_SUBJECT" root <<EOF
Detailed results:

$LOAD
$SWAP
$DISK_ROOT
$DISK_BOOT
$DISK_OPT
$DISK_DOCKER
$MAILQ
EOF
fi

