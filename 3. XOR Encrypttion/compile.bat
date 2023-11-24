cl.exe /c main.c
nasm -fwin32 XOR.asm
link XOR.obj main.obj  /subsystem:console /out:XOR.exe msvcrt.lib user32.lib kernel32.lib legacy_stdio_definitions.lib
