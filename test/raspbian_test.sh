#!/bin/bash

# Run inside QEMU guest

if [ "${SHELL}" == "1" ]; then
  bash
else
  WELCOME_FLOW_URL=${WELCOME_FLOW_URL:-"https://git.io/vKhk3"}
  apt-get -qq update
  curl -sL https://deb.nodesource.com/setup_0.12 | bash -
  apt-get install -qq python-dev python-rpi.gpio bluez nodejs libudev-dev

  if [ "${TAG}" == "master" ]; then
    PKG="candy-red"
  elif [ "${TAG}" == "develop" ]; then
    PKG="https://github.com/dbaba/candy-red/tarball/${TAG}"
  else
    PKG="candy-red@${TAG}"
  fi
  WELCOME_FLOW_URL=${WELCOME_FLOW_URL} \
    NODE_OPTS=--max-old-space-size=128 \
    DISABLE_SERVICE_INSTALL=1 \
    npm install -g --unsafe-perm \
    ${PKG}
fi
