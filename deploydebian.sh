#!/bin/bash

#TODO dont tg has my mobile number in .config/tg for telegram I DONT WANT PPL SEEING THIS
#TODO also add the paths from .zprofile to your .profile then add to the dot files github incase you use bash at some point
#ALSO ON THINKPAD LAPTOPS YOU WANT tp-smapi-dkms for extra battery related rules
#alsa-utils? I'm not sure tho this is sound might need the pulseaudio instead
#different script for neomutt
#BRAVE all the extensions i use for it and privacy settings 
#terminal webbrower when you find the one you prefer and have vim keybindings
#virtualbox?
#doom emacs?
#GET A FILE THAT WILL JUST LOG THE OUTPUT OF THE SCRIPT

#TODO flatpak and install maybe mpv with it then system link it to /usr/bin so can use it with dmenu
#TODO maybe get more apps with flatpak like GIMP or things that got too outdated
#TODO add a alias to sau to also update flatpak 

#TODO need to install man

#TODO maybe change terminal to sixel supported one for better image previews in lf

#TODO get all emojis probably need a better font or something 

#update and install all updates
sudo apt update
sudo apt upgrade -y

#YOU NEED TO SET UP YOUR SERVERS IN ~/.ssh/config

#Remove 5 second grub countdown when you turn on PC. (YOU WON'T WANT TO DO THIS IF YOU HAVE MULTIPLE OSs TO CHOOSE TO BOOT INTO
#replaces GRUB_TIMEOUT=ANY NUMBER - or Positive with GRUB_TIMEOUT=0
#-E enables regex
#TODO PUT A PROMPT HERE ASKING IF YOU WANT TO CHANGE GRUB SETTINGS
sudo sed -Ei 's/^GRUB_TIMEOUT=-?[0-9]+$/GRUB_TIMEOUT=0/' /etc/default/grub
#shows a screen of what its doing when you turn on and off
#sudo sed -Ei 's/^(GRUB_CMDLINE_LINUX_DEFAULT=)".*"/GRUB_CMDLINE_LINUX_DEFAULT="splash"/' /etc/default/grub
sudo update-grub
#ALSO IN YOUR BIOS YOU SHOULD ENABLE FAST BOOT AND REDUCE POST DELAY TIME TO 0 SECONDS. as long as its still possible to access BIOS if needed

sucklessloc=$HOME/suckless
dotfilesloc=$HOME/funtako/dot-files
programming_loc=$HOME/programming/shell-scripts

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

#network-manager for connecting to wifi, after this you can use nmtui and nmcli
sudo apt install network-manager -y



# install some important programs
sudo apt-get install -y neovim xinit git build-essential wget curl

#zsh shell has more features than bash shell
sudo apt install zsh -y

#get the fast-syntax-highlighting plugin and put it in that folder, this is at the bottom of ~/.zshrc
#means that incorrect commands will be red and correct will be green
sudo git clone https://github.com/zdharma-continuum/fast-syntax-highlighting /usr/share/zsh/plugins/fast-syntax-highlighting/

#change default shell to zsh
chsh -s $(which zsh)


#Firewall for basic desktop use (might not need)
sudo apt install ufw -y
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing

#p7zip-full aka 7za for unzipping 7z and loads of other types of files like zip files
sudo apt install p7zip-full -y

#unzip so can preview zip files in lf
sudo apt install unzip -y

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
sudo cp -r $dotfilesloc/scripts/ $programming_loc

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

#librewolf privacy fork of firefox browser


sudo apt update && sudo apt install -y wget gnupg lsb-release apt-transport-https ca-certificates

