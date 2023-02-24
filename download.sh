#!/bin/bash

# binutils
git clone git://sourceware.org/git/binutils-gdb.git -b master binutils --depth=1

# gcc
git clone git://gcc.gnu.org/git/gcc.git -b master gcc --depth=1

# newlib
git submodule update --init

# ldc
LDC=ldc2-1.30.0-linux-x86_64
wget https://github.com/ldc-developers/ldc/releases/download/v1.30.0/$LDC.tar.xz
tar -xf $LDC.tar.xz
mv $LDC ldc2
rm $LDC.tar.gz

# dscanner
wget www.scs.stanford.edu/~zyedidia/dscanner.tar.gz
tar xf dscanner.tar.gz
mkdir bin
mv dscanner bin
rm dscanner.tar.gz
