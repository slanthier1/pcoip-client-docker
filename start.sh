#!/bin/bash

# Download the nvidia driver
version="$(glxinfo | grep "OpenGL version string" | rev | cut -d" " -f1 | rev)"
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/"$version"/NVIDIA-Linux-x86_64-"$version".run
mv NVIDIA-Linux-x86_64-"$version".run NVIDIA-DRIVER.run
chmod a+x NVIDIA-DRIVER.run

## Build
sudo docker build -t pcoip_appliance .

# Run
sudo docker run --rm -it -d \
    --gpus all \
    -e DISPLAY=$DISPLAY \
    -e QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw --privileged \
    -v `pwd`/teradici-client-config/:/home/`whoami`/.config/Teradici/ \
    -v `pwd`/logs:/tmp/Teradici/`whoami`/PCoIPClient/logs \
    --network=host \
    --device /dev/dri \
    --device /dev/bus/usb \
    --device /dev/video0 \
    --name pcoip_docker \
    pcoip_appliance
