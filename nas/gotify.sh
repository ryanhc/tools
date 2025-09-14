#!/bin/bash

pushd /home/ryanc/bin

MSG="$@"
echo sending "$MSG"
TOKEN=`cat gotify_token.txt`
curl "https://gotify.rhchoi.com/message?token=$TOKEN" -F "title=N100" -F "message=$MSG" -F "priority=8"
