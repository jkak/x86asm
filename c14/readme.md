
## 第14章 任务与特权级保护


### 运行脚本
执行如下步骤，或者在x86asm目录执行 ./c14/run.sh脚本。

```bash

# nasm to bin

## mbr
nasm -f bin c13/c13_mbr.asm  -o c.bin

# core
nasm -f bin c14/c14_core.asm  -o core.bin

# program of user, use c13/c13.asm
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

```


### 附图

本章附图由于太大，分为两部分：

#### CPU与内存分布图。

包括CPU关键寄存器，内存中的内核段及用户段，重点给出了GDT与LDT中的描述符项，保留了核心程序与用户程序的头部数据结构。并增加了用户程序的TCB结构和TSS结构。

![protect_mode](https://github.com/jkak/x86asm/blob/master/c14/c14_1.png)

#### 程序流程图

包括了引导程序，核心程序及用户程序的执行过程。并将内核的load_relocate_program函数的流程独立出来。

![protect_mode](https://github.com/jkak/x86asm/blob/master/c14/c14_2.png)

#### 关于RPL的讨论
最后是关于RPL相关的讨论。

![protect_mode](https://github.com/jkak/x86asm/blob/master/c14/c14_RPL.png)

