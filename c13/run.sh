#!/bin/bash

cd ../

# nasm to bin

## mbr
nasm -f bin c13/c13_mbr.asm  -o c.bin

# core
nasm -f bin c13/c13_core.asm  -o core.bin

# user
nasm -f bin c13/c13.asm  -o user.bin


# dd to c.img

## mbr
dd if=c.bin    of=c.img bs=512 count=1 conv=notrunc

## core
dd if=core.bin of=c.img bs=512 count=49 seek=1  conv=notrunc

## user
dd if=user.bin of=c.img bs=512 count=50 seek=50  conv=notrunc

## disk data
dd if=./c13/diskdata.txt of=c.img bs=512 count=10 seek=100  conv=notrunc

bochs

cd -
