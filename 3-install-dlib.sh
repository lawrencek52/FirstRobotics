#!/bin/sh
echo "script to create install dlib"
echo "    -A - apt-get required packages for dlib, only needs to be done once"
echo "    -D - Download and build dlib, only necessary if not already on your SDCard"
echo "    -I - Install dlib into the system area of the eMMC"

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
apt=0
download=0
install=0

while getopts "v:ADI" opt; do
    case "$opt" in
    A)  apt=1
        ;;
    D)  download=1
        ;;
    I)  install=1
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

echo "apt=$apt, download=$download, install=$install, Leftovers: $@"

if [ $apt = 1 ]; then
	# install the required packages for dlib
	sudo apt-get install -y build-essential cmake
	sudo apt-get install -y libopenblas-dev liblapack-dev
	sudo apt-get install -y libx11-dev
	sudo apt-get install -y libgtk-3-dev libjpeg-dev
	sudo apt-get install -y libboost-all-dev
	sudo apt-get install -y python3-pip python3-setuptools python3-wheel
	sudo apt-get install -y python3-numpy python3-scipy python3-pil python3-skimage
fi

if [ $install = 1 ]; then
	if [ ! -d pip ]; then
		mkdir pip
	fi
	if [ ! -d dlib ]; then
		mkdir dlib
	fi
	cd dlib
	#pip by default builds in ~/.cache, we want to build in ./dlib
	# how to change this?
	export XDG_CACHE_HOME=~/workspace/FirstRobotics
	time pip3 install dlib
fi
