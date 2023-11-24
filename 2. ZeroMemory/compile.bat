cl /c main.c
nasm -fwin32 ZeroMemoryEx.asm 
link ZeroMemoryEx.obj main.obj /subsystem:console /out:ZeroMemoryEx.exe msvcrt.lib user32.lib kernel32.lib legacy_stdio_definitions.lib
