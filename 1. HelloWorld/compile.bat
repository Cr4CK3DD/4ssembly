cl /c main.c
nasm -fwin32 HelloWorld.asm 
link HelloWorld.obj main.obj /subsystem:console /out:hello.exe msvcrt.lib user32.lib kernel32.lib legacy_stdio_definitions.lib
cls