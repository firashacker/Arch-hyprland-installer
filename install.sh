#!/bin/zsh
TARGET="/mnt"
ZONE="Asia/Jerusalem"
LOCALES="en_US.UTF-8 UTF-8"
User="firas"
#HostName="Recovery"
HostName="Arch"

integer FROM=${1}



PACKAGES_BASE=(
alsa-utils 
bc 
bluez 
bluez-utils 
#btrfs-progs 
cifs-utils 
efibootmgr 
exa 
ffmpeg 
ffmpegthumbnailer 
tumbler 
git 
grub 
#grub-theme-vimix 
#gstreamer 
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
mpc 
mtools 
nano 
nano-syntax-highlighting 
#ncmpcpp 
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
#python-i3ipc 
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
xdg-utils 
xdg-user-dirs 
xf86-input-libinput 
xf86-video-amdgpu 
x264 
x265 
xvidcore 
wireplumber 
wireless_tools 
yad 
zip 
zsh 
zsh-autosuggestions 
zsh-completions 
zsh-syntax-highlighting 
)

DISPLAY_MANAGER=(
sddm 
#gdm 
#lightdm 
#xorg 
xorg-xwayland 
xorg-xhost 
wlroots
)


HYPR=(
hyprland 
hyprpaper 
waypaper 
hyprlock 
hypridle 
swaync 
rofi-wayland 
xdg-desktop-portal-gtk 
xdg-desktop-portal-hyprland 
dex 
thunar 
kitty 
geany 
geany-plugins 
grim 
slurp 
mpd 
mpv 
ncmpcpp 
qt5ct 
qt6ct 
kvantum 
pastel 
pavucontrol 
playerctl 
waybar 
swappy 
#viewnior 
wl-clipboard 
cliphist 
blueberry 
)

SWAY=(
alacritty 
fcft 
foot 
geany 
geany-plugins 
gobject-introspection 
grim 
libdisplay-info 
libsixel 
libutf8proc 
libxpresent 
luajit 
mako 
mpd 
mpv 
mujs 
ncmpcpp 
network-manager-applet 
qt5ct 
qt6ct 
rofi 
slurp 
sndio 
spdlog 
sway 
swaybg 
swaylock 
swayidle 
thunar 
uchardet 
upower 
pastel 
pavucontrol 
playerctl 
python-i3ipc 
python-mako 
python-markdown 
python-pywal 
viewnior 
waybar 
wf-recorder 
wofi 
wl-clipboard 
wlogout 
wlroots 
wofi 
xdg-desktop-portal-wlr 
#xfce-polkit 
xorg-xwayland 
)

BSPWM=(
alacritty 
bspwm 
dex 
dunst 
geany 
geany-plugins 
i3lock 
ksuperkey 
maim 
mpd 
mpc 
ncmpcpp 
nitrogen 
pastel 
pavucontrol  
picom 
polybar 
qt5ct 
qt6ct 
rofi 
rxvt-unicode 
sxhkd 
thunar 
viewnior 
xfce4-clipman-plugin 
#xfce-polkit 
xfce4-power-manager 
xorg-xsetroot 
xsettingsd 
)

APPS=( 
#alacritty 
atril 
blueberry 
corectrl 
distrobox 
firefox 
gamemode 
goverlay 
gparted 
#kdeconnect 
#meld 
mangohud 
mpv 
network-manager-applet 
obs-studio 
obs-vaapi 
podman 
steam 
thunar 
thunar-archive-plugin 
timeshift 
#viewnior 
xarchiver 
#xed 
#xfce4-terminal 
yad 
openrazer-daemon 
openrazer-driver-dkms 
easyeffects 
#vim 
neovim 
#############
### THEMES ##
#############
arc-gtk-theme 
)

DEVPACK=(
zed 
ollama 
node 
npm 
docker 
docker-compose 
docker-desktop 
)


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

