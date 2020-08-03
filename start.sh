#!/bin/bash

# Build
docker build -t pcoip_appliance .

# Run
docker run --rm -it -d \
    -e DISPLAY=$DISPLAY \
    -e QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v teradici-client-config:/home/myuser/.config \
    --network=host \
    --device=/dev/dri/:/dev/dri/ \
    pcoip_appliance
