.global _start

.section .text
_start:
  ; get argc in rax
  mov 0(%rsp), %rax
  mov %rsp, %rsi

  ; %rdi == 0
  xor %rdi, %rdi
loop:
  cmp %rax, %rdi
  ja  end_loop
  je  end_loop

  push %rax
  push %rdi
  push %rsi
  
  mov $1, %rax ; sys_write
  mov 8(%rsi,%rdi,8), %rsi
  mov $1, %rdi
  ; compute length
  xor %rdx, %rdx
_len:
  cmpb $0, 0(%rsi,%rdx,1)
  je end_len
  inc %rdx
  jmp _len
end_len:
  syscall

  ; new line
  mov $1, %rax
  mov $1, %rdi
  lea nl(%rip), %rsi
  mov $1, %rdx
  syscall
  
  pop %rsi
  pop %rdi
  pop %rax

  inc %rdi
  jmp  loop
end_loop:

  mov $0x3c, %rax ; sys exit
  mov $0, %rdi    ; code 0
  syscall

.section .data
nl: .ascii "\n"
