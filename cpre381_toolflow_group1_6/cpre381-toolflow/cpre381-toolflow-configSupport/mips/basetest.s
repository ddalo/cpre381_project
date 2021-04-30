# Application that makes use of every arithmetic/logical instr. in order to test single cycle processor
# add/sub(both signed and unsigned)
# slt, and, or, xor, nor, sll, srl, and sra

.data
.text
.globl main
main:
addi $t0, $t0, -25		# set $t0:-25

sub $t2, $0, $t0		# set $t2:(0 - -25) = 25

addiu $t1, $t0, 50		# set $t1:(-25 + 50)= 25

sll $t1, $t1, 2			# set $t1:(25 * 2^2) = 100

subu $t3, $t1, $t2		# set $t3:(100 - 25) = 75

slt $t0, $t3, $t1		# set $t0:(75 < 100) ? 1 

srl $t1, $t1, 1			# set $t1:(100 / 2^1) = 50

sra $t6, $t3, 3			# set $t6:(1001011 >> 3) = 1001

or $t2, $t1, $t0		# set $t2:(50 OR 1) = 51

nor $t0, $t0, $t6		# set $t0:(0001 NOR 1001) = -1111111111110110;	**(1  NOR  9) = -10**

and $t1, $t2, $t3		# set $t1:(00110011 AND 01001011) = 00000011;  **(51 AND 75) = 3**

xor $t2, $t6, $t1		# set $t2:(00001001 XOR 00000011) = 00001010	**(9  XOR  3) = 10** 

#repl.qb $t2, 124		# replicate '01111100' into all 32 bits


# Exit program
halt
li $v0, 10
syscall




