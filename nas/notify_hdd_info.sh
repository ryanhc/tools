#!/bin/bash

# Send messages on every Sat
# This script is called by cron
pushd /home/ryanc/bin

#/home/ryanc/bin/gotify.sh `/home/ryanc/bin/hdd_info.sh | grep -e "SMART overall-health" | sort | uniq`
/home/ryanc/bin/mattermost.sh `/home/ryanc/bin/hdd_info.sh | grep -e "SMART overall-health" | sort | uniq`
