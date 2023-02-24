#!/bin/bash

mkdir multiplix-toolchain
mv gnu-aarch64-none-elf multiplix-toolchain
mv gnu-riscv64-unknown-elf multiplix-toolchain
mv ldc2 multiplix-toolchain
mv bin multiplix-toolchain

tar -czf multiplix-toolchain.tar.gz multiplix-toolchain
