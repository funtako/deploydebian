#!/bin/bash

#update and install all updates
sudo apt update
sudo apt upgrade -y

sucklessloc=$HOME/suckless

# install some important programs
sudo apt-get install -y vim xinit git build-essential wget curl

# install dependencies for suckless dwm
sudo apt-get install -y libx11-dev libxft-dev libxinerama-dev

#TODO get sudo make install them all get a debian virtual machine on virtual box to test this stuff out on 

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
