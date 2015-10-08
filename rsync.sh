#!/bin/sh
rsync -zavrR --delete --progress $1 $2
