#!/bin/bash

pushd /home/ryanc/bin

MSG="$@"
echo sending "$MSG"

BOT_NAME="N100"
TOKEN=`cat mattermost_token.txt`
WEBHOOK_URL="https://mm.rhchoi.com/hooks/$TOKEN"

curl -X POST -H "Content-Type: application/json" \
     -d "{\"username\": \"$BOT_NAME\", \"icon_emoji\": \":robot_face:\", \"text\": \"$MSG\"}" \
     $WEBHOOK_URL

exit 0