GNOME=(
gdm 
adwaita-cursors 
adwaita-icon-theme 
gjs 
gnome-autoar 
gnome-backgrounds 
gnome-bluetooth 
gnome-browser-connector 
gnome-characters 
gnome-color-manager 
gnome-connections 
gnome-console 
gnome-control-center 
gnome-desktop 
gnome-desktop-4 
gnome-desktop-common 
gnome-keyring 
gnome-session 
gnome-settings-daemon 
gnome-shell 
gnome-shell-extensions 
gnome-software 
gnome-tweaks 
gthumb 
gtksourceview3 
gtksourceview4 
gvfs 
gvfs-afc 
gvfs-smb 
libadwaita 
libgnomekbd 
libsoup 
libsoup3 
mutter 
xdg-desktop-portal-gnome 
xdg-user-dirs-gtk 
)

KDE=(
sddm 
sddm-kcm 
plasma-desktop 
packagekit-qt5 
krunner 
kde-gtk-config 
spectacle 
kinit 
kwrite 
kvantum 
ark 
dolphin 
konsole 
bluedevil 
xsettingsd 
gwenview 
okular 
)

integer COUNTER=0
run(){
echo "${1} :: ${COUNTER}"
if (( ${COUNTER} >= ${FROM} ));then
zsh -c "${1}"
if (( $? != 0 ));then
echo "Error: ${1}"
echo ${COUNTER}
exit
fi
fi
COUNTER=${COUNTER}+1
}

#  ${PACKAGES_BASE}  ${DISPLAY_MANAGER}  ${SWAY} ${BSPWM} ${APPS} ${FONTS} ${KDE} ${GNOME} ${HYPR}
hwclock --systohc
timedatectl set-ntp yes
#sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sleep 2




run "pacstrap -K ${TARGET} base linux linux-headers linux-firmware grub efibootmgr"
run "genfstab -U ${TARGET} > ${TARGET}/etc/fstab"
run "ln -s /usr/share/zoneinfo/${ZONE} ${TARGET}/etc/localtime"
run "arch-chroot ${TARGET} hwclock --systohc"
run "arch-chroot ${TARGET} passwd"
run "pacstrap -K ${TARGET}  ${PACKAGES_BASE}  ${DISPLAY_MANAGER} ${HYPR} ${APPS} ${FONTS}"
run "arch-chroot ${TARGET} pacman-key --init"
run "arch-chroot ${TARGET} pacman-key --populate"
#for i in $(pwd)/packages/*;do
#run "pacstrap -KU ${TARGET} $i"
#done
run "pacstrap -KU ${TARGET} $(pwd)/packages/*"
run "cp -r overlay/* ${TARGET}"
sed -i "s/#\(en_US\.UTF-8\)/\1/" ${TARGET}/etc/locale.gen
sed -i "s/MODULES=()/MODULES=(amdgpu radeon)/g" /mnt/etc/mkinitcpio.conf
sed -i "s/ udev/ udev plymouth/g" /mnt/etc/mkinitcpio.conf
run "arch-chroot ${TARGET} locale-gen"
run "echo ${HostName} > ${TARGET}/etc/hostname"
run "arch-chroot ${TARGET} grub-install"
run "arch-chroot ${TARGET} mkinitcpio -P"
run "arch-chroot ${TARGET} grub-mkconfig -o /boot/grub/grub.cfg"
run "arch-chroot ${TARGET} systemctl enable sddm.service"
run "arch-chroot ${TARGET} systemctl enable NetworkManager.service"
run "arch-chroot ${TARGET} systemctl enable bluetooth.service"
run "arch-chroot ${TARGET} useradd -m -G wheel -s /bin/zsh ${User} --home /home/${User}"
sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL:ALL)\s\+ALL\)/\1/' ${TARGET}/etc/sudoers
run "arch-chroot ${TARGET} passwd ${User}"
run "arch-chroot ${TARGET} sudo -u ${User} post_install_script"
