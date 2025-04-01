section .data
    menu_msg db "Escolha a operacao:", 10
             db "1 - Soma", 10
             db "2 - Subtracao", 10
             db "3 - Multiplicacao", 10
             db "4 - Divisao", 10
             db "Opcao: ", 0
    num1_msg db "Digite o primeiro numero: ", 0
    num2_msg db "Digite o segundo numero: ", 0
    result_msg db "Resultado: ", 0
    erro_div_msg db "Erro: Divisao por zero!", 10, 0
    newline db 10, 0
    ten dq 10
    clear_screen db 27, "[2J", 27, "[H", 0

section .bss
    opt resb 2
    num1 resb 16
    num2 resb 16
    result_str resb 16

section .text
global _start

; --------------------------------------------------------
; Função print_string
; --------------------------------------------------------
print_string:
    push rsi
    xor rdx, rdx
.loop:
    mov al, [rsi + rdx]
    test al, al
    jz .done
    inc rdx
    jmp .loop
.done:
    mov rax, 1
    mov rdi, 1
    pop rsi
    syscall
    ret

; --------------------------------------------------------
; Função read_string
; --------------------------------------------------------
read_string:
    mov rax, 0
    mov rdi, 0
    mov rdx, 16
    syscall
    ret

; --------------------------------------------------------
; Função str_to_int
; --------------------------------------------------------
str_to_int:
    xor rax, rax
    xor rcx, rcx
.loop:
    movzx rdx, byte [rsi + rcx]
    test rdx, rdx
    jz .done
    cmp rdx, 10
    je .done
    sub rdx, '0'
    imul rax, rax, 10
    add rax, rdx
    inc rcx
    jmp .loop
.done:
    ret

; --------------------------------------------------------
; Função int_to_str
; --------------------------------------------------------
int_to_str:
    mov rsi, result_str
    add rsi, 15
    mov byte [rsi], 0
    dec rsi
    test rax, rax
    jnz .loop
    mov byte [rsi], '0'
    ret
.loop:
    xor rdx, rdx
    div qword [ten]
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .loop
    inc rsi
    ret

; --------------------------------------------------------
; Função exit
; --------------------------------------------------------
exit:
    mov rsi, clear_screen
    call print_string
    mov rax, 60
    xor rdi, rdi
    syscall
    ret

; --------------------------------------------------------
; Função ler_numeros
; --------------------------------------------------------
ler_numeros:
    mov rsi, num1_msg
    call print_string
    mov rsi, num1
    call read_string
    mov rsi, num1
    call str_to_int
    mov rbx, rax

    mov rsi, num2_msg
    call print_string
    mov rsi, num2
    call read_string
    mov rsi, num2
    call str_to_int
    mov rcx, rax
    ret

; --------------------------------------------------------
; Operação: Soma
; --------------------------------------------------------
soma:
    call ler_numeros
    add rbx, rcx
    jmp resultado

; --------------------------------------------------------
; Operação: Subtração
; --------------------------------------------------------
subtracao:
    call ler_numeros
    sub rbx, rcx
    jmp resultado

; --------------------------------------------------------
; Operação: Multiplicação
; --------------------------------------------------------
multiplicacao:
    call ler_numeros
    mov rax, rbx
    imul rax, rcx
    mov rbx, rax
    jmp resultado

; --------------------------------------------------------
; Operação: Divisão
; --------------------------------------------------------
divisao:
    call ler_numeros
    test rcx, rcx
    jz .erro_divisao
    mov rax, rbx
    xor rdx, rdx
    div rcx
    mov rbx, rax
    jmp resultado
.erro_divisao:
    mov rsi, erro_div_msg
    call print_string
    call read_string
    jmp _start

; --------------------------------------------------------
; Exibir resultado
; --------------------------------------------------------
resultado:
    mov rsi, result_msg
    call print_string
    mov rax, rbx
    call int_to_str
    call print_string
    call read_string
    mov rsi, clear_screen
    call print_string
    jmp _start

; --------------------------------------------------------
; Ponto de entrada
; --------------------------------------------------------
_start:
    mov rsi, menu_msg
    call print_string
    mov rsi, opt
    call read_string
    mov al, byte [opt]
    cmp al, '1'
    je soma
    cmp al, '2'
    je subtracao
    cmp al, '3'
    je multiplicacao
    cmp al, '4'
    je divisao
    call exit
