#!/bin/bash

# nasm to bin

## mbr
nasm -f bin c13/c13_mbr.asm  -o c.bin

# core
nasm -f bin c15/c15_core.asm  -o core.bin

# user
nasm -f bin c15/c15.asm  -o user.bin


# dd to c.img

## mbr
dd if=c.bin    of=c.img bs=512 count=1 conv=notrunc

## core
dd if=core.bin of=c.img bs=512 count=49 seek=1  conv=notrunc

## user
dd if=user.bin of=c.img bs=512 count=50 seek=50  conv=notrunc

bochs

