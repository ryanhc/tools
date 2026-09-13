#!/bin/bash

mkdir -p /var/run/sendmail/mta
mkdir -p /var/run/sendmail/msp
mkdir -p /var/run/sendmail/stampdir/cron-msp
chown -R smmsp:smmsp /var/run/sendmail
chmod -R 777 /var/run/sendmail
