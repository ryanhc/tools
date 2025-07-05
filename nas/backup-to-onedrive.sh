#!/bin/bash
# Need to run as ryanc
set -e

# restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic ls latest

# backup
restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic --verbose backup \
--exclude-file=/home/ryanc/bin/restic-excludes.txt --files-from=/home/ryanc/bin/restic-includes.txt

# list snapshots
#restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic snapshots

# keep the last n snapshots
restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic forget --keep-last 14 --prune
# restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic forget idhere

# prune
restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic prune

# restore
# restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic restore latest --target ./tmp --include /home/ryanc/bin

# mount
# restic --password-command 'gpg -d -f ~/.ssh/private.gpg /home/ryanc/bin/restic_pwd.asc' -r rclone:onedrive-encrypt:restic umount ./tmp

exit 0
