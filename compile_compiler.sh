
nasm -f elf compiler.asm
ld -m elf_i386 compiler.o -o compiler
