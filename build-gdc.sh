#!/usr/bin/env bash
set -e

if [ "$#" -ne 1 ]; then
    echo "usage: $0 TARGET"
    exit 1
fi

TARGET=$1

TARGET_CONFIG=
if [ $1 == "riscv64-unknown-elf" ]; then
    TARGET_CONFIG=--with-multilib-generator='rv64imac-lp64--;--cmodel=medany'
fi

export WORK_DIR="$PWD"
export PREFIX="$WORK_DIR/gnu-$TARGET"
export PATH="$PREFIX/bin:$PATH"
export OPT_FLAGS="-O3 -pipe -ffunction-sections -fdata-sections"

download_resources() {
  git clone git://sourceware.org/git/binutils-gdb.git -b master binutils --depth=1
  git clone git://gcc.gnu.org/git/gcc.git -b master gcc --depth=1
}


build_binutils() {
  cd "$WORK_DIR"
  mkdir build-binutils
  cd build-binutils
  env CFLAGS="$OPT_FLAGS" CXXFLAGS="$OPT_FLAGS" \
  ../binutils/configure --target=$TARGET \
    --disable-docs \
    --disable-nls \
    --disable-werror \
    --enable-gold \
    --prefix="$PREFIX" \
    --with-pkgversion="Multiplix-dev"
  make -j$(nproc --all)
  make install -j$(nproc --all)
  cd ../
}

build_gcc() {
  cd "$WORK_DIR"
  cd gcc
  ./contrib/download_prerequisites
  echo "Edge" > gcc/DEV-PHASE
  cd ../
  mkdir build-gcc
  cd build-gcc
  env CFLAGS="$OPT_FLAGS" CXXFLAGS="$OPT_FLAGS" \
  ../gcc/configure --target=$TARGET \
    $TARGET_CONFIG \
    --disable-decimal-float \
    --disable-docs \
    --disable-gcov \
    --disable-libffi \
    --disable-libgomp \
    --disable-libmudflap \
    --disable-libquadmath \
    --disable-libstdcxx-pch \
    --disable-nls \
    --disable-shared \
    --disable-threads \
    --enable-languages=c,c++,d \
    --prefix="$PREFIX" \
    --with-gnu-as \
    --with-gnu-ld \
    --without-headers \
    --with-newlib \
    --with-pkgversion="Multiplix-dev"

  make all-gcc -j$(nproc --all)
  make all-target-libgcc -j$(nproc --all)
  make install-gcc -j$(nproc --all)
  make install-target-libgcc -j$(nproc --all)
  echo "Built GCC!"
}

download_resources
build_binutils
build_gcc