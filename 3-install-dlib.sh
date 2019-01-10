
# some basics
sudo apt-get install -y build-essential cmake
sudo apt-get install -y libopenblas-dev liblapack-dev
sudo apt-get install -y libx11-dev
sudo apt-get install -y libgtk-3-dev libjpeg-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y python3-pip python3-setuptools python3-wheel
sudo apt-get install -y python3-numpy python3-scipy python3-pil python3-skimage

mkdir dlib
cd dlib
time pip3 install dlib
