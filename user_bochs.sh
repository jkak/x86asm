#########################################################################
# File Name: user_bochs.sh
# Author: jungle85gopy
#########################################################################
#!/bin/bash

if [ $# -ne 2 ];then
    echo -e "usage: \n\t$0 mbr_src.asm  user_src.asm\n"
    exit 1
fi

# disk c img
nasm -f bin $1 -o c.bin
echo ""

dd if=c.bin    of=c.img bs=512 count=1 conv=notrunc


# user img
nasm -f bin $2 -o user.bin

echo ""
dd if=user.bin of=c.img bs=512 count=40 seek=100  conv=notrunc

bochs 

