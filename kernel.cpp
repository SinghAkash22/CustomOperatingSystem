#include "types.h"
#include "gdt.h";
void printf(char * str)
{
    // pointer to memory location
    // short unisigned location it point 2 byte color byte and value byte
    static uint16_t *  VideoMemory = (uint16_t *)0xb8000;
    // bring content of that location
    for (int i = 0; str[i] != '\0'; ++i)
    {
        // unchnage higher byte(color byte) and put str index value to lower (value byte) 
        VideoMemory[i] = (VideoMemory[i] & 0xFF00) | str[i];
    }
    
}
typedef void (*constructor)();
extern "C" constructor start_ctors;
extern "C" constructor end_ctors;
extern "C" void callConstructors()
{
    for(constructor* i = &start_ctors; i != &end_ctors; i++)
    {
        (*i)();
    }
}

// extern is to say to gcc not to change function name in .o file
extern "C" void kernelMain(void* multiboot_structure, uint32_t magicnumber)
{
    printf("Hello world akash aman singh it is your computer");
    GlobalDescriptorTable gdt;
    while (1);
    
}