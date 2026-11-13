.global _start

.section .text
_start:
  mov $1, %rax ; sys write
  mov $1, %rdi ; fd
  lea msg(%rip), %rsi ; buf
  mov $msg_len, %rdx
  syscall

  mov $0x3c, %rax ; sys exit
  mov $0, %rdi    ; code 0
  syscall

.section .data
msg: .ascii "Hello, world!\n"
msg_len = . - msg
