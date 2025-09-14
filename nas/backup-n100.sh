#!/bin/bash
# Automatically run by crontab -e
set -e

pushd /home/ryanc/bin
crontab -l > crontab-backup.txt

echo "Backup remote servers"
#ssh ubuntu-200 /home/ryanc/docker/bookstack/bookstack-backup-script.sh

sudo rsync -av --progress --delete --rsync-path="sudo rsync" ubuntu-200: /tank-8t/backup/ubuntu-200/
sudo rsync -avz --progress --delete --rsync-path="sudo rsync" cello: /tank-8t/backup/cello/

echo "Backup tank-8t/root"
sudo rsync -av --progress --delete --delete-excluded /tank-8t/root /tank-8t-b/backup/tank-8t/
sudo rsync -av --progress --delete --delete-excluded /tank-8t/backup /tank-8t-b/backup/tank-8t/
sudo rsync -av --progress --delete --delete-excluded --filter="merge /home/ryanc/bin/rsync-exclude.txt" /home /tank-8t-b/backup/n100/

sudo zfs snapshot -r tank-8t/root@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-8t/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-8t-b/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r rpool/USERDATA/home_420369@$(date +%Y%m%d_%H%M%S)_auto_daily
#zfs list -t snapshot
sudo /home/ryanc/bin/zfs-prune-snapshots/zfs-prune-snapshots -s '_auto_daily' 1M

/home/ryanc/bin/backup-to-3t.sh

exit 0
