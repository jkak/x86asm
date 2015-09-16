#!/bin/bash
#########################################################################
# File Name: run.sh
# Author: 
# mail: 
#########################################################################


# nasm to bin

## mbr
nasm -f bin c17/c17_mbr.asm  -o c.bin

# core
nasm -f bin c17/c17_core.asm  -o core.bin

# user
nasm -f bin c17/c17_1.asm  -o user1.bin
nasm -f bin c17/c17_2.asm  -o user2.bin


# dd to c.img

## mbr
dd if=c.bin     of=c.img bs=512          conv=notrunc

## core
dd if=core.bin  of=c.img bs=512 seek=1   conv=notrunc

## user
dd if=user1.bin of=c.img bs=512 seek=50  conv=notrunc
dd if=user2.bin of=c.img bs=512 seek=100 conv=notrunc


bochs

