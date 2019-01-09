
# INSTALL THE DEPENDENCIES

# GUI (if you want to use GTK instead of Qt, replace 'qt5-default' with 'libgtkglext1-dev' and remove '-DWITH_QT=ON' option in CMake):
sudo apt-get install -y qt5-default 
sudo apt-get install -y libqt5opengl5-dev 
sudo apt-get install -y python3-pyqt5.qtopengl python3-opengl

# Media I/O:
sudo apt-get install -y zlib1g-dev libwebp-dev libpng-dev libtiff5-dev libopenexr-dev libgdal-dev
sudo apt-get install -y libjpeg62-turbo-dev libtiff5-dev 

#fetch and build libjasper
mkdir jasper
cd jasper
wget  http://www.ece.uvic.ca/~frodo/jasper/software/jasper-2.0.14.tar.gz 
tar -vzxf  jasper-2.0.14.tar.gz 
cd jasper-2.0.14
mkdir BUILD
cd BUILD
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_SKIP_INSTALL_RPATH=YES -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/jasper-2.0.14 ..  
make
sudo make install
cd ../../..

# Video I/O:
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install -y libxvidcore-dev libx264-dev

# Parallelism and linear algebra libraries:
sudo apt-get install -y libtbb-dev libeigen3-dev
sudo apt-get install -y libcblas-dev gfortran
sudo apt-get install -y libopenblas-dev liblapack-dev

# gstreamer, opengl and vtk
sudo apt-get install -y libgstreamer1.0-0
sudo apt-get install -y freeglut3-dev libglew-dev libglm-dev mesa-common-dev
sudo apt-get install -y libvtk6-qt-dev python-vtk6

# Python:
sudo apt-get install -y python3-dev python3-tk python3-numpy
sudo apt-get install -y python3-scipy python3-matplotlib
#wget https://bootstrap.pypa.io/get-pip.py
#sudo python get-pip.py

# Java:
sudo apt-get install -y ant default-jdk

# Documentation:
sudo apt-get install -y doxygen
sudo apt-get install -y unzip wget


# INSTALL THE LIBRARY (YOU CAN CHANGE '3.4.4' FOR THE LAST STABLE VERSION)

#wget https://github.com/opencv/opencv/archive/3.4.4.zip
#unzip 3.4.4.zip
#rm 3.4.4.zip
#mv opencv-3.2.0 OpenCV
git clone https://github.com/opencv/opencv_contrib.git
git clone https://github.com/opencv/opencv.git
cd opencv
mkdir build
cd build
cmake -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -DWITH_LIBV4L=ON -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON -DWITH_OPENMP=ON -DWITH_GSTREAMER=ON -DWITH_OPENCL=ON ..
make -j1
sudo make install
sudo ldconfig
cd ../..


#install the imutils (which depend on mtools and the OpenCV just built)
sudo apt-get install -y v4l-utils python3-pip
pip3 install imtools
pip3 install imutils

# EXECUTE SOME OPENCV EXAMPLES AND COMPILE A DEMONSTRATION

# To complete this step, please visit 'http://milq.github.io/install-opencv-ubuntu-debian'.

