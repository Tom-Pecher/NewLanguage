
nasm -f elf64 add.asm -o add.o
ld add.o -o add
./add
echo "$?"
