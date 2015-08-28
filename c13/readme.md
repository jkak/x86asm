
## 第13章 程序的动态加载和执行

### 运行脚本

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


### 附图

本章附图如下:

CPU与内存分布图。增加了核心程序与用户程序的头部数据结构。并对应其在内存中的GDT表项。

程序流程图，包括了引导程序，核心程序及用户程序的执行过程。


![protect_mode](https://github.com/jungle85gopy/x86asm/blob/master/c13/c13.png)


