#!/bin/bash

set -e

echo -e "=> Creating Headers"

mkdir -p build/iso/boot/grub
cp configs/grub.cfg build/iso/boot/grub/grub.cfg
