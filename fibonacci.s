.data

.balign 4
prompt: .asciz "Enter Fibonacci term:\t"

.balign 4
format: .asciz "Term %d in the Fibonacci sequence is:\t %d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
number_read: .word 0

.text

fibonacci:
    push {r1-r3, r8, r9, lr}

    mov r9, r0          @load passed in value from r0
    mov r1, #1
    mov r2, #1
    mov r3, #0
    mov r0, #0
    mov r8, #2

fibonacci_loop:
    cmp r8, r9
    bge fibonacci_done

    mov r0, r1
    add r3, r1, r2
    mov r1, r2
    mov r2, r3
    add r8, r8, #1
    b fibonacci_loop

fibonacci_done:
    pop {r1-r3, r8, r9, lr}
    bx lr


.global main
main:
    push {lr}

    ldr r0, address_of_prompt
    bl printf

    ldr r0, address_of_scan_pattern  /* r0 ← &scan_pattern */
    ldr r1, address_of_number_read   /* r1 ← &number_read */
    bl scanf                         /* call to scanf */

    ldr r0, address_of_number_read
    ldr r0, [r0]

    bl fibonacci

    mov r2, r0                      @load return value into r2 before address_of_format changes it

    ldr r0, address_of_format        /* r0 ← &message2 */

    ldr r1, address_of_number_read   /* r1 ← &number_read */
    ldr r1, [r1]                     /* r1 ← *r1 */
    bl printf                        /* call to printf */

    pop {lr}
    bx lr                            /* return from main using lr */


address_of_prompt: .word prompt
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_format: .word format

.global printf
.global scanf

