bits 64
default rel

; Core
global kuzzle:function
global connect:function
global query:function

; Server
global info:function

; Document
global search:function

struc kuzzle_s
  socket: resd 1
  host: resd 1
  port: resd 1
  server_struct: resb 16
endstruc

section .data
  request: db "%s /%s/%s/%s HTTP/1.1", 0xa, 0xa, 0
  post: db "POST", 0
  get: db "GET", 0
  query_search: db "_search", 0
  len_request: equ $-request
  response_len: equ 512512

section .bss
  pKuzzle: resd 1
  response: resb response_len
  str: resb 1024
  
section .text
extern malloc
extern sprintf

kuzzle:
  push rbp
  mov rbp, rsp
  
  push rdi
  push rsi

  xor rax, rax
  mov edi, kuzzle_s_size
  call malloc wrt ..plt
  mov [pKuzzle], rax

  pop rdi
  pop rsi
  mov [pKuzzle + host], rsi
  mov [pKuzzle + port], rdi

  mov rax, pKuzzle

  mov rsp, rbp
  pop rbp

ret

connect:
  push rbp
  mov rbp, rsp

  mov [pKuzzle], rdi

  mov rdx, 0
  mov rsi, 1
  mov rdi, 2
  mov rax, 41
  syscall ; sys_socket
  cmp rax, 0
  jle socket_error

  mov [pKuzzle + socket], rax

  mov word [pKuzzle + server_struct], 0x2
  mov ebx, [pKuzzle + host]
  mov dword [pKuzzle + server_struct + 4], ebx
  mov rax, [pKuzzle + port]
  mov word [pKuzzle + server_struct + 2], ax
  mov rdx, 0x10
  lea rsi, [pKuzzle + server_struct]
  mov rdi, [pKuzzle + socket]
  mov rax, 42
  syscall ; sys_connect

  mov rax, 0

  mov rsp, rbp
  pop rbp
ret

query:
  push rbp
  mov rbp, rsp

  ; rdi: Kuzzle*
  ; rsi: verb
  ; rdx: action
  ; rcx: index
  ; r8: collection

  mov r9, [rdi]
  mov [pKuzzle], r9

  mov r9, rdx
  mov rdx, rsi
  mov rsi, request
  mov rdi, str
  call sprintf wrt ..plt

  mov rax, 1
  mov rdi, [pKuzzle + socket]
  mov rdx, len_request
  mov rsi, str
  syscall ; sys_write

  mov rax, 0
  mov rdi, [pKuzzle + socket]
  mov rdx, response_len
  mov rsi, response
  syscall ; sys_read

  mov rax, response

  mov rsp, rbp
  pop rbp
ret

socket_error:
  mov rax, -1
ret

%include "server.s"
%include "document.s"