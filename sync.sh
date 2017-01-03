#!/bin/bash

# Automate regular backups to Raspberry Pi cloud server at home

# Local autobackup project dir path
PROJPATH="/Users/jon_michelson/Projects/autobackups"

# Declare origin and destination paths
ORIGPATH="/Users/jon_michelson"
DESTPATH="/backupdrive/jon"

# Pi's static IP address
PI_IP="192.168.1.105"

# Save old timestamp
yes | cp ./time.txt ./time2.txt

# Write new timestamp
echo $(date "+%F") > ./time.txt

# Log file blank creation
echo "" > ./rsync-$(date "+%F").log

# Rsync command
rsync -avhPR --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r --delete --log-file=$PROJPATH/rsync-$(date "+%F").log --exclude-from 'exclude.txt' --link-dest=$DESTPATH/$(cat $PROJPATH/time2.txt) -e ssh $ORIGPATH/ jon_michelson@$PI_IP:$DESTPATH/$(date "+%F")/

# Sync log
scp $PROJPATH/rsync-$(cat $PROJPATH/time.txt).log jon_michelson@$PI_IP:$DESTPATH/logs/rsyng-$(cat $PROJPATH/time.txt).log
