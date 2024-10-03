#!/bin/bash
##################################
## your filesystem mount point ###
##################################
MOUNTPOINT="/mnt"

#####################
## Your TimeZone  ###
#####################
TIMEZONE="Asia/Jerusalem"


###############
### LOCALES ###
###############
LOCALES="en_US.UTF-8 UTF-8"


#####################
### Your UserName ###
#####################
#User="firas"

#####################
### Your HostName ###
#####################
#HostName="Arch"

if [[ "$(whoami)" != "root" ]];then
  echo "Please run as root"
  exit
fi

getHelp(){
  echo "#########################################################"
  echo "#########################################################"
  echo "### Welcome to ArchLinux Hyprland Installation Script ###"
  echo "### author: firastom0@gmail.com #########################"
  echo "#########################################################"
  echo "#########################################################"


  echo -e "\e[33mYour Disk must Be Preformated and mounted like so\e[0m"
  echo -e "\e[31mRoot partition with compatible format mounted to /mnt\e[0m"
  echo -e "\e[31mEFI partition with fat32/vfat format mounted to /mnt/boot/efi\e[0m"
  echo -e "\e[32mYou can use gparted to partition and format your disk\e[0m"
  echo -e "\e[32mThen mount it to mentioned location\e[0m"


  echo -e "\nUSAGE:"
  echo -e "\e[32msudo ./install.sh -U [YOUR USERNAME] -H [YOUR HOSTNAME]\e[0m"

  exit 0
}



while getopts ":U:H:T:M:" flag
do
    case "${flag}" in
        U) User=${OPTARG};;
        H) HostName=${OPTARG};;
        M) MOUNTPOINT=${OPTARG};;
        T) TIMEZONE=${OPTARG};;
        *) getHelp;;
    esac
done

if [ -z "${User}" ];then
  echo -e "\e[31mErr:please specify User Name \"\-U username \"\e[0m "
  exit -1
else if [ -z "${HostName}" ];then
  echo -e "\e[31mErr:please specify Host Name \"\-H hostname \"\e[0m "
fi
fi







############################
### BASE system packages ###
############################


PACKAGES_BASE=(
alsa-utils 
bc 
bluez 
bluez-utils 
cifs-utils 
efibootmgr 
exa 
ffmpeg 
ffmpegthumbnailer 
tumbler 
git 
grub 
gvfs 
gvfs-afc 
gvfs-smb 
gst-libav 
gst-plugins-good 
gst-plugins-ugly 
gst-plugins-bad 
gst-plugin-pipewire 
ifuse 
iniparser 
intel-ucode 
jq 
jasper 
kvantum 
kvantum-qt5 
lib32-freetype2 
libde265 
libdv 
libmpd 
libmpeg2 
libwebp 
libavif 
libheif 
lib32-vulkan-radeon 
libtheora 
libvpx 
libva-mesa-driver 
linux-firmware-qlogic 
mesa 
mesa-utils 
mpd 
mtools 
nano 
nano-syntax-highlighting 
netctl 
networkmanager 
neofetch 
ntfs-3g 
nvme-cli 
opencl-amd 
openssh 
os-prober 
packagekit-qt5 
pipewire 
pipewire-alsa 
pipewire-audio 
pipewire-jack 
pipewire-pulse 
plymouth 
polkit-qt5 
pulsemixer 
p7zip 
qt5-graphicaleffects 
ranger 
reflector 
schroedinger 
sndio 
sudo 
ueberzug 
unzip 
usbmuxd 
usb_modeswitch 
usbutils 
vulkan-radeon 
wget 
wireplumber 
wireless_tools 
xdg-utils 
xdg-user-dirs 
xf86-input-libinput 
xf86-video-amdgpu 
x264 
x265 
xvidcore 
yad 
zip 
zsh 
zsh-autosuggestions 
zsh-completions 
zsh-syntax-highlighting 
)


#######################
### Display Manager ###
#######################

DISPLAY_MANAGER=(
sddm 
#gdm 
#lightdm 
#xorg 
xorg-xwayland 
xorg-xhost 
wlroots
)


#########################
### Hyprland Packages ###
#########################

HYPR=(
hyprland 

#### hyprland wallpaper engine ####
hyprpaper 

#### GUI wallpaper setter for wayland ####
waypaper 

#### hyprland lockscreen daemon ####
hyprlock 

#### hyprland (sleep/hibernate/suspend) daemon  #####
hypridle 

#### notification daemons ####
swaync 

#### apps and other menues launcher ####
rofi-wayland 

#### desktop portal important for video capture and so ####
xdg-desktop-portal-gtk 
xdg-desktop-portal-hyprland 

#### auto start applications ####
dex 
#### file manager ####
thunar 
thunar-archive-plugin 

#### archive manager ####
xarchiver 

#### Terminal ####
kitty 

#### text editor ####
geany 
geany-plugins 

#### ScreenShot ####
grim 
slurp 

#### Music Player ####
mpd 

#### video player ####
mpv 

#### Music Player Controll Panel ####
ncmpcpp 
mpc

#### theming apps ####
qt5ct 
qt6ct 
kvantum 

#### clipboard progs
pastel 
wl-clipboard 
cliphist 

#### audio settings ####
pavucontrol 
playerctl 

#### status bar ####
waybar 

#### image viewer ####
#swappy 
#viewnior 
nsxiv

#### bluetooth control panel ####
blueberry 

#### THEME ####
arc-gtk-theme 
)


#################
### User Apps ###
#################

