#!/bin/bash

set -e

CC="gcc"
CFLAGS="-c -I kernel/include -ffreestanding"
LD="ld"
LDFLAGS="-n"
ASM="nasm"
ASMFLAGS="-f elf64"

echo -e "=> Compiling C Source Files"

# Take all the .c source files from kernel directory
# Extract the base_name e.g. foo from foo.c
# Compile that file to generate foo.o and put it into build directory
for file in kernel/*.c; do
    base_name=$(basename "$file" .c)
    $CC $CFLAGS "$file" -o "build/$base_name.o"
    echo "    CC     $file"
done

echo -e "=> Assembling Source Files"

# Take all the .asm source files from x86_64 directory
# Extract the base_name e.g. foo from foo.asm
# Compile that file to generate foo-asm.o and put it into build directory
for file in x86_64/*.asm; do
    base_name=$(basename "$file" .asm)
    $ASM $ASMFLAGS "$file" -o "build/$base_name-asm.o"
    echo "    ASM    $file"
done

echo -e "=> Linking Object Files"

# Link all the .o files in the build directory
$LD -T linker.ld -o build/iso/boot/kernel.bin build/*.o
