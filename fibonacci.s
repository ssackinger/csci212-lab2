.data

.balign 4
prompt: .asciz "Enter Fibonacci term:\t"

.balign 4
format: .asciz "Term %d in the Fibonacci sequence is:\t %d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
number_read: .word 0

.balign 4
return: .word 0

.text

.global main



main:
    ldr r1, address_of_return
    str lr, [r1]

    ldr r0, address_of_prompt
    bl printf

    ldr r0, address_of_scan_pattern  /* r0 ← &scan_pattern */
    ldr r1, address_of_number_read   /* r1 ← &number_read */
    bl scanf                         /* call to scanf */

    mov r1, #1
    mov r2, #1
    mov r3, #0
    mov r0, #0
    ldr r9, address_of_number_read @arbitrary input for testing
    ldr r9, [r9]
    mov r8, #2

fib:
    cmp r8, r9
    bge done

    mov r0, r1
    add r3, r1, r2
    mov r1, r2
    mov r2, r3
    add r8, r8, #1
    b fib

done:

    ldr r0, address_of_format        /* r0 ← &message2 */
    mov r1, r9
    mov r2, r3
    @ldr r1, address_of_number_read   /* r1 ← &number_read */
    @ldr r1, [r1]                     /* r1 ← *r1 */
    bl printf                        /* call to printf */

    ldr lr, address_of_return        /* lr ← &address_of_return */
    ldr lr, [lr]                     /* lr ← *lr */
    bx lr                            /* return from main using lr */


address_of_prompt: .word prompt
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_format: .word format
address_of_return: .word return


.global printf
.global scanf

