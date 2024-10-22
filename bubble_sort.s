.data
array:  .space 20         # Space for 5 integers

space: .asciiz " "

prompt: .asciiz "Enter 5 integers:\n"
sorted_msg: .asciiz "Sorted array: "

.text
.globl main
main:
    li $v0, 4               # Print prompt
    la $a0, prompt
    syscall

    la $t0, array           # Load array base address
    li $t1, 5               # Loop counter (5 integers)
    
input_loop:
    li $v0, 5               # Read integer
    syscall
    sw $v0, 0($t0)          # Store in array
    addi $t0, $t0, 4        # Move to next array element
    subi $t1, $t1, 1        # Decrement counter
    bgtz $t1, input_loop    # Repeat until counter reaches 0

    # Sorting loop (bubble sort)
    la $t0, array           # Reset array pointer
    li $t1, 5               # Outer loop counter
outer_loop:
    subi $t1, $t1, 1        # Decrement outer loop counter
    la $t2, array           # Reset inner loop pointer
    li $t3, 4               # Inner loop counter

inner_loop:
    lw $t4, 0($t2)          # Load current element
    lw $t5, 4($t2)          # Load next element
    bge $t5, $t4, skip_swap # If current >= next, skip swap

    # Swap $t4 and $t5
    sw $t5, 0($t2)          # Store next element in current position
    sw $t4, 4($t2)          # Store current element in next position

skip_swap:
    addi $t2, $t2, 4        # Move to next pair of elements
    subi $t3, $t3, 1        # Decrement inner loop counter
    bgtz $t3, inner_loop    # Repeat inner loop

    bgtz $t1, outer_loop    # Repeat outer loop

    # Print sorted array
    li $v0, 4               # Print sorted message
    la $a0, sorted_msg
    syscall

    la $t0, array           # Reset array pointer
    li $t1, 5               # Loop counter for printing

print_loop:
    lw $a0, 0($t0)          # Load current element
    li $v0, 1               # Print integer
    syscall
    
    li $v0, 4		    # Print space between array element
    la $a0, space
    syscall
    
    addi $t0, $t0, 4        # Move to next element
    subi $t1, $t1, 1        # Decrement counter
    bgtz $t1, print_loop    # Repeat printing loop

    li $v0, 10              # Exit
    syscall
