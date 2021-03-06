#!/bin/bash

clear

rclone config

# disable the encrypted services to prevent a clash
systemctl disable rclone-en
systemctl disable move-en
systemctl stop rclone-en
systemctl stop move-en

# stop current services
systemctl stop unionfs
systemctl stop rclone
systemctl stop move

# ensure that the unencrypted services are on
systemctl enable rclone
systemctl enable move

# turn services back on
systemctl start unionfs
systemctl start rclone
systemctl start move

####################################################### REPEAT 2 WORK
# disable the encrypted services to prevent a clash
systemctl disable rclone-en
systemctl disable move-en
systemctl stop rclone-en
systemctl stop move-en

# stop current services
systemctl stop unionfs
systemctl stop rclone
systemctl stop move

# copy rclone config from sudo user to root, which is the target
cp ~/.config/rclone/rclone.conf /root/.config/rclone/

# ensure that the unencrypted services are on
systemctl enable rclone
systemctl enable move

# turn services back on
systemctl start unionfs
systemctl stop rclone
systemctl start rclone
systemctl start move

# set variable to remember what version of rclone user installed
mkdir /var /var/plexguide /var/plexguide/rclone 1>/dev/null 2>&1
touch /var/plexguide/rclone/un 1>/dev/null 2>&1
rm -r /var/plexguide/rclone/en

clear
cat << EOF
NOTE: You installed the unencrypted version for the RClone data transport!
If you messed anything up, select [2] and run through again.  Also check:
http://unrclone.plexguide.com and or post on http://reddit.plexguide.com

HOW TO CHECK: In order to check if everything is working, have 1 item at least
in your google Drive

1. Type: /mnt/gdrive (and then you should see some item from your g-drive there)
2. Type: /mnt/unionfs (and you should see the same g-drive stuff there)

Verifying that 1 and 2 are important due to this is how your data will sync!

To make it easy, you can also use the CHECKING TOOLS built in!

EOF
bash /opt/plexguide/scripts/docker-no/continue.sh
