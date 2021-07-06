# Based on: https://www.teradici.com/web-help/pcoip_client/linux/20.07/reference/creating_a_docker_container/
FROM ubuntu:18.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Replace jesse with your local username
# Replace 1000 with your local user's uid
# Replace 1000 with your local user's gid
ARG USERNAME=jesse
ARG UID=1000
ARG GID=1000

# Use the following two lines to install the Teradici repository package
RUN apt-get update && apt-get install -y wget
RUN wget -O teradici-repo-latest.deb https://downloads.teradici.com/ubuntu/teradici-repo-bionic-latest.deb
RUN apt install ./teradici-repo-latest.deb

# Uncomment the following line to install Beta client builds from the internal repository
RUN echo "deb [arch=amd64] https://downloads.teradici.com/ubuntu bionic-beta non-free" > /etc/apt/sources.list.d/pcoip.list

# Install apt-transport-https to support the client installation
RUN apt-get update && apt-get install -y apt-transport-https

# Install the client application
RUN apt-get install -y pcoip-client

# Setup the GUI using the driver downloaded in the start script
# Thanks https://stackoverflow.com/a/44187181 !!!
RUN apt-get install -y libgl1-mesa-glx libgl1-mesa-dri mesa-utils module-init-tools kmod
COPY NVIDIA-DRIVER.run NVIDIA-DRIVER.run
RUN ./NVIDIA-DRIVER.run -a -N --ui=none --no-kernel-module

# Setup a functional user within the docker container with the same permissions as your local user.
RUN groupadd -g $UID $USERNAME
RUN useradd -ms /bin/bash -u $UID -g $GID $USERNAME
RUN usermod -a -G video $USERNAME

# Set some environment variables for the current user
USER $USERNAME
ENV HOME /home/$USERNAME

# Set the path for QT to find the keyboard context
ENV QT_XKB_CONFIG_ROOT /usr/share/X11/xkb

ENTRYPOINT exec pcoip-client
