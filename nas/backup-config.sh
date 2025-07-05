#!/bin/bash

DEST=/home/ryanc/bin/config/

cp /etc/samba/smb.conf $DEST
sudo cp /etc/netplan/00-installer-config.yaml $DEST
sudo cp /etc/netplan/99-networkd.yaml $DEST
cp /etc/default/hd-idle $DEST
cp /etc/apcupsd/apcupsd.conf $DEST
sudo cp /etc/wireguard/wg0.conf $DEST
