#!/bin/bash

./download.sh
./build-gdc.sh aarch64-none-elf
./build-gdc.sh riscv64-unknown-elf
./package.sh
