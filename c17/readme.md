
## 第17章 中断和异常的处理与抢占式多任务

### 运行脚本
直接在x86asm目录下执行./c17/run.sh。


### 附图

本章附图由于太大，分为3部分。另外，需要注意，本章的程序各部分因为都改成了平坦模式，故多有细部的改动。

#### 内存分布图。

包括内存中的内核段及用户段，重点给出了GDT与LDT中的描述符项，内核、用户的TSS, TCB等数据结构，核心程序与用户程序的头部数据结构。以及页目录和页表等。

![protect_mode](https://github.com/jkak/x86asm/blob/master/c17/c17_1.png)

#### 程序流程图

完善了新的引导程序，重点给出了核心程序及用户程序的执行过程。并将内核的load_relocate_program函数的流程独立出来，此函数也有所更新。

![protect_mode](https://github.com/jkak/x86asm/blob/master/c17/c17_2.png)


#### 关于各类门描述符
单独整理了一下X86的各类门描述符，以及GDT，LDT，TSS等。统一到一起以便了解其全貌。


![protect_mode](https://github.com/jkak/x86asm/blob/master/c17/c17_gate.png)

