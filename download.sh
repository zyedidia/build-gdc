#!/bin/bash

set -e

# binutils
BINUTILS=binutils-2.40
wget https://ftp.gnu.org/gnu/binutils/$BINUTILS.tar.xz
tar -xf $BINUTILS.tar.xz
mv $BINUTILS binutils
rm $BINUTILS.tar.xz

# newlib
NEWLIB=newlib-4.3.0.20230120
wget ftp://sourceware.org/pub/newlib/$NEWLIB.tar.gz
tar -xf $NEWLIB.tar.gz
mv $NEWLIB newlib
rm $NEWLIB.tar.gz

# gcc
GCC=gcc-13.1.0
wget https://gcc.gnu.org/pub/gcc/releases/gcc-13.1.0/$GCC.tar.xz
tar -xf $GCC.tar.xz
mv $GCC gcc
rm $GCC.tar.xz

# ldc
LDC=ldc2-1.32.1-linux-x86_64
wget https://github.com/ldc-developers/ldc/releases/download/v1.32.1/$LDC.tar.xz
tar -xf $LDC.tar.xz
mv $LDC ldc2
rm $LDC.tar.xz

# dscanner
wget www.scs.stanford.edu/~zyedidia/dscanner.tar.gz
tar xf dscanner.tar.gz
mkdir bin
mv dscanner bin
rm dscanner.tar.gz
