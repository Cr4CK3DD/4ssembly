global _XOR

section .text


_XOR:
	push 	ebp
	mov		ebp, esp
	sub		esp, 4

	mov		dword [ebp-4], 0	; Local  Variable.	
_Loop:
	mov		edx, dword [ebp-0x4]
	mov		ecx, dword [ebp+0x0C]
	cmp 	ecx, edx
	jz 		_Return
	mov		eax, dword [ebp-0x4]
	mov		ecx, dword [ebp+0x14]
	xor		edx, edx
	div		ecx
	xor		ebx, ebx
	mov		ebx, dword [ebp+0x10]
	mov 	cl, byte [ebx+edx]
	mov		edx, dword [ebp-0x4]
	xor		ebx, ebx
	mov		ebx, dword [ebp+0x8]
	xor		byte [ebx+edx], cl
	add		dword [ebp-0x4], 1
	jmp		_Loop

_Return:
	add		esp, 4
	pop		ebp
	ret
