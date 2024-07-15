#!/bin/bash

set -e

echo -e "=> Launching QEMU"

qemu-system-x86_64 -cdrom Byte64.iso
