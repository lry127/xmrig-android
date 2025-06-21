#!/bin/bash

set -e

source script/env.sh

cd $EXTERNAL_LIBS_BUILD_ROOT/openssl
#mkdir build && cd build

PATH=$TOOLCHAINS_PATH/bin:$PATH
echo $PATH
echo "Tool: $TOOLCHAINS_PATH"
ANDROID_API=$API
ANDROID_PLATFORM=android-$API

for arch in ${archs[@]}; do
    case ${arch} in
        "arm")
            architecture=android-arm
            ANDROID_ABI="armeabi-v7a"
            ;;
        "arm64")
            architecture=android-arm64
            ANDROID_ABI="arm64-v8a"
            ;;
        "x86")
            architecture=android-x86
            ANDROID_ABI="x86"
            ;;
        "x86_64")
            architecture=android-x86_64
            ANDROID_ABI="x86_64"
            ;;
        *)
            exit 16
            ;;
    esac

    TARGET_DIR=$EXTERNAL_LIBS_ROOT/openssl/$ANDROID_ABI

    mkdir -p $TARGET_DIR
    echo "building for ${arch}"

    ./Configure ${architecture} -D__ANDROID_API__=$ANDROID_API --prefix=${TARGET_DIR} -no-shared -no-asm -no-zlib -no-comp -no-dgram -no-filenames -no-cms

    make -j $BUILDING_J
    make install -j $BUILDING_J
    make clean

done

exit 0
