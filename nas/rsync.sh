#!/bin/sh
rsync -avR --delete --progress $1 $2
