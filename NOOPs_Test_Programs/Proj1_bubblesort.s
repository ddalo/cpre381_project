.data 
numbers: .word 8, 100, 0, 3, 7, 9, 2, 7, -3, 0, 18		#create array which holds numbers
message: .asciiz "Sorted Elements: "			#message to be printed

.text



.text
main:
	la $s7, numbers					# load address of elements into $s7

	li $s0, 0					# Initialize counter 1 for loop 1
	li $s6, 10 					# N - 1
	
	li $s1, 0 					# Initialize counter 2 for loop 2

	li $t3, 0					# Initialize counter for printing
	li $t4, 11					# N

	li $v0, 4,					#print message
	la $a0, message
	syscall

loop:
	sll $t7, $s1, 2					# Multiply $s1 by 2 and put it in t7
	
	nop
	nop
	
	add $t7, $s7, $t7 				# Add the address of numbers to t7

	nop
	nop 
	nop
	nop
	
	lw $t0, 0($t7)  				# Load numbers[j]	
	
	nop
	nop 
	nop
	nop
	
	lw $t1, 4($t7) 					# Load numbers[j+1]
	
	nop
	nop 
	nop
	nop
	nop
	nop

	slt $t2, $t0, $t1				# If t0 < t1
	
	nop
	nop 
	nop
	nop
	nop
	nop
	
	bne $t2, $zero, increment
	
	nop
	nop

	sw $t1, 0($t7) 					# Swap
	nop
	nop
	sw $t0, 4($t7)

increment:	

	addi $s1, $s1, 1				# Increment t1
	sub $s5, $s6, $s0 				# Subtract s0 from s6
	
	nop
	nop
	nop

	bne  $s1, $s5, loop				# If s1 (counter for second loop) does not equal 9, loop
	addi $s0, $s0, 1 				# Else add 1 to s0
	li $s1, 0 					# Reset s1 to 0
	
	nop

	bne  $s0, $s6, loop				# Iterate back through loop with s1 = s1 + 1
	
print:
	beq $t3, $t4, final				# If t3 = t4 go to final
	
	lw $t5, 0($s7)					# Load from numbers
	
	li $v0, 1					# Print the number
	
	nop
	
	move $a0, $t5
	nop
	nop
	nop
	nop
	syscall

	nop
	li $a0, 32					# Print space
	nop
	li $v0, 11
	nop
	nop
	nop
	nop
	syscall
	
	nop
	nop
	addi $s7, $s7, 4				# Iterate over numbers 
	nop
	nop
	nop
	addi $t3, $t3, 1				# Increment counter
	
	nop
	nop
	nop
	j print
	
	nop
	nop
	nop
	nop

final:	
	halt					# Finished

