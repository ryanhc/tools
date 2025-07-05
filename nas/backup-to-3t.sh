#!/bin/bash
set -e

echo "Backup tank-8t/root"
rsync -av --progress --delete --delete-excluded --filter="merge /home/ryanc/bin/rsync-exclude-3t.txt" /tank-8t/root/ /tank-3t/backup/n100/
rsync -av --progress --delete --delete-excluded /tank-8t/root/video /tank-3t-b/backup/n100/

sudo zfs snapshot -r tank-3t/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-3t-b/backup@$(date +%Y%m%d_%H%M%S)_auto_daily

zfs list -t snapshot
sudo /home/ryanc/bin/zfs-prune-snapshots/zfs-prune-snapshots -s '_auto_daily' 1M tank-3t tank-3t-b

exit 0
