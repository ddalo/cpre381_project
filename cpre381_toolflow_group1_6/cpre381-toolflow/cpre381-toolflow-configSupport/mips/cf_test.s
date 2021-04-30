# Application which uses each of the required control-flow instructions and has a call depth of at least 5
# beq, bne, j, jal, jr, repl.qb
.data
finisher: .asciiz "We are done!"

.text
.globl main
main:
jal start 
add $t2, $t1, $t1
bne $t1, $t2, compare


start: 
	addi $t1, $0, 12
	jr $ra
		
compare: 
	sll $t1, $t1, 1
	beq $t1, $t2, prefinished
	
prefinished:
	addi $v0, $0, 4
	la $a0, finisher
	j finished
	
finished:
    # Exit program
    halt
    li $v0, 10
    syscall