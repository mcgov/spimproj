####rbubblesort
## Bal, Clark, Holm, McGovern
#@author McGovern


##This is obviously not optimal and doesn't really make good use of recursion.
##But it does push return addresses and pop them off the stack, so yay! Recursion!

.data
list: .word 9, 8 , 7, 6, 5, 4 ,3 , 2 , 1, 0  ## set up an array ahead of time

.text

main:
	la $s0 list #load the array into s0
	addi $s3  $zero 9 #store the amount we want to loop to
	addi $s4  $zero 9 #store the amount we want to loop to
	xor $s1 $s1 $s1 #set to 0 
	xor $s5 $s5 $s5 #outer loop counter
	jal readin
	nop
	jal zeroctr
	la  $a0 list  #a1 is the list address
	or  $a1  $s3 $zero #arg 2 is len to loop to
	jal bsort
	jal zeroctr
	addi $s3  $zero 9 #set this back to 9

	jal printcell
	j end
	
swap:
	beq $s1, $s3, reset
	blt $a0  $a1  skip 
	
	or  $t0  $a0  $zero  ##swap a0 and a1
	or  $a0  $a1  $zero 
	or  $a1  $t0  $zero
skip:
	or  $t0  $sp  $zero   #load up that old stack pointer
	addi $t1  $t0  4  #get at the old array pointer
	lw  $t2   0($t1) #load the pointer into a register

	sw  $a0  ($t2) #store the lower int into that address
	addi $t2  $t2  4  #move the address forward one
	sw  $a1  0($t2) # and store the other in the next spot
	or   $a0  $t2  $zero
	
	j  bsort 
	

zeroctr:
	xor $s1 $s1 $s1
	jr $ra

bsort:
	
	addi  $sp $sp  -16  #make room for four words
	sw   $a0  4($sp) #address
	sw   $a1  8($sp) #loop to int
	sw   $ra  0($sp) # original return address
	addi $a1  $a0  4
	lw   $a0  0($a0)  
	lw	 $a1  0($a1)  
	add  $a3  $t0  $zero
	addi $s1  $s1  1
 	jal swap

 	lw   $a0  4($sp)
 	lw   $a1  8($sp)
 	lw   $ra  0($sp)
 	addi  $sp  $sp 16  #return that space
 	j   return

end:
	ori  $v0  $zero 10  # exit code
	syscall ## eat so many fish tacos that you puke on your date

reset:
	xor $s1 $s1 $s1		# set inner loops counter to 0
	addi $s5 $s5 1      # outer loop += 1
	addi $s3  $s3 -1    # array =  array[-1:]
	beq  $s5  $s4  return
	la   $a0  list
	j bsort

printcell:
	beq  $s3  $s1  return
	addi $v0  $zero 1   #print int code
	sll  $t0  $s1  2  # multiply the counter by 4
	add  $t0  $t0  $s0  # add the counter to the base address
	lw   $a0  0($t0)  ## load the word at that computed address
	syscall  ## dance the forbidden dance of love
	addi $v0 $zero  11  # print character code
	addi $a0 $zero  32  ## 32 is the ascii code for ' '
	syscall ## fall for a much older lover
	addi $s1 $s1 1
	j printcell

readin:
	la  $t0  list
	sll $t1  $s1 2
	add $t0  $t0 $t1
	ori $v0  $zero  5
	syscall  #fall down a well
	sw  $v0  ($t0)
	addi $s1  $s1  1
	beq  $s1  $s3  return
	j readin

return:
	jr $ra
