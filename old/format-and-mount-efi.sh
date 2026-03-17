#!/bin/bash

# 1. Assign variable immediately
EFIPART=$1

if [[ -z $EFIPART ]]; then
  echo "Please Specify EFI Partition to format and mount Like [/dev/sda1]."
  exit 1
fi

# Simplified device check
if [[ ! $EFIPART =~ "/dev/" ]]; then
  echo "Error: Device must be in /dev/ (e.g., /dev/sda1)."
  exit 1
fi

# 2. Confirmation (EFIPART is now populated)
echo "Are you sure you want to continue wiping ${EFIPART}? [y/N]"
read -r answer
if [[ ! "${answer,,}" =~ ^(y|yes)$ ]]; then
    echo "Operation aborted by user."
    exit 1
fi

if findmnt -M "/mnt/boot/efi" >/dev/null; then
  echo "Error: /mnt/boot/efi is already mounted and busy."
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

echo "Wiping filesystem signatures from ${EFIPART}..."
sudo wipefs -a "${EFIPART}"
quitOnError $? "Failed to wipe signatures."


echo "Formatting disk ${EFIPART}..."
sudo mkfs.vfat -F 32 -n "BOOT_PART" ${EFIPART}
quitOnError $? "Failed to format disk."

sleep 2



echo "Mounting volumes..."
# Create directories first to ensure mount points exist
mkdir -p /mnt/boot/efi
sudo mount "${EFIPART}" /mnt/boot/efi

