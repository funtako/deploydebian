#!/bin/bash

#TODO get terminal wifi connection thing network-manager? wifi firmware might vary by wificard?
#ALSO ON THINKPAD LAPTOPS YOU WANT tp-smapi-dkms for extra battery related rules
#alsa-utils? I'm not sure tho this is sound might need the pulseaudio instead
#do i need ufw firewall?
#different script for neomutt
#BRAVE all the extensions i use for it and privacy settings 
#terminal webbrower when you find the one you prefer and have vim keybindings
#virtualbox?
#doom emacs?

#update and install all updates
sudo apt update
sudo apt upgrade -y

sucklessloc=$HOME/suckless

#create a directory for music this will be the directory for mpd and ncmpcpp
mkdir $HOME/music

# install some important programs
sudo apt-get install -y vim xinit git build-essential wget curl

# install dependencies for suckless dwm
sudo apt-get install -y libx11-dev libxft-dev libxinerama-dev


#installing suckless software
#################
#clone my fork of dwm
git clone https://github.com/funtako/dwm.git $sucklessloc/dwm/
cd $sucklessloc/dwm/
make
sudo make install 

#clone my fork of st
git clone https://github.com/funtako/st.git $sucklessloc/st/
cd $sucklessloc/st/
make
sudo make install 

#clone my fork of slstatus 
git clone https://github.com/funtako/slstatus.git $sucklessloc/slstatus/
cd $sucklessloc/slstatus/
make
sudo make install 
###############

#########################
#getting my dot files and .config files from github 
cd $HOME
git clone https://github.com/funtako/dot-files.git $HOME
#give all the scripts in that folder ability to execute them by changing the permissions
sudo chmod +x $HOME/scripts/* 
#give them all the owner as root
sudo chown root:root $HOME/scripts/*
#copy all the scripts to /usr/local/bin
sudo cp $HOME/scripts/* /usr/local/bin
############################################

#install gui file manager
sudo apt install pcmanfm -y 
#install redshift this is similar flux makes light go more red as the sun sets and day gets darker
sudo apt install redshift -y
#install htop task manager
sudo apt install htop -y
#install smratmontools for checking health of hard disk
sudo apt install smartmontools -y

##################
#installing brave browser instrutions from https://brave.com/linux/
#brave browser is my primary web browser
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y
#############################################

#my secondary webbrowser firefox
sudo apt install firefox-esr -y

#install nitrogen wallpaper utility
sudo apt install nitrogen -y

#install libreoffice
sudo apt install libreoffice -y

#install compton compositor for making terminal have shadows, transparency just makes it look better
sudo apt install compton -y

#neofetch just shows your system specs 
sudo apt install neofetch -y

#ffmpeg needed for lots of media players and also ffmpeg and ffprobe is needed for my music metadata script
sudo apt install ffmpeg -y

#mpv terminal media player
sudo apt install mpv -y

#foremost lets you recover some deleted files from a drive
sudo apt install foremost -y

#calibre ebook manager and format conversion (bloated)
sudo apt install calibre -y

#TODO: might need also to get python3 and also might need to create a symlink from the folder python to python3?
#python3-pip python package installer
sudo apt install python3-pip -y

#unzip .zip files
sudo apt install unzip -y

#figlet just lets you make cool looking big text in terminal
sudo apt install figlet -y

#the gui versoin of vim, used for getting the copy and paste to clipboard function working
sudo apt install vim-gtk -y

#gui disk partition program
sudo apt install gparted -y

#gui picture editing program
sudo apt install gimp -y

#sxiv terminal picture view
sudo apt install sxiv -y

#cmatrix just makes terminal look like matrix movie
#TODO: make this my sreensaver if I don't touch the screen for some time
sudo apt install cmatrix -y

#sxhkd simple X hotkey daemon - lets me create keybinds to do anything 
sudo apt install sxhkd -y

#screenkey when you turn it on all key presses will appear on the screen large sized good for making video tutorials
sudo apt install screenkey -y

#aptitude used in my scripts pkgs1.sh and upgrades1.sh lets me see how many packages i have installed from apt
sudo apt install aptitude -y

#maim terminal screenshots printscreen
sudo apt install maim -y

######################
#all this is needed for music
#mpd - music player daemon
sudo apt install mpd -y

#ncmpcpp - An ncurses Music Player Daemon (MPD) client
sudo apt install ncmpcpp -y

#playerctl allows you to change song through terminal
sudo apt install playerctl -y

#mpdris2 needed to get playerctl working with mpd
sudo apt install mpdris2 -y 
#####################

####################
#needed for desktop notifications
sudo apt instlal libnotify-bin -y
sudo apt install dunst -y
####################