APPS=( 
#### pdf viewer ####
atril

#### amd gpu control panel ####
corectrl 

#### distrobox ####
distrobox 
podman 

#### webbrowser ####
firefox 

#### gaming stuff ####
gamemode 
goverlay 
mangohud 
steam
obs-studio 
obs-vaapi 

#### disk manager ####
gparted 

#### KDE connect ####
#kdeconnect 

#### status bar applet for network manager ####
network-manager-applet 

#### timeshift ####
timeshift

#### shell popups creator ####
yad 

#### razer stuff ####
openrazer-daemon 
openrazer-driver-dkms 

#### audio mixer ####
easyeffects 

#### neovim ####
neovim 
)

###########################
### My Development apps ###
###########################

DEVPACK=(
neovim
zed 
#ollama 
node 
npm 
docker 
docker-compose 
docker-desktop 
)



#############
### Fonts ###
#############

FONTS=(
ttf-iosevka-nerd 
ttf-jetbrains-mono 
ttf-jetbrains-mono-nerd 
ttf-cascadia-mono-nerd 
noto-fonts 
terminus-font 
noto-fonts-emoji 
noto-fonts-cjk 
ttf-nerd-fonts-symbols 
ttf-nerd-fonts-symbols-common 
ttf-nerd-fonts-symbols-mono 
)





#### sync timezone before installation ####

preInstall(){
  hwclock --systohc
  timedatectl set-ntp yes
  #sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
  sleep 2
}


checkErr(){
  if (( $? == 0 ));then
    return 1
  fi 
  return 0
}

ensureSuccess(){
  Command=$@
  declare -i Counter=3
  bash -c "${Command}"

  while  $(checkErr) && (( Counter > 0 ));do
      Counter=( $Counter-1 )
      echo -e "\e[31m Err: Retrying ... \e[0m"
      echo -e "\e[31m ${Command}\e[0m"
      sleep 2
      bash -c "$Command"
  done

  if  $(checkErr) ;then
    echo -e "\e[31mCritical ! \e[0m"
    echo -e "\e[31mErr: Couldn't succeed running the following Command:\e[0m"
    echo -e "\e[33m ${Command}\e[0m"
    exit -2
  fi

}


installLinux(){
  echo -e "\e[32mInstalling Linux Base ! ... \e[0m"
  ensuresuccess pacstrap -k ${MOUNTPOINT} base linux linux-headers linux-firmware grub efibootmgr
  genfstab -u ${MOUNTPOINT} > ${MOUNTPOINT}/etc/fstab
  rm -r ${MOUNTPOINT}/etc/localtime
  ensuresuccess ln -sf /usr/share/zoneinfo/${timezone} ${MOUNTPOINT}/etc/localtime
  arch-chroot ${MOUNTPOINT} hwclock --systohc
  arch-chroot ${MOUNTPOINT} passwd
}

installapps(){
  echo -e "\e[32minstalling desktop and apps ! ... \e[0m"
  ensuresuccess pacstrap -k ${MOUNTPOINT}  ${packages_base}  ${display_manager} ${hypr} ${apps} ${fonts}
  ensuresuccess arch-chroot ${MOUNTPOINT} pacman-key --init
  ensuresuccess arch-chroot ${MOUNTPOINT} pacman-key --populate

}

installlocal(){
  echo -e "\e[32mInstalling local packages ! ... \e[0m"
  ensureSuccess pacstrap -KU ${MOUNTPOINT} $(pwd)/packages/*
}

installAll(){
  installLinux
  installApps
  installLocal
}

copyOverlay(){
  echo -e "\e[32mCopying configs over ! ... \e[0m"
  cp -r overlay/* ${MOUNTPOINT}
}

setLocales(){
  echo -e "\e[32mConfiguring locales ! ... \e[0m"
  sed -i "s/#\(en_US\.UTF-8\)/\1/" ${MOUNTPOINT}/etc/locale.gen
  arch-chroot ${MOUNTPOINT} locale-gen
}

setKernelModules(){
  echo -e "\e[32mAdding kernel modules ! ... \e[0m"
  Modules=(amdgpu radeon)
  sed -i "s/MODULES=()/MODULES=(${Modules})/g" /mnt/etc/mkinitcpio.conf
  sed -i "s/ udev/ udev plymouth/g" /mnt/etc/mkinitcpio.conf
  sed -i "s/plymouth plymouth/plymouth/g" /mnt/etc/mkinitcpio.conf  
}

setHostName(){
  echo -e "\e[32mSetting Host Name ! ... \e[0m"
  echo ${HostName} > ${MOUNTPOINT}/etc/hostname
}

setGrub(){
  echo -e "\e[32mSetting grub boot loader ! ... \e[0m"
  ensureSuccess arch-chroot ${MOUNTPOINT} grub-install
  ensureSuccess arch-chroot ${MOUNTPOINT} mkinitcpio -P
  ensureSuccess arch-chroot ${MOUNTPOINT} grub-mkconfig -o /boot/grub/grub.cfg

  echo -e "\e[32mSetting systemd services ! ... \e[0m"
  arch-chroot ${MOUNTPOINT} systemctl enable sddm.service
  arch-chroot ${MOUNTPOINT} systemctl enable NetworkManager.service
  arch-chroot ${MOUNTPOINT} systemctl enable bluetooth.service
}

setUser(){
  echo -e "\e[32mAdding your USER ! ... \e[0m"
  arch-chroot ${MOUNTPOINT} useradd -m -G wheel -s /bin/zsh ${User} --home /home/${User}
  sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL:ALL)\s\+ALL\)/\1/' ${MOUNTPOINT}/etc/sudoers
  arch-chroot ${MOUNTPOINT} passwd ${User}
}

runPostInstall(){
  arch-chroot ${MOUNTPOINT} sudo -u ${User} post_install_script
}


# preInstall installAll copyOverlay setLocales setKernelModules setHostName setGrub setUser runPostInstall

preInstall
installAll
copyOverlay
setLocales
setKernelModules
setHostName
setGrub
setUser
runPostInstall
