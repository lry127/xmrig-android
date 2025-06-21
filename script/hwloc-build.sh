#!/bin/bash

set -e

source script/env.sh

cd $EXTERNAL_LIBS_BUILD_ROOT/hwloc


if [ ! -f "configure" ]; then
  ./autogen.sh
fi

for arch in ${archs[@]}; do
    case ${arch} in
        "arm")
            target_host=arm-linux-androideabi
            ANDROID_ABI="armeabi-v7a"
            ;;
        "arm64")
            target_host=aarch64-linux-android
            ANDROID_ABI="arm64-v8a"
            ;;
        "x86")
            target_host=i686-linux-android
            ANDROID_ABI="x86"
            ;;
        "x86_64")
            target_host=x86_64-linux-android
            ANDROID_ABI="x86_64"
            ;;
        *)
            exit 16
            ;;
    esac

    TARGET_DIR=$EXTERNAL_LIBS_ROOT/hwloc/$ANDROID_ABI

    if [ -f "$TARGET_DIR/lib/hwloc.la" ]; then
      continue
    fi

    mkdir -p $TARGET_DIR
    echo "building for ${arch}"
    export TOOLCHAIN=$TOOLCHAINS_PATH

    export AR=$TOOLCHAIN/bin/llvm-ar
    export CC="$TOOLCHAIN/bin/clang --target=$target_host$API"
    export AS=$CC
    export CXX="$TOOLCHAIN/bin/clang++ --target=$target_host$API"
    export LD=$TOOLCHAIN/bin/ld
    export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
    export STRIP=$TOOLCHAIN/bin/llvm-strip
    ./configure \
    --prefix=${TARGET_DIR} \
    --host=${target_host} \
    --enable-static \
    --disable-shared \
    && make -j $BUILDING_J \
    && make install \
    && make clean

done

exit 0
