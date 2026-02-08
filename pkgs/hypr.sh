HYPR=(
  ### Window Manager & Core Wayland Support
  hyprland                    # The tiling Wayland compositor
  qt5-wayland                 # Wayland support for Qt5 apps
  qt6-wayland                 # Wayland support for Qt6 apps
  hyprpolkitagent             # Polkit authentication agent for Hyprland
  
  ### Hyprland Ecosystem Daemons
  hyprpaper                   # Wallpaper utility
  hyprlock                    # Screen locker
  hypridle                    # Idle management daemon (sleep/suspend)
  
  ### Desktop Components
  waybar                      # Highly customizable status bar
  swaync                      # Notification center/daemon
  rofi-wayland                # Application launcher and menu
  rofimoji                    # Emoji picker for rofi
  
  ### System Integration & Portals
  xdg-desktop-portal-gtk      # Backend for file pickers and settings
  xdg-desktop-portal-hyprland # Specific portal for screen sharing/picking in Hypr
  dex                         # Tool to run desktop-autostart files
  
  ### File Management
  thunar                      # GTK-based file manager
  thunar-archive-plugin       # Archive integration for Thunar
  xarchiver                   # Lightweight archive manager (frontend)
  
  ### web browser
  firefox

  ### Terminals & Editors
  kitty                       # Fast, GPU-accelerated terminal
  geany                       # Lightweight IDE / Text editor
  geany-plugins               # Extra features for Geany
  
  ### Screen Capture & Graphics
  grim                        # Screenshot utility
  slurp                       # Select a region for screenshots
  imv                         # Image viewer for Wayland
  
  ### Multimedia (Music & Video)
  mpd                         # Music Player Daemon
  mpc                         # Command-line client for MPD
  ncmpcpp                     # Feature-rich ncurses music player
  mpv                         # Powerful command-line video player
  
  ### Appearance & Theming
  qt5ct                       # Qt5 configuration tool
  qt6ct                       # Qt6 configuration tool
  kvantum                     # SVG-based theme engine for Qt
  
  ### Clipboard & Color Tools
  pastel                      # Color picker and converter
  wl-clipboard                # Wayland clipboard utilities
  cliphist                    # Clipboard history manager
  
  ### Audio & Connectivity
  pavucontrol                 # PulseAudio volume control (GUI)
  playerctl                   # Media player controller (Play/Pause/Next)
  network-manager-applet      # System tray icon for NetworkManager
#  blueberry                   # Bluetooth configuration tool
)
FONTS=(
  noto-fonts 
  noto-fonts-emoji 
  terminus-font 
  ttf-jetbrains-mono 
  ttf-jetbrains-mono-nerd 
  ttf-nerd-fonts-symbols 
  ttf-nerd-fonts-symbols-common 
  ttf-nerd-fonts-symbols-mono
)
