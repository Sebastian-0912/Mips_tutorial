.data
prompt:     .asciiz "Enter a number: "
result_msg: .asciiz "The sum is: "
newline:    .asciiz "\n"

.text
.globl main
main:
    # Prompt user for input
    li $v0, 4                     # syscall for printing a string
    la $a0, prompt                # load prompt message
    syscall                       # print prompt

    li $v0, 5                     # syscall for reading an integer
    syscall                       # read user input (n)
    move $t0, $v0                 # store input in $t0 (n)
    
    li $t1, 0                     # initialize sum to 0
    li $t2, 1                     # initialize counter to 1

sum_loop:
    blt $t0, $t2, end_sum         # if counter > n, exit the loop

    add $t1, $t1, $t2             # sum += counter
    addi $t2, $t2, 1              # counter++

    j sum_loop                    # jump back to the beginning of the loop

end_sum:
    # Print result message
    li $v0, 4                     # syscall for printing a string
    la $a0, result_msg            # load result message
    syscall                       # print result message

    # Print the sum
    move $a0, $t1                 # move the sum to $a0 for printing
    li $v0, 1                     # syscall for printing integer
    syscall                       # print sum

    # Print newline
    li $v0, 4                     # syscall for printing a string
    la $a0, newline               # load newline character
    syscall                       # print newline

    # Exit
    li $v0, 10                    # syscall to exit
    syscall
