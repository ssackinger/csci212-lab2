.data

.balign 4
prompt: .asciz "Enter Fibonacci term:\t"

.balign 4
format: .asciz "\nTerm %d in the Fibonacci sequence is\t"

.balign 4
return: .word 0

.text

.global main

main:
    ldr r1, address_of_return
    str lr, [r1]

    ldr r0, address_of_prompt
    bl printf

    ldr lr, address_of_return        /* lr ← &address_of_return */
    ldr lr, [lr]                     /* lr ← *lr */
    bx lr                            /* return from main using lr */

/*
    mov r1, #1
    mov r2, #1
    mov r3, #0
    mov r0, #0
    mov r9, #4 @arbitrary input for testing
    mov r8, #0

fib:
    cmp r8, r9
    bge done

    mov r0, r1
    add r3, r1, r2
    mov r1, r2
    mov r2, r3
    add r8, r8, #1
    blt fib

done:
    bx lr
*/

address_of_prompt: .word prompt
address_of_return: .word return


.global printf
.global scanf

