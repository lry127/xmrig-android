#!/bin/bash

set -e

source script/env.sh

cd $EXTERNAL_LIBS_BUILD_ROOT/xmrig
sed -e "s/pthread rt dl log/dl/g" CMakeLists.txt > TempCMakeLists.txt
rm -f CMakeLists.txt
mv TempCMakeLists.txt CMakeLists.txt
mkdir build && cd build

TOOLCHAIN=$ANDROID_HOME/ndk/$NDK_VERSION/build/cmake/android.toolchain.cmake
CMAKE=$ANDROID_HOME/cmake/3.18.1/bin/cmake
ANDROID_PLATFORM=android-$API


for arch in ${archs[@]}; do
    case ${arch} in
        "arm")
            target_host=arm-linux-androideabi
            ANDROID_ABI="armeabi-v7a"
            ARM_TARGET=7
            ;;
        "arm64")
            target_host=aarch64-linux-android
            ANDROID_ABI="arm64-v8a"
            ARM_TARGET=8
            ;;
        "x86")
            target_host=i686-linux-android
            ANDROID_ABI="x86"
            ARM_TARGET=0
            ;;
        "x86_64")
            target_host=x86_64-linux-android
            ANDROID_ABI="x86_64"
            ARM_TARGET=0
            ;;
        *)
            exit 16
            ;;
    esac

    mkdir -p $EXTERNAL_LIBS_BUILD_ROOT/xmrig/build/$ANDROID_ABI
    cd $EXTERNAL_LIBS_BUILD_ROOT/xmrig/build/$ANDROID_ABI

    echo "building for ${arch}"

    $CMAKE -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN \
        -DANDROID_ABI="$ANDROID_ABI" \
        -DANDROID_PLATFORM=$ANDROID_PLATFORM \
        -DANDROID_CROSS_COMPILE=ON \
        -DWITH_OPENCL=OFF \
        -DWITH_CUDA=OFF \
        -DBUILD_STATIC=OFF \
        -DWITH_TLS=ON \
        -DWITH_BENCHMARK=OFF \
        -DWITH_DMI=OFF \
        -DHWLOC_LIBRARY="$EXTERNAL_LIBS_ROOT/hwloc/$ANDROID_ABI/lib/libhwloc.a" \
        -DHWLOC_INCLUDE_DIR="$EXTERNAL_LIBS_ROOT/hwloc/$ANDROID_ABI/include" \
        -DUV_LIBRARY="$EXTERNAL_LIBS_ROOT/libuv/$ANDROID_ABI/lib/libuv.a" \
        -DUV_INCLUDE_DIR="$EXTERNAL_LIBS_ROOT/libuv/$ANDROID_ABI/include/" \
        -DOPENSSL_SSL_LIBRARY="$EXTERNAL_LIBS_ROOT/openssl/$ANDROID_ABI/lib/libssl.a" \
        -DOPENSSL_CRYPTO_LIBRARY="$EXTERNAL_LIBS_ROOT/openssl/$ANDROID_ABI/lib/libcrypto.a" \
        -DOPENSSL_INCLUDE_DIR="$EXTERNAL_LIBS_ROOT/openssl/$ANDROID_ABI/include " \
        ../../ && make -j $BUILDING_J

done

exit 0
