global _ZeroMemoryEx


section .text

_ZeroMemoryEx:
	push 	ebp
	mov		ebp, esp
	sub		esp, 4

	mov		dword [ebp-4], 0	; Local  Variable.
	mov		ecx, dword [ebp+12]	; First  Argument: Size.
	mov		ebx, dword [ebp+8]	; Second Argument: String Address.
_Loop:
	cmp 	ecx, dword [ebp-4]
	jz 		_Return
	mov		edx, dword [ebp-4]
	mov		byte [ebx+edx], 0x0
	add		dword [ebp-4], 1
	jmp		_Loop

_Return:
	add		esp, 4
	pop		ebp
	ret
