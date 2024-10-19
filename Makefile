
GPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o gdt.o kernel.o

%.o:%.cpp
	g++ $(GPPARAMS) -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@  $(objects)

install:mykernel.bin
	sudo cp $< /boot/mykernel.bin

mykernel.iso :mykernel.bin
	# we create dirtectiry in iso and put kernel.bin in required folder
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	cp $< iso/boot/
	echo 'set timeout = 0' >> iso/boot/grub/grub.cfg
	echo 'set default = 0' >> iso/boot/grub/grub.cfg
	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "My Operating system " {' >> iso/boot/grub/grub.cfg
	echo ' multiboot /boot/mykernel.bin' >> iso/boot/grub/grub.cfg
	echo ' boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	# grub-mkrescue is a command-line tool used to create a bootable ISO image with GRUB as the bootloader. Here’s a detailed breakdown of this line:
	grub-mkrescue --output=$@ iso
	rm -rf iso


.PHONY: clean
clean:
	rm -f $(objects) mykernel.bin