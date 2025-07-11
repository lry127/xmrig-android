realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

archs=(arm64 arm) # arm arm64 x86 x86_64
export API=26
export BUILDING_J=20 # -jN

export NDK_VERSION="27.0.12077973"
export ANDROID_NDK_HOME="${ANDROID_HOME}/ndk/${NDK_VERSION}"
export TOOLCHAINS_PATH="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/"
export ANDROID_NDK_ROOT="${ANDROID_HOME}/ndk/${NDK_VERSION}"
export ANDROID_NDK_ROOT=`realpath $ANDROID_NDK_ROOT`

DEFAULT_EXTERNAL_LIBS_BUILD=`pwd`/building/
EXTERNAL_LIBS_BUILD="${EXTERNAL_LIBS_BUILD:-${DEFAULT_EXTERNAL_LIBS_BUILD}}"
export EXTERNAL_LIBS_BUILD=${EXTERNAL_LIBS_BUILD%/}

DEFAULT_EXTERNAL_LIBS_BUILD_ROOT=${EXTERNAL_LIBS_BUILD}/src/
EXTERNAL_LIBS_BUILD_ROOT="${EXTERNAL_LIBS_BUILD_ROOT:-${DEFAULT_EXTERNAL_LIBS_BUILD_ROOT}}"
export EXTERNAL_LIBS_BUILD_ROOT=${EXTERNAL_LIBS_BUILD_ROOT%/}

DEFAULT_EXTERNAL_LIBS_ROOT=${EXTERNAL_LIBS_BUILD}/build/
EXTERNAL_LIBS_ROOT="${EXTERNAL_LIBS_ROOT:-${DEFAULT_EXTERNAL_LIBS_ROOT}}"
export EXTERNAL_LIBS_ROOT=${EXTERNAL_LIBS_ROOT%/}

mkdir -p $EXTERNAL_LIBS_ROOT $EXTERNAL_LIBS_BUILD_ROOT
