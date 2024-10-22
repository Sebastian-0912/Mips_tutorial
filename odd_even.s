.data
prompt: .asciiz "Enter an integer:\n"
even_msg: .asciiz "Square of the number is: "
odd_msg: .asciiz "Cube of the number is: "

.text
.globl main
main:
    li $v0, 4               # Print prompt
    la $a0, prompt
    syscall

    li $v0, 5               # Read integer
    syscall
    move $t0, $v0           # Store input in $t0

    andi $t1, $t0, 1        # Check if the number is even or odd
    beqz $t1, even_case     # If even, jump to even_case

odd_case:
    li $v0, 4               # Print odd message
    la $a0, odd_msg
    syscall
    jal cube                # Call cube function
    j print_result

even_case:
    li $v0, 4               # Print even message
    la $a0, even_msg
    syscall
    jal square              # Call square function

print_result:
    move $a0, $v0           # Move result to $a0
    li $v0, 1               # Print result
    syscall
    li $v0, 10              # Exit
    syscall

# Function to compute square
square:
    mul $v0, $t0, $t0       # Multiply the input by itself
    jr $ra                  # Return

# Function to compute cube
cube:
    mul $v0, $t0, $t0       # Multiply input by itself
    mul $v0, $v0, $t0       # Multiply the result by the input
    jr $ra                  # Return
