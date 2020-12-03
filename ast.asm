
section .data
    delim db " ", 10, 0

section .bss
    root resd 1

section .text

extern create_node
extern printf
extern strtok
extern evaluate_ast
extern strlen
global create_tree
global iocla_atoi

iocla_atoi: ; converting a string into an integer
    ; TODO
    enter   0, 0
    mov     ebx, [ebp + 8]
    push    ebx
    call    strlen ; the length of the string that will be converted
    add     esp, 4
    push    eax
    xor     eax, eax
    xor     edx, edx
    xor     ecx, ecx
    cmp     byte[ebx], '-' ; checking if the number is negative
    jne     int_converter
    inc     ecx
int_converter:
    mov     dl, byte[ebx + ecx]
    push    ecx
    sub     dl, '0' ; converting the character in string
    push    edx     
    mov     ecx, 10 ; adding to the final number
    mul     ecx
    pop     edx
    add     eax, edx
end_int_converter:
    pop     ecx
    inc     ecx
    cmp     ecx, [ebp - 4]
    jl      int_converter ; iterate through the string until the end of it
    cmp     byte[ebx], '-'
    jne     end
    mov     ecx, -1 ; if th efirst character was '-' make the number negative
    mul     ecx
end:
    push    eax
    leave
    ret


start_create_tree:
    enter   0, 0
    mov     eax, [ebp + 8] ; current_node
    push    eax
    mov     ecx, [eax]

    cmp     byte[ecx], '-'
    je      operator_case

    cmp     byte[ecx], '+'
    je      operator_case

    cmp     byte[ecx], '*'
    je      operator_case

    cmp     byte[ecx], '/'
    je      operator_case

    jmp     number_case

operator_case: ; the current node is an operator
    cmp     byte[ecx + 1], 0 ; verifying if the number is negative
    jne     number_case
    push    delim
    push    0
    call    strtok
    add     esp, 8
    push    eax
    call    create_node ; allocating space for the new node
    add     esp, 4
    pop     ecx
    mov     [ecx + 4], eax ; put the new node in the left of the current node
    push    ecx
    push    dword[ecx + 4]
    call    start_create_tree ; enter recursion on the left side of the current node
    add     esp, 4
    push    delim
    push    0
    call    strtok
    add     esp, 8
    push    eax
    call    create_node ; allocating space for the new node
    add     esp, 4
    pop     ecx
    mov     [ecx + 8], eax ; put the new node in the right of the current node
    push    dword[ecx + 8]
    call    start_create_tree ; enters in recursion on the right side of the current node
    add     esp, 4

    leave
    ret

number_case: ; returns from recursion when the current node is a number
    leave
    ret

create_tree:
    ; TODO
    enter   0, 0
    pusha
    push    delim
    push    eax
    call    strtok
    add     esp, 8
    push    eax
    call    create_node ; allocating space for the node
    add     esp, 4
    mov     [root], eax ; set the root
    push    eax
    call    start_create_tree ; the function that creates the ast
    add     esp, 4
    popa
    xor     eax, eax
    mov     eax, [root] ; return the tree in eax
    leave
    ret
