
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

