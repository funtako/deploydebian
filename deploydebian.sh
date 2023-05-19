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
#GET A FILE THAT WILL JUST LOG THE OUTPUT OF THE SCRIPT


#update and install all updates
sudo apt update
sudo apt upgrade -y

sucklessloc=$HOME/suckless
dotfilesloc=$HOME/funtako/dot-files

#make some sudo commands not need password like shutdown reboot and others
echo "$USER ALL = NOPASSWD:/sbin/reboot, /sbin/shutdown" | sudo tee -a /etc/sudoers

#create directory for screenshots folder that will be used with maim and my scripts and sxhkd
mkdir -p $HOME/pictures/screenshots
#directory for wallpapers
mkdir -p $HOME/pictures/wallpapers

#maim terminal screenshots printscreen
sudo apt install maim -y

#create a directory for music this will be the directory for mpd and ncmpcpp
mkdir $HOME/music

#alsa-utils and pulse audio for sound
sudo apt install alsa-utils pulseaudio -y

# install some important programs
sudo apt-get install -y neovim xinit git build-essential wget curl


#p7zip-full aka 7za for unzipping 7z and loads of other types of files like zip files
sudo apt install p7zip-full

#install rsync - allows me to copy hidden .files properly 
sudo apt install rsync -y

# install dependencies for suckless dwm
sudo apt-get install -y libx11-dev libxft-dev libxinerama-dev

#dependency for slock
sudo apt install libxrandr-dev -y


#FONTS################
#make directory for fonts
mkdir $HOME/.fonts
cd $HOME/.fonts
#put the nerdfonts in the ~/.fonts directory
#download ubuntu nerd fonts # link from https://www.nerdfonts.com/font-downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Ubuntu.zip
#unzip the Ubuntu.zip file
7za e Ubuntu.zip
#remove the zip file now
rm Ubuntu.zip
#refresh font cache so progrmas that use fontconfig can show available fonts on the system - forcefully and -verbose
sudo fc-cache -f -v
###############################

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

#clone dmenu
git clone https://git.suckless.org/dmenu $sucklessloc/dmenu/
cd $sucklessloc/dmenu
make
sudo make install
###############

#########################
#getting my dot files and .config files from github 
################################shopt -s dotglob #allows you to move .files with the mv * command
cd $HOME
#clone my dot files to the home directory it will be in ~/dot-files
git clone https://github.com/funtako/dot-files.git $dotfilesloc
#give all the scripts in that folder ability to execute them by changing the permissions
sudo chmod +x $dotfilesloc/scripts/* 
#give the scripts the owner as root
sudo chown root:root $dotfilesloc/scripts/*
#copy all the scripts to /usr/local/bin
sudo cp $dotfilesloc/scripts/* /usr/local/bin

#move all the files from my dot-files git repository and put them in my home directory
#using rsync because cp wasn't letting me move hidden . files
echo "rsync -a  $dotfilesloc/dot-files/ $HOME/"
rsync -a  $dotfilesloc/ $HOME/
#now we can delete the folder and all files where the dot-files repository was downloaded to
rm -rf $dotfilesloc
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
sudo apt install apt-transport-https curl -y
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
#notify-send for creating custom notifications libnotify-bin
sudo apt instlal libnotify-bin -y
sudo apt install dunst -y
#allows notify-send to be used from crontab
sudo apt install dbus-x11
####################




#terminal pdf reader
sudo apt install zathura -y

#gui torrent client qbittorrent
sudo apt install qbittorrent -y


#fuzzy FuZzy finder - lets you quickly search to find a file
sudo apt install fzf -y


#go needed to install lf file manager
sudo apt install golang -y

#lf its like ranger but faster terminal based file manager to update it though you might need to 
#update manually by getting it again from github
#just make sure we are in home directory for this
cd $HOME
#because we are using go version <1.17 we are doing this 
#by the time your run this script it might be using  later version of go
# For go version < 1.17
env CGO_ENABLED=0 GO111MODULE=on go get -u -ldflags="-s -w" github.com/gokcehan/lf

figlet check version of GO this might need to be changed and check github page for lf
#https://github.com/gokcehan/lf

#now move lf from the folder in home to /usr/bin
sudo cp $HOME/go/bin/lf /usr/bin

#zsh shell has more features than bash shell
sudo apt install zsh -y

#get the fast-syntax-highlighting plugin and put it in that folder, this is at the bottom of ~/.zshrc
#means that incorrect commands will be red and correct will be green
sudo git clone https://github.com/zdharma-continuum/fast-syntax-highlighting /usr/share/zsh/plugins/fast-syntax-highlighting/

#change default shell to zsh
chsh -s $(which zsh)



#TODO: might need also to get python3 and also might need to create a symlink from the folder python to python3?
#python3-pip python package installer
sudo apt install python3-pip -y
#venv virtual environment needed for pipx 
sudo apt install python3-venv
#pipx vritual environment pip for installing stig torrent client
python3 -m pip install --user pipx
python3 -m pipx ensurepath
#install stig with pipx self contained virtual environment
pipx install stig
#yt-dlp  - fork of youtube-dl
pipx install yt-dlp
#spotdl downloads songs from youtube but gives you the spotify metadata
pipx install spotdl
#TODO try that undetected webdriver python bot on this computer then put the install for undetected webdriver in here maybe for pipx if not then just for pip


#torrent daemon
sudo apt install transmission-daemon

#rss reader
sudo apt install newsboat -y 

#to do list and calender
sudo apt install calcurse -y

#spanish english dictioary
sudo apt install dictd -y
sudo apt install dict-freedict-spa-eng -y
sudo apt install dict-freedict-eng-spa -y


#MIGHT BE A GOOD IDEA TO GET POSTFIX set it to offline tho so u get mail for when ur cron fails in /var/mail

#timeshift to restore snapshots if something is broken still needs to be configured
sudo apt install timeshift -y



figlet still got to get crontabs and put them in can be found sudo nvim /var/spool/cron/crontabs


#NEEDED for mounting the samba share to your etc/fstab file
sudo apt install cifs-utils

#TODO manually you need to add your samba shares to fstab
#mount the drive to /media/$USER/FOLDERNAMEORUFCHOICE
#insie of pcmanfm add the mounted directory to bookmarks

