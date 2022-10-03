#!/bin/bash

# Usage: build.sh TARGET
# Example: build.sh aarch64-none-elf

set -e
set -x

TARGET=$1
PREFIX=$PWD/gnu-$TARGET
VERSION=$($CC -dumpfullversion)

cd build-gcc

./build-newlib.sh --enable-languages=d --target=$TARGET --prefix=$PREFIX gcc-$VERSION

cd ..

tar czf gnu-$TARGET.tar.gz gnu-$TARGET
