main:
	xor $t0  $t0   $t0
	addi $t2  $t2  10
	jal recurse
	j end


recurse:
	beq  $t0  $t2  backtrack
	addi $sp $sp -8 #reserve way some room.
	sw   $ra  0($sp) #store your return address
	addi $t0  $t0  1 #increment
	sw   $t0  4($sp) #store your number
	jal recurse # recurse and set the return address

backtrack:
	lw  $t3 4($sp) #load that int into a register
	add $t4  $t4 $t3 #add it to the last one
	lw  $ra ($sp)  # and restore the old return address that we pushed
	addi  $sp  $sp  8 #pop it like it's hot
	j $ra 

end:
	jal print #print it
	ori  $v0  $zero 10  # exit code
	syscall #

print:
	addi $v0  $zero 1   #print int code
	add  $a0  $t4  $zero  #load the int in the arg reg
	syscall  ## make a joke you instantly regret.
	j $ra