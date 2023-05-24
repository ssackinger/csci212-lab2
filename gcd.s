.data

.balign 4
prompt1: .asciz "Enter first positive term:\t"

.balign 4
prompt2: .asciz "Enter second positive term:\t"

.balign 4
format: .asciz "The GCF of the two numbers is:\t %d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
number_numerator: .word 0

.balign 4
number_denominator: .word 0

.text

unsigned_divide:
    push {r2}
    mov r2, r1
    mov r1, r0

    mov r0, #0

    b .Ldivide_check
    .Ldivide_loop:
        add r0, r0, #1          @add 1 to quotient
        sub r1, r1, r2          @subtract r2 from r1 once
    .Ldivide_check
        cmp r1, r2
        bhs .Ldivide_loop

    pop {r2}
    bx lr


euclidean:
    push {r1-r3, lr}

euclidean_step1:
    @ if a < b, exchange a and b
    cmp r0, r1
    bge euclidean_step2

    @ Swap a and b
    mov r2, r0
    mov r0, r1
    mov r1, r2

euclidean_step2:
    mov r2, r0
    mov r3, r1
    bl unsigned_divide

    cmp r1, #0
    beq euclidean_done

euclidean_step3:
    mov r0, r3
    b euclidean_step2

euclidean_done:
   @ handle return value in r0
    mov r0, r3

    pop {r1-r3, lr}
    bx lr


.global main
main:
    push {lr}

    ldr r0, address_of_prompt1
    bl printf

    ldr r0, address_of_scan_pattern  /* r0 ← &scan_pattern */
    ldr r1, address_of_numerator  /* r1 ← &number_read */
    bl scanf                         /* call to scanf */

    ldr r0, address_of_prompt2
    bl printf

    ldr r0, address_of_scan_pattern  /* r0 ← &scan_pattern */
    ldr r1, address_of_denominator  /* r1 ← &number_read */
    bl scanf                         /* call to scanf */

    ldr r0, address_of_numerator
    ldr r0, [r0]
    ldr r1, address_of_denominator
    ldr r1, [r1]
    bl euclidean

    mov r1, r0                      @load return value into r1 before address_of_format changes it

    ldr r0, address_of_format        /* r0 ← &message2 */
    bl printf                        /* call to printf */

    pop {lr}
    bx lr                            /* return from main using lr */


address_of_prompt1: .word prompt1
address_of_prompt2: .word prompt2
address_of_scan_pattern: .word scan_pattern
address_of_numerator: .word number_numerator
address_of_denominator: .word number_denominator
address_of_format: .word format

.global printf
.global scanf
