.data
prompt:      .asciiz "Enter a number: "
max_msg:     .asciiz "The maximum value is: "
array:       .space 20           # Space for 5 integers (4 bytes each)

.text
.globl main
main:
    li $t0, 5                     # Array size
    la $t1, array                 # Load array base address

input_loop:
    li $v0, 4                     # Print prompt
    la $a0, prompt
    syscall

    li $v0, 5                     # Read integer
    syscall
    sw $v0, 0($t1)                # Store input into the array
    addi $t1, $t1, 4              # Move to the next array slot

    subi $t0, $t0, 1              # Decrease counter
    bgtz $t0, input_loop          # Repeat until all elements are input

    la $t1, array                 # Load array base address again
    lw $t0, 0($t1)                # Load the first array element
    move $t2, $t0                 # Initialize maximum with the first element

    li $t3, 4                     # Counter for next array elements
find_max:
    lw $t0, 4($t1)                # Load next element
    addi $t1, $t1, 4              # Move to the next array slot

    bgt $t0, $t2, update_max      # If current element > max, update max
    j check_next

update_max:
    move $t2, $t0                 # Update max value

check_next:
    subi $t3, $t3, 1              # Decrement counter
    bgtz $t3, find_max            # Repeat until all elements are checked

    li $v0, 4                     # Print max message
    la $a0, max_msg
    syscall

    move $a0, $t2                 # Print max value
    li $v0, 1
    syscall

    li $v0, 10                    # Exit
    syscall
