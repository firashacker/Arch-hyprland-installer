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
  echo -e "\e[32msudo ./install.sh -U [YOUR USERNAME] -P [YOUR PASSWORD] -H [YOUR HOSTNAME]\e[0m"

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

if [ -z "${User}" ];then
  echo -e "\e[31mErr:please specify User Name \"\-U username \"\e[0m "
  exit -1
fi

if [ -z "${HostName}" ];then
  echo -e "\e[31mErr:please specify Host Name \"\-H hostname \"\e[0m "
  exit -1
fi

if [ -z "${Password}" ];then
  echo -e "\e[31mErr:please specify User Password \"\-P password \"\e[0m "
  exit -1
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

#### hyprland lockscreen daemon ####
hyprlock 

#### hyprland (sleep/hibernate/suspend) daemon  #####
hypridle 

#### notification daemons ####
swaync 

#### apps and other menues launcher ####
rofi-wayland 
rofimoji
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
imv
#gwenview
#swappy 
#viewnior 
#nsxiv


#### status bar applet for network manager ####
network-manager-applet 


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
##distrobox 
##podman 

#### webbrowser ####
firefox 

#### gaming stuff ####
gamemode 
goverlay 
mangohud 
steam
obs-studio 

#### disk manager ####
gparted 

#### KDE connect ####
#kdeconnect 

#### timeshift ####
timeshift

#### shell popups creator ####
yad 

#### razer stuff ####
openrazer-daemon 
openrazer-driver-dkms 

#### audio mixer ####
##easyeffects 

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
#docker 
#docker-compose 
#docker-desktop 
)



#############
### Fonts ###
#############

FONTS=(
noto-fonts 
noto-fonts-emoji 
terminus-font 
ttf-jetbrains-mono 
ttf-jetbrains-mono-nerd 
ttf-nerd-fonts-symbols 
ttf-nerd-fonts-symbols-common 
ttf-nerd-fonts-symbols-mono 
#ttf-iosevka-nerd 
#ttf-cascadia-mono-nerd 
)


AUR=(
obs-vkcapture-git 
libopenrazer 
mpvpaper 
polychromatic 
#rtl8812au-aircrack-ng-dkms-git 
upd72020x-fw 
wd719x-firmware 
opencl-amd 
waypaper 
obs-vaapi 
)




#### sync TIMEZONE before installation ####

preInstall(){
  hwclock --systohc
  timedatectl set-ntp yes
  sudo pacman -Sy archlinux-keyring
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
  ensureSuccess pacstrap -K ${MOUNTPOINT} base linux linux-headers linux-firmware grub efibootmgr
  genfstab -U ${MOUNTPOINT} > ${MOUNTPOINT}/etc/fstab
  rm -r ${MOUNTPOINT}/etc/localtime
  ensureSuccess ln -sf /usr/share/zoneinfo/${TIMEZONE} ${MOUNTPOINT}/etc/localtime
  echo "FONT=default8x16" > ${MOUNTPOINT}/etc/vconsole.conf
  arch-chroot ${MOUNTPOINT} hwclock --systohc
  echo -e "\e[32mSetting Password for root ! \e[0m"
  #arch-chroot ${MOUNTPOINT} passwd
  arch-chroot ${MOUNTPOINT} bash -c "echo -e \"${Password}\n${Password}\n\"|passwd"
}


#### Available Packages: PACKAGES_BASE DISPLAY_MANAGER HYPR APPS FONTS ####

installApps(){
  echo -e "\e[32mInstalling desktop and apps ! ... \e[0m"
  ensureSuccess pacstrap -K ${MOUNTPOINT} ${PACKAGES_BASE[*]} ${DISPLAY_MANAGER[*]} ${HYPR[*]} ${FONTS[*]} ${APPS[*]}
  ensureSuccess arch-chroot ${MOUNTPOINT} pacman-key --init
  ensureSuccess arch-chroot ${MOUNTPOINT} pacman-key --populate

}



installLocal(){
  echo -e "\e[32mInstalling local packages ! ... \e[0m"
  ensureSuccess pacstrap -KU ${MOUNTPOINT} $(pwd)/localpkgs/*
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
  arch-chroot ${MOUNTPOINT} mkinitcpio -P
  ensureSuccess arch-chroot ${MOUNTPOINT} grub-mkconfig -o /boot/grub/grub.cfg
}


setServices(){
  echo -e "\e[32mSetting systemd services ! ... \e[0m"
  arch-chroot ${MOUNTPOINT} systemctl enable sddm.service
  arch-chroot ${MOUNTPOINT} systemctl enable NetworkManager.service
  arch-chroot ${MOUNTPOINT} systemctl enable bluetooth.service
}

setUser(){
  echo -e "\e[32mAdding your USER ! ... \e[0m"
  arch-chroot ${MOUNTPOINT} useradd -m -G wheel -s /bin/zsh ${User} --home /home/${User}
  #sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL:ALL)\s\+ALL\)/\1/' ${MOUNTPOINT}/etc/sudoers
  mkdir -p ${MOUNTPOINT}/etc/sudoers.d/
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > ${MOUNTPOINT}/etc/sudoers.d/wheel

  echo -e "\e[32mSetting Password for USER:${User} ! \e[0m"
  #arch-chroot ${MOUNTPOINT} "passwd ${User}"
  arch-chroot ${MOUNTPOINT} bash -c "echo -e \"${Password}\n${Password}\n\"|passwd ${User}"
}



installAUR(){
  echo -e "\e[32mInstalling AUR Packages ! \e[0m"
  ensureSuccess arch-chroot ${MOUNTPOINT} sudo -u ${User} yay_install
  arch-chroot ${MOUNTPOINT} sudo -u ${User} yay -S ${AUR[*]} --noconfirm
  if $(checkErr);then
    for PACKAGE in ${AUR[@]};do 
      arch-chroot ${MOUNTPOINT} sudo -u ${User} yay -S ${PACKAGE} --noconfirm
      if $(checkErr);then
        echo -e "\e[31mErr: Package ${PACKAGE} Couldnt be installed ! \e[0m"
        sleep 3
      fi
    done
  fi
  #ensureSuccess arch-chroot ${MOUNTPOINT} yay -S ${AUR[*]} --noconfirm
}

runPostInstall(){
  arch-chroot ${MOUNTPOINT} sudo -u ${User} post_install_script

  echo "%wheel ALL=(ALL:ALL) ALL" > ${MOUNTPOINT}/etc/sudoers.d/wheel
}


##### WARNING ####
# commands sequence is Critical please dont change the arrangment of which first and which secound
# 1-preInstall 2-installAll 3-copyOverlay 4-setLocales 5-setKernelModules 6-setHostName 7-setGrub 8-setServices 9-setUser 10-installAUR 11-runPostInstall

preInstall
installAll
copyOverlay
setLocales
setKernelModules
setHostName
setGrub
setServices
setUser
installAUR
runPostInstall
