#!/bin/bash

# https://github.com/ryankurte/docker-rpi-emu/blob/master/scripts/run.sh
#
# Convenience script to manage qemu inside docker container
# Chains the provided helper scripts to mount the image, bootstrap qemu, run a command
# and tear down the environment correctly.

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 IMAGE MOUNT"
    echo "IMAGE - raspberry pi .img file"
    exit
fi

CWD=`pwd`
MOUNT_DIR=/media/rpi
TAG=${TAG:-master}

set -e

# Create mount dir
mkdir -p $MOUNT_DIR

# Mount ISO
./mount.sh $1 $MOUNT_DIR

mount --bind /dev $MOUNT_DIR/dev
mount --bind /sys $MOUNT_DIR/sys
mount --bind /proc $MOUNT_DIR/proc
mount --bind /dev/pts $MOUNT_DIR/dev/pts
mkdir -p $MOUNT_DIR/usr/lib/node_modules; \
    mkdir -p ./node_modules; \
    mount --bind $(pwd)/node_modules $MOUNT_DIR/usr/lib/node_modules

# Copy installation script
cp ./raspbian_test.sh ${MOUNT_DIR}

# Bootstrap QEMU
./qemu-setup.sh $MOUNT_DIR

# Launch QEMU and perform test
echo "Starting test..."
chroot $MOUNT_DIR /usr/bin/env TAG=${TAG} ./raspbian_test.sh
# chroot $MOUNT_DIR /bin/bash
echo "Finishing test..."

# Remove QEMU
./qemu-cleanup.sh $MOUNT_DIR

# Exit
./unmount.sh $MOUNT_DIR
