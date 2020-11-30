
section .data
    delim db " ", 10, 0
    format_string db "%s", 10, 0

section .bss
    root resd 1

section .text

extern printf
extern strtok
extern evaluate_ast
global create_tree
global iocla_atoi

iocla_atoi: 
    ; TODO
    ret


create_tree:
    ; TODO
    enter   0, 0

    push delim
    push eax
    call strtok
    add esp, 8

strtok_delimitation: ; extracting all the operators and the operands
    cmp eax, 0
    je end
    push eax
    push format_string
    call printf
    add esp, 8
    push delim
    push 0
    call strtok
    add esp, 8
    jmp strtok_delimitation

end:
    xor     eax, eax
    leave
    ret
