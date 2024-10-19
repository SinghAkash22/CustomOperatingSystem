.set MAGIC, 0x1badb002
.set FLAGS, (1<<0 | 1<<1)
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
    .long MAGIC
    .long FLAGS
    .long CHECKSUM

.section .text
.extern kernelMain
.extern callConstructors
.global loader

loader:
    # Set up the stack pointer
    mov $kernel_stack, %esp

    call callConstructors

    push %eax
    push %ebx
    # Call the kernel main function
    call kernelMain

_stop:
    # Disable interrupts
    cli

    # Halt the CPU
    hlt

    # Infinite loop to stop execution
    jmp _stop

.section .bss
    # Allocate 2 MiB for the kernel stack
.space 2*1024*1024
kernel_stack:
