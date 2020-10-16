bits 64

struc sKuzzle
  a: resq 1
  b: resq 1
  c: resq 1
endstruc

section .data
  Kuzzle:
    istruc sKuzzle
    iend
  fmt: db "%d", 10, 0

section .text
extern printf
global main

main:
  push rbp
  mov rbp, rsp

  mov eax, 7
  mov dword [Kuzzle + a], eax
  mov eax, 8
  mov dword [Kuzzle + b], eax
  mov eax, 9
  mov dword [Kuzzle + c], eax

  mov esi, [Kuzzle + a]
  mov edi, fmt
  mov eax, 0
  call printf

  mov esi, [Kuzzle + b]
  mov edi, fmt
  mov eax, 0
  call printf

  mov esi, [Kuzzle + c]
  mov edi, fmt
  mov eax, 0
  call printf

  add esp, 8

  mov ebx, 0
  mov eax, 1
  int 0x80

  mov rsp, rbp
  pop rbp

ret