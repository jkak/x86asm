
## 第8章 磁盘与显卡的访问控制

本章实现的程序，将在后面各章中使用到。主要包括从磁盘读一个扇区子程序，
以及加载一个用户程序的loader程序。另外包括一个经常用来显示一个字符串的程序put_string。

程序的编译使用user_bochs.sh脚本。参考上级目录的README.MD文件。

cd x86asm && ./user_bochs.sh c08/c08_mbr.asm  c08/c08.asm


### 图1。

包括CPU关键寄存器与南桥主要接口。并整理了CPU的端口读写方式，以及磁盘接口的端口。
并给出了加载程序与用户程序的头部接口。

![protect_mode](https://github.com/jkak/x86asm/blob/master/c08/c8_1.png)

### 图2。

主要是两个程序的流程图。一是MBR程序流程图，包括读磁盘扇区子程序，并给出了LBA相关端口信息。

二是用户程序的执行流程。内部通过retf实现了代码段的转移。put_char子程序参考教材。

![protect_mode](https://github.com/jkak/x86asm/blob/master/c08/c8_2.png)

