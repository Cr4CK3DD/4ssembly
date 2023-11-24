
;int MessageBoxA(
;  [in, optional] HWND   hWnd,
;  [in, optional] LPCSTR lpText,
;  [in, optional] LPCSTR lpCaption,
;  [in]           UINT   uType
;)

;void ExitProcess(
;  [in] UINT uExitCode
;)

extern _MessageBoxA@16
extern _printf                        

global _HelloWorld

section .data
	HelloWorld 		db 	'H3110 0xPr1m0!', 0
	Title			db	'H3110', 0
	ErrorMessage	db	'Err0r C0d3: %X', 0

section .text
_HelloWorld:
	; MessageBoxA
	push 	0 
	push 	Title
	push 	HelloWorld
	push 	0
	call 	_MessageBoxA@16
	add		esp, 0x10
	cmp		eax, 0
	je		_Error
	ret

_Error:
	mov		eax, FS:[0x18]
	mov		eax, dword [eax + 0x34]
	push	eax
	push 	ErrorMessage
	call	_printf
	ret

;//0x1000 bytes (sizeof)
;struct _TEB32
;{
;    struct _NT_TIB32 NtTib;                   //0x0
;    ULONG EnvironmentPointer;                 //0x1c
;    struct _CLIENT_ID32 ClientId;             //0x20
;    ULONG ActiveRpcHandle;                    //0x28
;    ULONG ThreadLocalStoragePointer;          //0x2c
;    ULONG ProcessEnvironmentBlock;            //0x30
;    ULONG LastErrorValue;                     //0x34
;	.
;	.
;	.
;}




