#!/bin/bash

# 1. Assign variable immediately
EFIPART=$1

if [[ -z $EFIPART ]]; then
  echo "Please Specify EFI Partition to mount Like [/dev/sda1]."
  exit 1
fi

# Simplified device check
if [[ ! $EFIPART =~ "/dev/" ]]; then
  echo "Error: Device must be in /dev/ (e.g., /dev/sda1)."
  exit 1
fi

if findmnt -M "/mnt/boot/efi" >/dev/null; then
  echo "Error: /mnt/boot/efi is already mounted and busy."
  exit 1
fi

echo "Mounting volumes..."
# Create directories first to ensure mount points exist
mkdir -p /mnt/boot/efi
sudo mount "${EFIPART}" /mnt/boot/efi

