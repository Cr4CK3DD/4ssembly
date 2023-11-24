nasm -fwin32 BindShell.asm
link BindShell.obj /subsystem:console /out:BindShell.exe msvcrt.lib user32.lib kernel32.lib legacy_stdio_definitions.lib ws2_32.lib
