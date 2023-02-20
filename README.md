# AWIPS2 Cave Docker Image

### **All commands here assume you have docker installed and running. And are using Powershell Core**

**NOTE:** This readme for running the image was setup for WSL2 on Windows 11. It may not work on other systems.

This repository contains the Dockerfile and supporting files to build the AWIPS2 Cave Docker image and the ability to run it.

## Building the Image

To build the image, run the following command:

    docker build --build-arg USER=${env:username} -t awips2-cave:latest .

## Running the Image

To run the image you just created use the following command:

```
docker run --hostname ${env:computername} --gpus all --rm -ti -e DISPLAY=:0 -e WAYLAND_DISPLAY=wayland-0 -e XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir -e PULSE_SERVER=/mnt/wslg/PulseServer -v /run/desktop/mnt/host/wslg/.X11-unix:/tmp/.X11-unix -v /run/desktop/mnt/host/wslg:/mnt/wslg -v ${HOME}/caveData:/home/awips/caveData awips2-cave:latest
```

**NOTE:** If you change the `USER` you must change the mount point for the `caveData` directory. See the `caveData` section below.

## Cave Data

The `caveData` directory is where you will store your cave data. This is where you will store your CAVE configuration files, localization files, and other data. This directory is mounted to the container at `/home/awips/caveData`. 

If you use a custom `USER` you should change the mount point for the `caveData` directory to the home directory of the user you are using. (EX: `/home/${env:username}/caveData`)

**NOTE:** The `caveData` directory in the above command is mounted to `${HOME}/caveData`. You can change this to any directory you want.