distro=$(if echo " una vanessa focal jammy bullseye vera uma" | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

sudo apt update

sudo apt install librewolf -y



################

#my secondary webbrowser firefox
#sudo apt install firefox-esr -y

#install nitrogen wallpaper utility
sudo apt install nitrogen -y

#install libreoffice
sudo apt install libreoffice -y

#TODO LATER CHANGE THIS FOR PICOM AND THEN GET ROUNDED CORNERS
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
#TODO find something else
#sudo apt install calibre -y


#figlet just lets you make cool looking big text in terminal
sudo apt install figlet -y

#the gui versoin of vim, used for getting the copy and paste to clipboard function working WAIT MIGHT NOT EVEN NEED IT LOL
#MIGHT NOT NEED IT
#sudo apt install vim-gtk -y

#gui disk partition program
sudo apt install gparted -y

#gui picture editing program
sudo apt install gimp -y

#sxiv terminal picture view
sudo apt install sxiv -y

#cmatrix just makes terminal look like matrix movie
#TODO: make this my sreensaver if I don't touch the screen for some time
#sudo apt install cmatrix -y

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

#TO SEE THE MUSIC PRESS u IN NCMPCPP TO UPDATE
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
sudo apt install libnotify-bin -y
sudo apt install dunst -y
#allows notify-send to be used from crontab
sudo apt install dbus-x11 -y
####################




#terminal pdf reader
sudo apt install zathura -y

#gui torrent client qbittorrent
sudo apt install qbittorrent -y


#fuzzy FuZzy finder - lets you quickly search to find a file
sudo apt install fzf -y


########
#GO needed to install lf file manager
#TODO check if there is a newer version
GOLANG_DIR="$HOME/Downloads/golang" && mkdir -p $GOLANG_DIR && cd $GOLANG_DIR && wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz

#Extract files to the /usr/local directory
sudo tar -C /usr/local/ -xzf go1.20.4.linux-amd64.tar.gz

#in .zprofile and .profile you should have added /usr/local/go/bin to PATH

#lf its like ranger but faster terminal based file manager to update it though you might need to 
#update manually by getting it again from github
#just make sure we are in home directory for this
cd $HOME
env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest

#TODO NOTE IM NOT SURE IF THIS IS A GOOD PLACE TO PUT IT, LIKE PYTHON BINARIES DONT GO HERE, I DONT KNOW WHERE GO BINARIES GO THOUGH
#now move lf from the folder in home to /usr/bin
sudo cp $HOME/go/bin/lf /usr/bin

#gets images in terminal (quality is bad though without sixel st doesn't support sixel without patching)
sudo apt install chafa -y

#lets you create thumbnails for video files in terminal with LF useful
sudo apt install ffmpegthumbnailer -y


#preview odt ods odp sxw files
sudo apt install odt2txt -y

#terminal web browser can use to preview html files
sudo apt install w3m -y 


#syntax highlighting in file previews with set previewer     *) highlight -O ansi "$1";;
#sudo apt install highlight -y 

##############



#TODO: might need also to get python3 and also might need to create a symlink from the folder python to python3?
#python3-pip python package installer
sudo apt install python3-pip -y
#venv virtual environment needed for pipx 
sudo apt install python3-venv -y
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
#TODO IT DONT WORK
sudo apt install cifs-utils

#TODO manually you need to add your samba shares to fstab
#mount the drive to /media/$USER/FOLDERNAMEORUFCHOICE
#insie of pcmanfm add the mounted directory to bookmarks

#TODO add extra hard drives to /etc/fstab 
#so they mount at boot.
#need to get UUID for drive with sudo blkid
#Mount dir should be /media/mount-name, then sudo chown $USER:$USER for that folder. I'm using ext4 file system. 
#e.g. UUID="67b0077d-09f3-47f5-93cd-3bf8d197ea87" /media/Second-SSD ext4 defaults 0 0
#test it with
#sudo mount -a



#Change swapiness value to 10, sill start using swap less aggressivly. RAM is faster than swap so only want to use swap, if I'm really low on free RAM
echo "#vm.swapiness=10" | sudo tee -a /etc/sysctl.conf

#TODO if you have a lot of space on hard drive then increase the amount of space you have in swap 

#TODO get printer separately for my brother HL2130 printer I got the drivers from the brother website, but I also need to install lpr. After running lpr it worked for printing



######################
#qemu / virt-manager (for virtual machines)
#from https://christitus.com/vm-setup-in-linux/
#Make sure you’ve enabled virtualization in on your computer. It should be above 0
egrep -c '(vmx|svm)' /proc/cpuinfo
#Install QEMU and Virtual Machine Manager
sudo apt install qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y
#Verify that Libvirtd service is started
sudo systemctl status libvirtd.service

#Start Default Network for Networking
sudo virsh net-start default
#Network default started
sudo virsh net-autostart default
#Check status with:
sudo virsh net-list --all

#Add User to libvirt to Allow Access to VMs
sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER
###########################


#change font size in TTY
sudo dpkg-reconfigure console-setup


#OBS
sudo apt install obs-studio
#lets you start virtual camera in OBS
sudo apt install v4l2loopback-dkms


#sqlite needed for reading the brave browser history to put into fzf 
sudo apt install sqlite3 -y


#whois for checking who owns a website
sudo apt install whois -y


#greenclip
#might have a new version out
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -P /usr/local/bin
sudo chmod +x /usr/local/bin/greenclip
