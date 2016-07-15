#!/bin/bash

# Run inside QEMU guest

apt-get -qq update
apt-get -qq upgrade
curl -sL https://deb.nodesource.com/setup_0.12 | bash -
apt-get install -qq python-dev python-rpi.gpio bluez nodejs

NODE_OPTS=--max-old-space-size=128 \
  DISABLE_SERVICE_INSTALL=1 \
  npm install -g --unsafe-perm \
  https://github.com/dbaba/candy-red/tarball/${TAG}
