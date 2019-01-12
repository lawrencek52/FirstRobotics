# Define OpenCV Version to install 
OpenCV_Version="3.4.4"

# Clean build directories
rm -rf opencv/build
rm -rf opencv_contrib/build

# Save current working directory
cwd=$(pwd)

#libjasper1 doesn't seem to be available for arm64 Debian, so we
#fetch and build libjasper
if [ ! -d jasper ]; then
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
fi

## Install dependencies
sudo apt -y install build-essential cmake pkg-config yasm
sudo apt -y install git gfortran
sudo apt -y install libpng-dev libjpeg62-turbo-dev
sudo apt -y install software-properties-common
#sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

sudo apt -y install libtiff-dev
sudo apt -y install libqt5opengl5-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install libxine2-dev libv4l-dev
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd "$cwd"

sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev
sudo apt -y install x264 v4l-utils
sudo apt -y install libeigen3-dev 

# opengl and vtk
sudo apt-get install -y freeglut3-dev libglew-dev libglm-dev mesa-common-dev
sudo apt-get install -y libvtk6-qt-dev python-vtk6

# Optional dependencies
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

sudo apt -y install python3-dev python3-pip python3-dev
sudo apt -y install python3-tk python3-numpy
sudo apt -y install python3-testresources
sudo apt -y install python3-venv

if [ ! -d OpenCV-"$OpenCV_Version"-py3 ]; then
	cd $cwd
	############ For Python 3 ############
	# create virtual environment
#	python3 -m venv OpenCV-"$OpenCV_Version"-py3
#	echo "# Virtual Environment Wrapper" >> ~/.bashrc
#	echo "alias workoncv-$OpenCV_Version=\"source $cwd/OpenCV-$OpenCV_Version-py3/bin/activate\"" >> ~/.bashrc
#	source "$cwd"/OpenCV-"$OpenCV_Version"-py3/bin/activate

	mkdir OpenCV-"$OpenCV_Version"-py3
	cd OpenCV-"$OpenCV_Version"-py3


	# now install python libraries within this virtual environment
	pip3 install wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib

	# quit virtual environment
#	deactivate
	######################################
fi

cd $cwd
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout "$OpenCV_Version"
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout "$OpenCV_Version"
cd ..

cd opencv
mkdir build
cd build

#cmake -D CMAKE_BUILD_TYPE=RELEASE \
#            -D INSTALL_C_EXAMPLES=ON \
#            -D INSTALL_PYTHON_EXAMPLES=ON \
#            -D WITH_TBB=ON \
#            -D WITH_V4L=ON \
#        -D WITH_QT=ON \
#        -D WITH_OPENGL=ON \
#        -D BUILD_EXAMPLES=ON ..
#        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
#            -D CMAKE_INSTALL_PREFIX=/usr/local \
#            -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$OpenCV_Version-py3/lib/python3.5/site-packages \

cmake -DWITH_LIBV4L=ON \
      -DWITH_QT=ON \
      -DCMAKE_BUILD_TYPE=RELEASE \
      -DWITH_OPENGL=ON \
      -DFORCE_VTK=ON \
      -DWITH_TBB=ON \
      -DWITH_GDAL=ON \
      -DWITH_XINE=ON \
      -DBUILD_EXAMPLES=ON \
      -DWITH_OPENMP=ON \
      -DWITH_GSTREAMER=ON \
      -DWITH_OPENCL=ON ..

#make -j3
#sudo make install
