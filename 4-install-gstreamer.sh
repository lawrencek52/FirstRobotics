mkdir gstreamer
cd gstreamer
sudo apt-get install -y fakeroot devscripts quilt
sudo apt-get build-dep -y gstreamer1.0-plugins-good
sudo apt install libavc1394-dev libaa1-dev libcaca-dev \
       	libcairo2-dev libdv4-dev libflac-dev libgdk-pixbuf2.0-dev \
       	libjack-dev libjpeg9-dev libpng-dev libpulse-dev libshout3-dev \
       	libsoup2.4-dev libspeex-dev libtaglib-cil-dev libwavpack-dev \
       	libx11-dev
sudo apt install libasound2-dev libcdparanoia-dev libvorbisidec-dev \
       	libvisual-0.4-dev libopus-dev libpango1.0-dev libxv-dev
apt-get source gstreamer1.0-plugins-good
cd gst-plugins-good1.0-1.14.4

## edit Rules
sed -i '180a \\t--enable-v4l2-probe \\' debian/rules
sed -i '181a \\t--without-libv4l2 \\' debian/rules
#
time debuild -b -uc -us
time sudo dpkg -i ../gstreamer1.0-plugins-good_1.14.4*_arm64.deb

