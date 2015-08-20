# x86asm

learn x86 asm from real mode to protect mode.

# 说明
本项目是学习李忠的《X86汇编语言 从实模式到保护模式》一书的笔记和代码。重点是测试和运行代码。

# 学习环境
本次学习环境是基于vmware上的linux。并在linux中使用bochs。因此没有使用书中作者提供的工具。至于写汇编代码到磁盘文件，则直接使用linux的dd命令。参见环境搭建部分。

> * 系统：　debian
> * 汇编器：nasm 2.11.05
> * 模拟器：bochs 2.6.8


## 搭建环境
生成磁盘文件供bochs使用。
```bash
# gen c.img
bximage 
# 1  #ENTER for create disk image
# ENTER hd default 
# ENTER flat defalt
# ENTER 10MB defalt
# ENTER c.img defalt

# The following line should appear in your bochsrc:
#  ata0-master: type=disk, path="c.img", mode=flat
```

bochs启动脚本: run_bochs.sh
bochs配置文件: bochsrc

有如上配置后，当写好一个引导文件mbr.asm，命令：
```bash
./run_bochs.sh mbr.asm
```
即可启动测试。



## 第八章编译过程

本章因为有两个文件，并且用户程序需要加载到100号硬盘文件的扇区。
因此编写一个新的脚本来完成这个工作。脚本需要两个参数。分别是mbr代码，做为加载器。
另一个是被加载的用户程序。user_bochs.sh脚本如下：

```bash
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
# 通过seek=100来指定写放需要跳过的扇区数。

bochs

```

此脚本，第九章也可以使用。


## 第十三章编译过程

## 运行脚本
```bash

# nasm to bin

## mbr
nasm -f bin c13/c13_mbr.asm  -o c.bin

# core
nasm -f bin c13/c13_core.asm  -o core.bin

# user
nasm -f bin c13/c13.asm  -o user.bin


# dd to c.img

## mbr
dd if=c.bin    of=c.img bs=512 count=0 conv=notrunc

## core
dd if=core.bin of=c.img bs=512 count=10 seek=1  conv=notrunc

## user
dd if=user.bin of=c.img bs=512 count=10 seek=50  conv=notrunc

## disk data
dd if=./c13/diskdata.txt of=c.img bs=512 count=10 seek=100  conv=notrunc

bochs

```


