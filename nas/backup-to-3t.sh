#!/bin/bash
set -e

echo "Backup tank-8a/root"
sudo rsync -avP --delete --delete-excluded --filter="merge /home/ryanc/bin/rsync-exclude-3t.txt" /tank-8a/root/ /tank-3a/root
sudo rsync -avP --delete --delete-excluded /tank-8a/root/video /tank-3b/root

sudo zfs snapshot -r tank-3a/backup@$(date +%Y%m%d_%H%M%S)_auto_daily
sudo zfs snapshot -r tank-3b/backup@$(date +%Y%m%d_%H%M%S)_auto_daily

zfs list -t snapshot
sudo /home/ryanc/bin/zfs-prune-snapshots/zfs-prune-snapshots -s '_auto_daily' 2M tank-3a tank-3b

exit 0
