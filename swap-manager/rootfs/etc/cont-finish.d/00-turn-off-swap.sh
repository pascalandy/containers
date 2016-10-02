#!/usr/bin/with-contenv bash

swapoff /swapfile

swapon --show

free -h
