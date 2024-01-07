#!/bin/bash

#Update key and system
pacman-key --init
pacman-key --populate archlinux
pacman -Sy archlinux-keyring --needed --noconfirm

# Install Openbox
pacman -S openbox obconf nitrogen lxappearance --noconfirm

# Install panel and dock, file manager, and terminal
pacman -S tint2 pcmanfm nvim qterminal git gcc libsvgtiny netsurf nmap weechat keepassxc menumaker wget htop mc --noconfirm

# Install X SERVER
pacman -S --needed xorg-server xorg-xinit --noconfirm

# Install volume controller
# pacman -S volumeicon

# Install WiFi manager
# pacman -S network-manager-applet --noconfirm

# Install some popular Openbox themes
pacman -S gtk-engine-murrine numix-themes-archblue --noconfirm

# Copy Openbox configuration files
cp -r /etc/xdg/openbox ~/.config/

# Create Openbox autostart file
touch ~/.config/openbox/autostart
chmod +x ~/.config/openbox/autostart

# Set wallpaper
mkdir /usr/share/wapl
wget https://gitlab.com/garuda-linux/themes-and-settings/artwork/garuda-wallpapers/-/raw/master/src/garuda-wallpapers/Circuit.png -O /usr/share/wapl/Circuit.png
nitrogen --set-auto /usr/share/wapl/Circuit.png

# Add panel, dock, wallpaper manager, volume controller, and WiFi manager to Openbox autostart file
echo "tint2 &" >> ~/.config/openbox/autostart
#echo "plank &" >> ~/.config/openbox/autostart
echo "nitrogen --restore &" >> ~/.config/openbox/autostart
#echo "volumeicon &" >> ~/.config/openbox/autostart
#echo "nm-applet &" >> ~/.config/openbox/autostart

# Set Openbox as default window manager
echo "exec openbox-session" > ~/.xinitrc

# Apply a theme
obconf --set --theme /usr/share/themes/Numix-archblue/openbox-3/themerc
pacman -S lightdm lightdm-gtk-greeter --noconfirm
sed -i 's/^greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf
systemctl enable lightdm.service

#Gen OpenBox menu
mmaker -vf OpenBox3

reboot now