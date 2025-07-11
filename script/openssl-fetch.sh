#!/usr/bin/env bash

set -e

source script/env.sh

cd $EXTERNAL_LIBS_BUILD_ROOT

OPENSSL_VERSION="3.5.0"

if [ ! -d "openssl" ]; then
  wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz -O openssl.tar.gz
  tar -xvf openssl.tar.gz
  mv openssl-${OPENSSL_VERSION} openssl
fi
