#!/bin/bash

GROUP="input"

if [[ -f "$(which bongocat)" ]];then
if id -nG "$USER" | grep -qw "$GROUP"; then
    echo "User $USER is already in $GROUP."
else
    echo "Adding $USER to $GROUP..."
    sudo usermod -a -G "$GROUP" "$USER"
    echo "Done. Please log out and back in to apply changes."
fi


  bongocat --watch-config -c  ~/.config/bongocat/bongocat.conf
else 
  notify-send -t 1000 "BongoCat is not Installed"
fi
