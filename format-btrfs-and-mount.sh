#!/bin/bash

# 1. Assign variable immediately
ROOTPART=$1

if [[ -z $ROOTPART ]]; then
  echo "Please Specify Root Partition to format and mount Like [/dev/sda2]."
  exit 1
fi

# Simplified device check
if [[ ! $ROOTPART =~ "/dev/" ]]; then
  echo "Error: Device must be in /dev/ (e.g., /dev/sda2)."
  exit 1
fi

# 2. Confirmation (ROOTPART is now populated)
echo "Are you sure you want to continue wiping ${ROOTPART}? [y/N]"
read -r answer
if [[ ! "${answer,,}" =~ ^(y|yes)$ ]]; then
    echo "Operation aborted by user."
    exit 1
fi

# 3. Prerequisites check
if ! command -v btrfs &> /dev/null; then
  echo "Please install btrfs-progs."
  exit 1
fi

if findmnt -M "/mnt" >/dev/null; then
  echo "Error: /mnt is already mounted and busy."
  exit 1
fi

# 4. Error Handler Function
# Usage: command; quitOnError $? "Optional Error Message"
quitOnError(){
  if [ "$1" -ne 0 ]; then
    echo "Error: ${2:-Previous command failed.}"
    exit 1
  fi
}

echo "Wiping filesystem signatures from ${ROOTPART}..."
sudo wipefs -a "${ROOTPART}"
quitOnError $? "Failed to wipe signatures."


echo "Formatting disk ${ROOTPART}..."
sudo mkfs.btrfs -f -L "Arch" "${ROOTPART}"
quitOnError $? "Failed to format disk."

sleep 2

echo "Creating subvolumes..."
sudo mount "${ROOTPART}" /mnt/
quitOnError $? "Failed to mount root for subvolume creation."

# Use subshell or full paths to avoid 'cd' issues
sudo btrfs subvolume create /mnt/@
sudo btrfs subvolume create /mnt/@home
sudo btrfs subvolume create /mnt/@cache
sudo btrfs subvolume create /mnt/@log
sudo btrfs subvolume create /mnt/@tmp

echo "Unmounting root to remount subvolumes..."
sudo umount /mnt

echo "Mounting volumes..."
# Create directories first to ensure mount points exist
sudo mount -t btrfs -o subvol=@,compress=zstd "${ROOTPART}" /mnt
sudo mkdir -p /mnt/{home,tmp,var/cache,var/log}

sudo mount -t btrfs -o subvol=@home,compress=zstd  "${ROOTPART}" /mnt/home
sudo mount -t btrfs -o subvol=@tmp,compress=zstd   "${ROOTPART}" /mnt/tmp
sudo mount -t btrfs -o subvol=@cache,compress=zstd "${ROOTPART}" /mnt/var/cache
sudo mount -t btrfs -o subvol=@log,compress=zstd   "${ROOTPART}" /mnt/var/log

echo "ALL btrfs volumes mounted successfully to /mnt"

