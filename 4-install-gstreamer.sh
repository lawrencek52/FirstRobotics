mkdir gstreamer
cd gstreamer
sudo apt-get install -y fakeroot devscripts quilt
sudo apt-get build-dep -y gstreamer1.0-plugins-good
apt-get source gstreamer1.0-plugins-good
cd gst-plugins-good1.0-1.14.4

## edit Rules
sed -i '180a \\t--enable-v4l2-probe \\' debian/rules
sed -i '181a \\t--without-libv4l2 \\' debian/rules
#
time debuild -b -uc -us
time sudo dpkg -i ../gstreamer1.0-plugins-good_1.14.4*_arm64.deb

