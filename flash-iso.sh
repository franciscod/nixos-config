#!/usr/bin/env bash
set -e

if [ "$(id -u)" != "0" ]; then
    echo you should be root
    exit 1
fi

ISO=$(ls result/iso/nixos*.iso)

if [ ! -e "$ISO" ]; then
    echo "the iso doesn't exist. hint: make iso"
    exit 1
fi

echo found iso: $ISO
echo ok, plug a flash drive
SD=$(head -n 1 \
        <(dmesg -W | \
          grep --line-buffered 'sd.*Attached.*removable') \
        | awk -F'[][]' '{print $4}')

echo found drive: $SD, running lsblk
lsblk

echo
echo will write to "$SD" in 5 seconds...
sleep 1
echo will write to "$SD" in 4 seconds...
sleep 1
echo will write to "$SD" in 3 seconds...
sleep 1
echo will write to "$SD" in 2 seconds...
sleep 1
echo will write to "$SD" in 1 second...
sleep 3
echo jk it was...           3 seconds
sleep 1
echo flashing now!

ddrescue -D --force "$ISO" "/dev/$SD"
