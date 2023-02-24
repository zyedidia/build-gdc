#!/bin/bash

TOOLCHAIN=multiplix-toolchain-linux-amd64
mkdir $TOOLCHAIN
mv gnu-aarch64-none-elf $TOOLCHAIN
mv gnu-riscv64-unknown-elf $TOOLCHAIN
mv ldc2 $TOOLCHAIN
mv bin $TOOLCHAIN

tar -czf $TOOLCHAIN.tar.gz $TOOLCHAIN
