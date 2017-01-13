# autobackups
Rsync routine that backs up local directories to a "cloud" via ssh. Source: http://www.howtogeek.com/175008/the-non-beginners-guide-to-syncing-data-with-rsync/. Automate with a cron job.

Getting started
---------------

Assuming necessary setup (DDNS for your network, port forwarding on your router, etc.) is complete:

1. Install rsync (http://rsync.samba.org) on both client and server
2. Configure ssh. Suggested measures:
  - Generate public/private RSA key pair with ssh-keygen on client
  - Select no password (otherwise you'll be prompted on every backup attempt)
  - copy ~/.ssh/id_rsa.pub on client to ~/.ssh/ on server
  - For security, edit /etc/ssh/ssh_config on client to allow only authorized keys
  - add public id_rsa.pub key to ~/.ssh/authorized_keys on server
3. Edit a few fields in the main script, sync.sh
  - USER is your login username on the server
  - PROJPATH is the directory where this sync.sh script lives
  - ORIGPATH is the parent directory you want backed up (the "origin")
  - DESTPATH is the destination directory on the server to which you want your ORIGPATH backed up
  - ensure ./etc/ip.txt contains the public-facing ip address of your home network, under which your server lives
  - ensure ./etc/port.txt contains the port number you configured your router to be listening on
