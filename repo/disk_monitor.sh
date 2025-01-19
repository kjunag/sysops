#!/bin/bash

log_file="/var/log/disks/Report_$(date +"%Y%m%d_%H%M%S")"
disks=( $(lsblk -o KNAME,TYPE | grep disk | awk -F ' ' '{print $1}') )

declare -A partitions

for disk in "${disks[@]}"
do 
  parts=( $(lsblk -o KNAME,TYPE | grep "$disk.*part" | awk -F ' ' '{print $1}') )
  for part in "${parts[@]}"
  do 
    partitions[$part]=$disk
  done
done
> $log_file
echo "Detected disks and partitions" >> $log_file
echo "If free space not provided - partition not mountede!" >> $log_file
for disk in "${disks[@]}"
do 
  echo "Disk: $disk" >> $log_file
  for part in "${!partitions[@]}"
  do 
    if [ "$disk" = "${partitions[$part]}" ]
    then
      free_space=$(lsblk -o KNAME,FSAVAIL | grep "$part" | awk -F ' ' '{print $2}')
      echo " - $part | free space: $free_space" >> $log_file
    fi
  done
done
echo "Raport został zapisany w lokalizacji: $log_file"
