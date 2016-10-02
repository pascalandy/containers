#!/usr/bin/with-contenv bash

if [ "$SWAPSIZE" == "" ]; then
    SWAPSIZE=1
fi

fallocate -l ${SWAPSIZE}G /swapfile
chmod 600 /swapfile
mkswap /swapfile

swapon /swapfile
swapon --show

free -h
