
# 第9章 中断和动态时钟显示

本部分主要包括一张图，以及关于int3相关的讨论。

## 图1。

包括中断和CMOS－RAM相关信息。以及程序流程图。

![protect_mode](https://github.com/jungle85gopy/x86asm/blob/master/c09/c9.png)


## 关于int3与int 3中断

两者的不同：

软中断指令int有256个中断向量，调用时使用int N。int的操作码是0xCD。故int 3的机器指令则是0xCD03H。

int3是断点中断指令，其机器码是0xCC，只有一个字节。在调试器中使用int3设置断点时，调试器将断点处的指令的第1字节改成0xCCH，即int3指令。原字节则被调试器暂存。当处理器执行到int3时，即发生3号中断。转去执行相应的中断处理程序。

关于两者，我们通过在linux下使用gdb调试来观察。

### 测试一：显式调试int 03
int_03.c 程序代码
```c
#include<stdio.h>

int main()
{
    char name[32] = "int 03!";

    printf("hello  %s", name);
    __asm__("int $0x03");
    printf("hello world!");
    return 0;
}
```

编译并启动调试：
```bash
gcc int_03.c -o int_03
gdb int_03
```

debug调试命令及结果如下：
```gdb
(gdb) r
Starting program: /home/jiang/test/int_03 
Program received signal SIGTRAP, Trace/breakpoint trap.
0x0000000000400561 in main ()

(gdb) info frame
Stack level 0, frame at 0x7fffffffe1b0:
 rip = 0x400561 in main; saved rip 0x7ffff7a54b45
 Arglist at 0x7fffffffe1a0, args: 
 Locals at 0x7fffffffe1a0, Previous frame's sp is 0x7fffffffe1b0
 Saved registers:
  rbp at 0x7fffffffe1a0, rip at 0x7fffffffe1a8

(gdb) x/10i $rip-20
   0x40054d <main+49>:  loopne 0x400597 <__libc_csu_init+23>
   0x40054f <main+51>:  mov    %eax,%esi
   0x400551 <main+53>:  mov    $0x400604,%edi
   0x400556 <main+58>:  mov    $0x0,%eax
   0x40055b <main+63>:  callq  0x400400 <printf@plt>
   0x400560 <main+68>:  int3   
=> 0x400561 <main+69>:  mov    $0x40060e,%edi
   0x400566 <main+74>:  mov    $0x0,%eax
   0x40056b <main+79>:  callq  0x400400 <printf@plt>
   0x400570 <main+84>:  mov    $0x0,%eax
(gdb) 
```

从上可见，int 3被翻译成机器码int3使用了。当执行到int 3指令时，程序计数器rip = 0x400561，是指向int3下面的一条指令。即如上箭头所示。

### 测试二：显式调试int3
int3.c 程序代码
```c
#include<stdio.h>

int main()
{
    char name[32] = "int3!";

    printf("hello  %s", name);
    __asm__("int3");
    printf("hello world!");
    return 0;
}
```

编译并启动调试：
```bash
gcc int3.c -o int3
gdb int3
```

debug调试命令及结果如下：
```gdb
(gdb) r
Starting program: /home/jiang/test/int3 
Program received signal SIGTRAP, Trace/breakpoint trap.
0x0000000000400561 in main ()

(gdb) info frame
Stack level 0, frame at 0x7fffffffe1b0:
 rip = 0x400561 in main; saved rip 0x7ffff7a54b45
 Arglist at 0x7fffffffe1a0, args: 
 Locals at 0x7fffffffe1a0, Previous frame's sp is 0x7fffffffe1b0
 Saved registers:
  rbp at 0x7fffffffe1a0, rip at 0x7fffffffe1a8
(gdb) x/10i $rip-20
   0x40054d <main+49>:  loopne 0x400597 <__libc_csu_init+23>
   0x40054f <main+51>:  mov    %eax,%esi
   0x400551 <main+53>:  mov    $0x400604,%edi
   0x400556 <main+58>:  mov    $0x0,%eax
   0x40055b <main+63>:  callq  0x400400 <printf@plt>
   0x400560 <main+68>:  int3   
=> 0x400561 <main+69>:  mov    $0x40060e,%edi
   0x400566 <main+74>:  mov    $0x0,%eax
   0x40056b <main+79>:  callq  0x400400 <printf@plt>
   0x400570 <main+84>:  mov    $0x0,%eax
(gdb) 

```
如上可见，在源代码中调用汇编时，使用int3与int $0x03效果是一致的。

### 测试三：gdb中设置断点
int_no.c 程序代码
```c
#include<stdio.h>

int main()
{
    char name[32] = "int 03!";

    printf("hello  %s", name);
    printf("hello world!");
    return 0;
}
```

编译并启动调试：
```bash
# 注意，因为程序中没有断点中断，故编译时需要-g参数，以便后继调试。
gcc int_no.c -o int_no -g
gdb int_no 
```

debug调试命令及结果如下：
```gdb
(gdb) b 8 
Breakpoint 1 at 0x400560: file int_no.c, line 8.

(gdb) r
Starting program: /home/jiang/test/int_no 
Breakpoint 1, main () at int_no.c:8
8       printf("hello world!");

(gdb) x/10i $rip-20
   0x40054c <main+48>:  rex.RB loopne 0x400597 <__libc_csu_init+23>
   0x40054f <main+51>:  mov    %eax,%esi
   0x400551 <main+53>:  mov    $0x400604,%edi
   0x400556 <main+58>:  mov    $0x0,%eax
   0x40055b <main+63>:  callq  0x400400 <printf@plt>
=> 0x400560 <main+68>:  mov    $0x40060e,%edi
   0x400565 <main+73>:  mov    $0x0,%eax
   0x40056a <main+78>:  callq  0x400400 <printf@plt>
   0x40056f <main+83>:  mov    $0x0,%eax
   0x400574 <main+88>:  leaveq 
(gdb) info frame
Stack level 0, frame at 0x7fffffffe1a0:
 rip = 0x400560 in main (int_no.c:8); saved rip 0x7ffff7a54b45
 source language c.
 Arglist at 0x7fffffffe190, args: 
 Locals at 0x7fffffffe190, Previous frame's sp is 0x7fffffffe1a0
 Saved registers:
  rbp at 0x7fffffffe190, rip at 0x7fffffffe198
(gdb) 

```

从上所示，在调试器下设置断点后，我们是看不到动态替换到程序中的INT 3指令的。调试器在被调试程序中设置的中断处，先将指令替换成int3，调试中断。再断点位置恢复成原来的指令，然后再把现场交给用户。故int的写入与被替换的整个过程对用户是透明的。

### 补充
CPU执行到INT3时命中断点，产生断点异常，和常规中断一样，先保护现场，再转去执行异常处理例程。该例程由调试器定义。


