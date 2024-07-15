#!/bin/bash

set -e

echo -e "=> Generating ISO Image"

grub-mkrescue /usr/lib/grub/i386-pc build/iso -o Byte64.iso
