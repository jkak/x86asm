
## 第15章 任务切换

运行如下步骤，或者直接在x86asm目录下执行./c15/run.sh。

### 运行脚本

```bash

# nasm to bin

## mbr
nasm -f bin c13/c13_mbr.asm  -o c.bin

# core
nasm -f bin c15/c15_core.asm  -o core.bin

# user
nasm -f bin c15/c15.asm  -o user.bin


# dd to c.img

## mbr
dd if=c.bin    of=c.img bs=512 count=0 conv=notrunc

## core
dd if=core.bin of=c.img bs=512 count=49 seek=1  conv=notrunc

## user
dd if=user.bin of=c.img bs=512 count=50 seek=50  conv=notrunc


bochs

```


### 附图

本章附图由于太大，分为两部分。另外，本章的程序和前一章整体是相似的，
只是在部分细节上有所改变。但这也更新了程序的流程图。
主要包括核心程序调用用户程序的方式，以及用户程序本身只输出，未再读程序数据。

#### CPU与内存分布图。

包括CPU关键寄存器，内存中的内核段及用户段，重点给出了GDT与LDT中的描述符项，保留了核心程序与用户程序的头部数据结构。并增加了用户程序的TCB结构和TSS结构。

![protect_mode](https://github.com/jungle85gopy/x86asm/blob/master/c15/c15_1.png)

#### 程序流程图

包括了引导程序，核心程序及用户程序的执行过程。并将内核的load_relocate_program函数的流程独立出来。

![protect_mode](https://github.com/jungle85gopy/x86asm/blob/master/c15/c15_2.png)

