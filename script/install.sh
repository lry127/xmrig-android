#!/bin/bash

set -e

source script/env.sh

for arch in ${archs[@]}; do
    case ${arch} in
        "arm")
			xarch="armeabi-v7a"
			;;
        "arm64")
			xarch="arm64-v8a"
            ;;
        "x86")
			xarch="x86"
            ;;
        "x86_64")
			xarch="x86_64"
            ;;
        *)
			exit 16
            ;;
    esac

	ROOT_DIR=`pwd`/products/$xarch
    rm -rf $ROOT_DIR; mkdir -p $ROOT_DIR
	XMRIG_DIR=$EXTERNAL_LIBS_BUILD_ROOT/xmrig/build/$xarch
	cp $XMRIG_DIR/xmrig $ROOT_DIR/xmrig

    DEPS_DIR=`pwd`/deps/
    
    # hwloc
    mkdir -p $DEPS_DIR/hwloc/$xarch/lib
    cp -r $EXTERNAL_LIBS_ROOT/hwloc/$xarch/include $DEPS_DIR/hwloc/$xarch
    cp $EXTERNAL_LIBS_ROOT/hwloc/$xarch/lib/libhwloc.a $DEPS_DIR/hwloc/$xarch/lib

    # libuv
    mkdir -p $DEPS_DIR/libuv/$xarch/lib
    cp -r $EXTERNAL_LIBS_ROOT/libuv/$xarch/include $DEPS_DIR/libuv/$xarch
    cp $EXTERNAL_LIBS_ROOT/libuv/$xarch/lib/libuv.a $DEPS_DIR/libuv/$xarch/lib

    # openssl
    mkdir -p $DEPS_DIR/openssl/$xarch/lib
    cp -r $EXTERNAL_LIBS_ROOT/openssl/$xarch/include $DEPS_DIR/openssl/$xarch
    cp $EXTERNAL_LIBS_ROOT/openssl/$xarch/lib/libssl.a $DEPS_DIR/openssl/$xarch/lib
    cp $EXTERNAL_LIBS_ROOT/openssl/$xarch/lib/libcrypto.a $DEPS_DIR/openssl/$xarch/lib

done
exit 0
