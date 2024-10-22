.data
prompt:     .asciiz "Enter the length: "
result_msg: .asciiz "Fibonacci sequence (start form 0):\n"
newline:    .asciiz "\n"

.texts
.globl main
main:
    # Prompt user for input
    li $v0, 4                     # syscall for printing a string
    la $a0, prompt                # load prompt message
    syscall                       # print prompt

    li $v0, 5                     # syscall for reading an integer
    syscall                       # read user input (n)
    move $t0, $v0                 # store input in $t0 (n)

    # Print result message
    li $v0, 4                     # syscall for printing a string
    la $a0, result_msg            # load result message
    syscall                       # print result message

    # Initialize first two Fibonacci numbers
    li $t1, 0                     # $t1 holds Fib(0)
    li $t2, 1                     # $t2 holds Fib(1)

    # Print first Fibonacci number (Fib(0) = 0)
    move $a0, $t1                 # move 0 to $a0 for printing
    li $v0, 1                     # syscall for printing integer
    syscall                       # print 0

    # Print newline
    li $v0, 4                     # syscall for printing a string
    la $a0, newline               # load newline character
    syscall                       # print newline

    # Check if n > 1 to print more numbers
    blez $t0, exit                # if n <= 0, exit the program

    # Print second Fibonacci number (Fib(1) = 1)
    move $a0, $t2                 # move 1 to $a0 for printing
    li $v0, 1                     # syscall for printing integer
    syscall                       # print 1

    # Print newline
    li $v0, 4                     # syscall for printing a string
    la $a0, newline               # load newline character
    syscall                       # print newline

    # Initialize counter for next Fibonacci numbers
    li $t3, 2                     # counter for next terms, starting from Fib(2)

fib_loop:
    bge $t3, $t0, exit            # if counter >= n, exit the loop

    # Calculate next Fibonacci number
    add $t4, $t1, $t2             # $t4 = Fib(i-2) + Fib(i-1)
    
    # Print the next Fibonacci number
    move $a0, $t4                 # move the next Fibonacci number to $a0
    li $v0, 1                     # syscall for printing integer
    syscall                       # print next Fibonacci number

    # Print newline
    li $v0, 4                     # syscall for printing a string
    la $a0, newline               # load newline character
    syscall                       # print newline

    # Update Fibonacci numbers for the next iteration
    move $t1, $t2                 # $t1 = $t2 (Fib(i-1))
    move $t2, $t4                 # $t2 = $t4 (Fib(i))

    # Increment the counter
    addi $t3, $t3, 1              # increment the counter

    # Repeat the loop
    j fib_loop

exit:
    li $v0, 10                    # syscall to exit
    syscall
