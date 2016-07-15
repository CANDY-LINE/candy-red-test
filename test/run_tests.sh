#!/usr/bin/env bash

TEST_HOME=${TEST_HOME:-$(dirname $0)}
ROOT=${ROOT:-${TEST_HOME}/..}
TAG=${TAG:-master}

. ${TEST_HOME}/raspbian_installation_test.sh
# . ${TEST_HOME}/yocto_installation_test.sh
