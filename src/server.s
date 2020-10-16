info:
  push rbp
  mov rbp, rsp

  mov r9, [rdi]
  mov [pKuzzle], r9

  mov rax, 1
  mov rdi, [pKuzzle + socket]
  mov rdx, len_request
  mov rsi, request
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
