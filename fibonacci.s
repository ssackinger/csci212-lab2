.global main

main:
mov r1, #0
mov r2, #1
mov r3, #0
mov r0, #0
mov r9, #14 @arbitrary input for testing
mov r8, #0

fib:
cmp r8, r9
bgt done

mov r0, r1
add r3, r1, r2
mov r1, r2
mov r2, r3
add r8, r8, #1
blt fib

done:
bx lr
