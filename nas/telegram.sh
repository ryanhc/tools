#!/bin/bash

# crontab -e
# @reboot sleep 10 && /home/ryanc/bin/telegram.sh "System rebooted"

TELEGRAM_TOKEN=`cat telegram_token.txt`
CHAT_ID=`cat telegram_chatid.txt`

# first argument
MESSAGE=$1

curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" -d chat_id="$CHAT_ID" -d text="$MESSAGE"

