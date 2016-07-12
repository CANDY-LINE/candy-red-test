#!/usr/bin/env bash

TEST_HOME=${TEST_HOME:-$(dirname $0)}
ROOT=${ROOT:-${TEST_HOME}/..}
IMG_DIR=${ROOT}/img
LOCAL_FILE_NAME=${LOCAL_FILE_NAME:-$1}
DOWNLOAD_URL=${DOWNLOAD_URL:-$2}
UNZIP_DIR=${3:-${IMG_DIR}}

function assert_args {
  if [ -z ${LOCAL_FILE_NAME} ]; then
    echo "LOCAL_FILE_NAME is required"
  fi
  if [ -z ${DOWNLOAD_URL} ]; then
    echo "DOWNLOAD_URL is required"
  fi
  if [ ! -d ${UNZIP_DIR} ]; then
    mkdir -p ${UNZIP_DIR}
  fi
}

function assert_dependencies {
  UNZIP=`which unzip`
  if [ "$?" != "0" ]; then
    echo "Error! Unzip is missing."
    exit 1
  fi

  REALPATH=`which realpath`
  if [ "$?" != "0" ]; then
    echo "Error! realpath is missing."
    exit 1
  fi
}

function get_remote_etag {
  REMOTE_ETAG=$(curl -X HEAD -L ${DOWNLOAD_URL} -I -s | grep ETag | awk -F ": " '{print $2}' | tr -d '\r\n')
}

function get_local_etag {
  if [ -f "${IMG_DIR}/${LOCAL_FILE_NAME}.img" ]; then
    if [ -f "${IMG_DIR}/${LOCAL_FILE_NAME}.etag" ]; then
      LOCAL_ETAG=$(cat ${IMG_DIR}/${LOCAL_FILE_NAME}.etag | tr -d '\r\n')
    fi
  fi
}

function download_zip {
  if [ "${REMOTE_ETAG}" == "${LOCAL_ETAG}" ]; then
    info "IDENTICAL!! Skip to download"
  else
    echo ${REMOTE_ETAG} > "${IMG_DIR}/${LOCAL_FILE_NAME}.etag"
    rm -f "${IMG_DIR}/${LOCAL_FILE_NAME}.zip"
    curl -o "${IMG_DIR}/${LOCAL_FILE_NAME}.zip" -L ${DOWNLOAD_URL}
    if [ "$?" != "0" ]; then
      echo "cURL failure!"
      exit "$?"
    fi
  fi
}

function extract_img {
  rm -f "${IMG_DIR}/${LOCAL_FILE_NAME}.img"
  unzip -o "${IMG_DIR}/${LOCAL_FILE_NAME}.zip" -d ${UNZIP_DIR}
  EXT4=`ls ${UNZIP_DIR}/*.ext4`
  if [ "$?" == "0" ]; then
    cp -f ${EXT4} "${IMG_DIR}/${LOCAL_FILE_NAME}.img"
  else
    mv ${IMG_DIR}/2*.img ${IMG_DIR}/${LOCAL_FILE_NAME}.img
  fi
}

assert_args
assert_dependencies
get_local_etag
get_remote_etag
info "Remote ETag [${REMOTE_ETAG}]"
info "Local ETag  [${LOCAL_ETAG}]"

download_zip
extract_img
