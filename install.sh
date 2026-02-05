#!/bin/bash
##################################
## your filesystem mount point ###
##################################
MOUNTPOINT="/mnt"

#####################
## Your TIMEZONE  ###
#####################
TIMEZONE="Asia/Jerusalem"

###############
### LOCALES ###
###############
LOCALES="en_US.UTF-8 UTF-8"

if [[ "$(whoami)" != "root" ]];then
  echo "Please run as root"
  exit
fi

getHelp(){
  echo "#########################################################"
  echo "### Welcome to ArchLinux Hyprland Installation Script ###"
  echo "#########################################################"
  echo -e "\e[33mYour Disk must Be Preformated and mounted like so\e[0m"
  echo -e "\e[31mRoot partition mounted to ${MOUNTPOINT}\e[0m"
  echo -e "\e[31mEFI partition mounted to ${MOUNTPOINT}/boot/efi\e[0m"
  echo -e "\nUSAGE:"
  echo -e "\e[32msudo ./install.sh -U [USERNAME] -P [PASSWORD] -H [HOSTNAME]\e[0m"
  exit 0
}

while getopts ":U:H:T:M:P:" flag
do
    case "${flag}" in
        U) User=${OPTARG};;
        H) HostName=${OPTARG};;
        M) MOUNTPOINT=${OPTARG};;
        T) TIMEZONE=${OPTARG};;
        P) Password=${OPTARG};;
        *) getHelp;;
    esac
done

if [ -z "${User}" ] || [ -z "${HostName}" ] || [ -z "${Password}" ]; then
  getHelp
fi

source  ./pkgs/dm.sh
source  ./pkgs/hypr.sh
source ./pkgs/apps.sh
source ./pkgs/aur.sh

preInstall(){
  echo -e "\e[32mPre-install syncing... \e[0m"
  timedatectl set-ntp yes
  pacman -Sy --noconfirm archlinux-keyring
  sleep 2
}

checkErr(){
  if (( $? == 0 ));then return 1; fi
  return 0
}

ensureSuccess(){
  Command=$@
  declare -i Counter=3
  until bash -c "${Command}" || [ $Counter -eq 0 ]; do
    ((Counter--))
    echo -e "\e[31m Retrying ($Counter left): ${Command}\e[0m"
    sleep 2
  done
  if $(checkErr); then echo -e "\e[31mCritical failure: ${Command}\e[0m"; exit -2; fi
}

installLinux(){
  echo -e "\e[32mInstalling Linux Base ! ... \e[0m"
  ensureSuccess pacstrap -K ${MOUNTPOINT} base linux linux-headers linux-firmware grub efibootmgr
  genfstab -U ${MOUNTPOINT} >> ${MOUNTPOINT}/etc/fstab
  rm -r ${MOUNTPOINT}/etc/localtime
  arch-chroot ${MOUNTPOINT} ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
  echo "FONT=default8x16" > ${MOUNTPOINT}/etc/vconsole.conf
  arch-chroot ${MOUNTPOINT} hwclock --systohc
  echo -e "\e[32mSetting Root Password... \e[0m"
  echo "root:${Password}" | arch-chroot ${MOUNTPOINT} chpasswd
}

installApps(){
  echo -e "\e[32mInstalling desktop and apps ! ... \e[0m"
  ensureSuccess pacstrap -K ${MOUNTPOINT} ${PACKAGES_BASE[*]} ${DISPLAY_MANAGER[*]} ${HYPR[*]} ${FONTS[*]} ${APPS[*]}
  ensureSuccess arch-chroot ${MOUNTPOINT} pacman-key --init
  ensureSuccess arch-chroot ${MOUNTPOINT} pacman-key --populate}

}

copyOverlay(){
  if [ -d "overlay" ]; then
    echo -e "\e[32mCopying configs over ! ... \e[0m"
    cp -r overlay/* ${MOUNTPOINT}/
  fi
}

setLocales(){
  echo -e "\e[32mConfiguring locales ! ... \e[0m"
  sed -i "s/#\(en_US\.UTF-8\)/\1/" ${MOUNTPOINT}/etc/locale.gen
  arch-chroot ${MOUNTPOINT} locale-gen
  echo "LANG=en_US.UTF-8" > ${MOUNTPOINT}/etc/locale.conf
}

setKernelModules(){
  echo -e "\e[32mAdding kernel modules ! ... \e[0m"
  # Set AMD modules for Early KMS
  Modules=(amdgpu radeon)
  sed -i "s/MODULES=()/MODULES=(${Modules})/" ${MOUNTPOINT}/etc/mkinitcpio.conf
  # Add Plymouth hook
  sed -i "s/ udev/ udev plymouth/g"  ${MOUNTPOINT}/etc/mkinitcpio.conf
  sed -i "s/plymouth plymouth/plymouth/g"  ${MOUNTPOINT}/etc/mkinitcpio.conf
  arch-chroot ${MOUNTPOINT} mkinitcpio -P
}

setHostName(){
  echo "${HostName}" > ${MOUNTPOINT}/etc/hostname
}

setGrub(){
  echo -e "\e[32mSetting grub boot loader ! ... \e[0m"
  # Adjusted for EFI - ensure /boot/efi is mounted before running script
  arch-chroot ${MOUNTPOINT} grub-install # --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
  arch-chroot ${MOUNTPOINT} grub-mkconfig -o /boot/grub/grub.cfg
}

setServices(){
  arch-chroot ${MOUNTPOINT} systemctl enable sddm NetworkManager bluetooth
}

setUser(){
  echo -e "\e[32mAdding User: ${User} ... \e[0m"
  arch-chroot ${MOUNTPOINT} useradd -m -G wheel -s /bin/zsh ${User}
  echo "${User}:${Password}" | arch-chroot ${MOUNTPOINT} chpasswd
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > ${MOUNTPOINT}/etc/sudoers.d/wheel
}

installAUR(){
  echo -e "\e[32mInstalling AUR Packages ! \e[0m"
  # This assumes yay is installed via localpkgs or overlay
  for PACKAGE in ${AUR[@]}; do
    arch-chroot ${MOUNTPOINT} sudo -u ${User} yay -S ${PACKAGE} --noconfirm || echo "Failed to install ${PACKAGE}"
  done
}

runPostInstall(){
  # Restrict sudo access after Installation
  arch-chroot ${MOUNTPOINT} sudo -u ${User} post_install_script
  echo "%wheel ALL=(ALL:ALL) ALL" > ${MOUNTPOINT}/etc/sudoers.d/wheel
  echo -e "\e[32mInstallation Complete. Please unmount and reboot.\e[0m"
  
}

# --- Execution ---
preInstall
installLinux
installApps
copyOverlay
setLocales
setKernelModules
setHostName
setGrub
setServices
setUser
installAUR
runPostInstall
