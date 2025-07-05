#!/bin/bash

echo sending $1
TOKEN=`cat gotify_token.txt`
curl "https://gotify.rhchoi.com/message?token=$TOKEN" -F "title=N100" -F "message=$1" -F "priority=8"
