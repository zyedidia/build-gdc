#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "usage: $0 TARGET HOST"
    exit 1
fi

TARGET=$1
HOST=$2

mkdir newlib-$TARGET
cd newlib-$TARGET
CC=$TARGET-gcc CFLAGS="-DPREFER_SIZE_OVER_SPEED" ../newlib-cygwin/newlib/configure --host=$HOST --target=$TARGET --disable-newlib-io-float
make -j$(nproc --all)

mkdir include
cp -r ../newlib-cygwin/newlib/libc/include ./include/libc
