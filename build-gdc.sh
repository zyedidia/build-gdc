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
  rm -rf build-binutils
}

build_gcc1() {
  cd "$WORK_DIR"
  cd gcc
  ./contrib/download_prerequisites
  echo "Edge" > gcc/DEV-PHASE
  cd ../
  mkdir build-gcc1
  cd build-gcc1
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
    --enable-languages=c \
    --enable-multilib \
    --enable-lto \
    --prefix="$PREFIX" \
    --with-gnu-as \
    --with-gnu-ld \
    --without-headers \
    --with-newlib \
    --with-pkgversion="Multiplix-dev"

  make all-gcc -j$(nproc --all)
  make install-gcc -j$(nproc --all)
  echo "Built GCC!"
  cd ..
  rm -rf build-gcc1
}

build_gcc2() {
  cd $WORK_DIR
  mkdir build-gcc2
  cd build-gcc2
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
    --enable-multilib \
    --enable-lto \
    --prefix="$PREFIX" \
    --with-gnu-as \
    --with-gnu-ld \
    --without-headers \
    --with-newlib \
    --with-pkgversion="Multiplix-dev"
  make -j$(nproc --all)
  make install -j$(nproc --all)
  cd ..
  rm -rf build-gcc2
}

build_newlib() {
  cd "$WORK_DIR"
  mkdir build-newlib
  cd build-newlib
  CFLAGS="-DPREFER_SIZE_OVER_SPEED -ffunction-sections -fdata-sections" ../newlib-cygwin/newlib/configure --prefix=$PREFIX --host=$TARGET --target=$TARGET --disable-threads --disable-newlib-io-float
  make -j$(nproc --all)
  make install
  cd ..
  rm -rf build-newlib
}

build_binutils
build_gcc1
build_newlib
build_gcc2
