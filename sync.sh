#!/bin/bash

# Automate incremental timestamped backups to Raspberry Pi cloud server at home

# Username
USER="jon_michelson"

# This is your sync.sh project's path
PROJPATH="/Users/jon_michelson/Projects/autobackups"

# Set your origin and destination paths:
ORIGPATH="/Users/jon_michelson"
DESTPATH="/backupdrive/jon"

# Home network's public IP address
HOMEIP=$(cat $PROJPATH/etc/ip.txt)

# port options
PORT=$(cat $PROJPATH/etc/port.txt)

# Save old timestamp
yes | cp $PROJPATH/etc/time.txt $PROJPATH/etc/time2.txt

# Write new timestamp
echo $(date "+%F") > $PROJPATH/etc/time.txt

# Log file blank creation
echo "" > $PROJPATH/logs/rsync-$(date "+%F").log

# Rsync command
env -i sh -c "rsync -avzhPR --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r --delete --log-file=$PROJPATH/logs/rsync-$(date "+%F").log --exclude-from ''$PROJPATH'/etc/exclude.txt' --link-dest=$DESTPATH/$(cat $PROJPATH/etc/time2.txt) -e 'ssh -p '"$PORT"'' $ORIGPATH/ $USER@$HOMEIP:$DESTPATH/$(date "+%F")/"

# Copy log to Rpi
scp -P $PORT $PROJPATH/logs/rsync-$(cat $PROJPATH/etc/time.txt).log $USER@$HOMEIP:$DESTPATH/logs/rsync-$(cat $PROJPATH/etc/time.txt).log
