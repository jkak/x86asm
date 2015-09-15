#!/bin/bash
#########################################################################
# File Name: run.sh
# Author: 
# mail: 
#########################################################################


# nasm to bin

## mbr
nasm -f bin c13/c13_mbr.asm  -o c.bin

# core
nasm -f bin c16/c16_core.asm  -o core.bin

# user
nasm -f bin c16/c16.asm  -o user.bin


# dd to c.img

## mbr
dd if=c.bin    of=c.img bs=512          conv=notrunc

## core
dd if=core.bin of=c.img bs=512 seek=1   conv=notrunc

## user
dd if=user.bin of=c.img bs=512 seek=50  conv=notrunc


bochs

