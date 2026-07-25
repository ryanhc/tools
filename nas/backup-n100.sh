#!/bin/bash
# Automatically run by crontab -e
set -e

pushd /home/ryanc/bin
crontab -l > crontab-backup.txt

echo "Backup remote servers"
#ssh ubuntu-200 /home/ryanc/docker/bookstack/bookstack-backup-script.sh
sudo rsync -avP --delete --rsync-path="sudo rsync" ubuntu-200: /tank-14a/backup/ubuntu-200/
sudo rsync -avzP --delete --rsync-path="sudo rsync" cello: /tank-14a/backup/cello/
sudo rsync -avP --delete --delete-excluded --filter="merge /home/ryanc/bin/rsync-exclude.txt" /home /tank-14a/backup/n100/

echo "Backup tank-14a/root"
sudo rsync -avP --delete --delete-excluded /tank-14a/ /tank-14b

sudo zfs snapshot -r tank-14a/root@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-14a/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-14b/root@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-14b/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r rpool/USERDATA/home_420369@$(date +%Y%m%d_%H%M%S)_auto_daily

DOW=$(date +"%a")
if [[ "$DOW" == "Fri" ]]; then
sudo rsync -avP --delete --delete-excluded /tank-14b/ /tank-8a
sudo rsync -avP --delete --delete-excluded /tank-8a/ /tank-8b
sudo zfs snapshot -r tank-8a/root@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-8a/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-8b/root@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-8b/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
#/home/ryanc/bin/gotify.sh "Back up successful: tank-8a and tank-8b"
/home/ryanc/bin/mattermost.sh "Back up successful: tank-8a and tank-8b"
fi

#zfs list -t snapshot
sudo /home/ryanc/bin/zfs-prune-snapshots/zfs-prune-snapshots -s '_auto_daily' 2M

#/home/ryanc/bin/backup-to-3t.sh

#/home/ryanc/bin/gotify.sh "Back up successful"
/home/ryanc/bin/mattermost.sh "Back up successful"

exit 0
