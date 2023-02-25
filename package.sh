#!/bin/bash

set -e

tar -czf gnu-aarch64-none-elf-linux-amd64.tar.gz gnu-aarch64-none-elf
tar -czf gnu-riscv64-unknown-elf-linux-amd64.tar.gz gnu-riscv64-unknown-elf

TOOLCHAIN=multiplix-toolchain-linux-amd64
mkdir $TOOLCHAIN
mv gnu-aarch64-none-elf $TOOLCHAIN
mv gnu-riscv64-unknown-elf $TOOLCHAIN
mv ldc2 $TOOLCHAIN
mv bin $TOOLCHAIN

tar -czf $TOOLCHAIN.tar.gz $TOOLCHAIN
