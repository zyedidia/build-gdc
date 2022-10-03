#!/bin/bash

# Usage: build.sh TARGET
# Example: build.sh aarch64-none-elf

set -e

TARGET=$1
PREFIX=build-$TARGET
VERSION=$(gcc -dumpfullversion)

cd build-gcc

./build-newlib.sh --enable-languages=d --target=$TARGET --prefix=$PWD/$PREFIX gcc-$VERSION
