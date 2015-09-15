
## 第16章 分布机制和动态页面分配

### 运行脚本
运行如下步骤，或者直接在x86asm目录下执行./c16/run.sh。

```bash

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
# 注意：因为c16.asm程序中保留了256*500字节的空间，
# 相当于约256个扇区，因此在使用dd时，如果带count参数，
# 则需要设置得足够大，或者不带此参数

bochs

```

### 附图

本章附图由于太大，分为3部分。另外，本章的程序和前一章整体是相似的，
只是在部分细节上有所改变。但这也更新了程序的流程图。
主要包括核心程序调用用户程序的方式，以及用户程序本身只输出，未再读程序数据。

#### 内存分布图。

包括内存中的内核段及用户段，重点给出了GDT与LDT中的描述符项，TSS, TCB等数据结构核心程序与用户程序的头部数据结构。
以及页目录和页表。

![protect_mode](https://github.com/jungle85gopy/x86asm/blob/master/c16/c16_1.png)

#### 程序流程图

省略了引导程序，重点给出了核心程序及用户程序的执行过程。并将内核的load_relocate_program函数的流程独立出来。

![protect_mode](https://github.com/jungle85gopy/x86asm/blob/master/c16/c16_2.png)


#### 关于分页机制
单独总结了分页机制的工作过程，以及程序中，使用内核页目录临时生成用户程序的页目录，及其复制过程的说明。

![protect_mode](https://github.com/jungle85gopy/x86asm/blob/master/c16/c16_table.png)

