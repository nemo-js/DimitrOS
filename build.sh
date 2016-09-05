echo Setting cross compiler path...
export PATH="$HOME/opt/cross/bin:$PATH"

echo compiling boot
i686-elf-as boot.s -o boot.o

echo compiling kernel...
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

echo linking files...
i686-elf-gcc -T linker.ld -o dimitros.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

if grub-file --is-x86-multiboot dimitros.bin; then
  echo multiboot confirmed
  qemu-system-i386 -kernel dimitros.bin
else
  echo the file is not multiboot
fi