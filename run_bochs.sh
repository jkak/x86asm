#########################################################################
# File Name: run_bochs.sh
# Author: jungle85gopy
#########################################################################
#!/bin/bash

if [ $# -ne 1 ];then
    echo -e "usage: \n\t$0 file_source.asm\n"
    exit 1
fi

# disk c img
nasm -f bin $1 -o c.bin
echo ""

dd if=c.bin of=c.img bs=512 count=4 conv=notrunc
echo ""

bochs 

