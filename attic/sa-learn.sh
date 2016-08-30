#!/bin/bash

chmod 770 /var/spool/amavis/.spamassassin/
chmod 660 /var/spool/amavis/.spamassassin/*

DOMAIN="example.com"
USERNAME="dummy"

su vmail --shell=/bin/bash -c "/usr/bin/sa-learn --dbpath /var/spool/amavis/.spamassassin/ --progress --spam /var/vmail/maildir/${DOMAIN}/${USERNAME}/Maildir/.Junk.Learn"

