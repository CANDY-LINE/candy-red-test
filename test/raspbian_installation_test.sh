#!/usr/bin/env bash

TEST_HOME=`realpath ${TEST_HOME:-$(dirname $0)}`
ROOT=`realpath ${ROOT:-${TEST_HOME}/..}`

. ${TEST_HOME}/_common.sh
. ${TEST_HOME}/_download_img.sh raspbian_latest http://downloads.raspberrypi.org/raspbian_latest

docker run --rm --privileged multiarch/qemu-user-static:register --reset
docker run --name rpi -it --rm --privileged=true -e SHELL=${SHELL} -e TAG=${TAG} -v /tmp:/tmp -v ${TEST_HOME}/raspbian_run.sh:/usr/rpi/run.sh -v ${TEST_HOME}/raspbian_test.sh:/usr/rpi/raspbian_test.sh -v ${ROOT}/img:/usr/rpi/images -w /usr/rpi ryankurte/docker-rpi-emu ./run.sh images/raspbian_latest.img
