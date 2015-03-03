#nrbubblesort
## Bal, Clark, Holm, McGovern

.data
list: .word 20, 10 , 5, 12, 13, 15 ,19 , 8 , 1  ## set up an array ahead of time
##TODO: Do we need to do a input function? yes we doo

.text



main:
	la $s0 list #load the array into s0
	addi $s3  $zero 9 #store the amount we want to loop to
	addi $s4  $zero 9 #outer loop target
	xor $s1 $s1 $s1 #set to 0 
	xor $s5 $s5 $s5 #outer loop counter
	j  readin
	


swap:
	beq $s1, $s3, reset
	blt $a0  $a1  loop
	or  $t0  $a0  $zero  ##swap a0 and a1
	or  $a0  $a1  $zero 
	or  $a1  $t0  $zero
	sw  $a0  0($a2)
	sw  $a1  0($a3)
	j   loop

zeroctr:
	xor $s1 $s1 $s1
	j loop

loop:
	sll  $t0  $s1  2 #multiply by 4
	add  $t0  $t0  $s0  
	lw   $a0  0($t0)  
	add  $a2  $zero  $t0  #save that pointer

	addi $s1  $s1  1
	sll  $t0  $s1  2
	add  $t0  $s0  $t0
	lw	 $a1  0($t0) 
	add  $a3  $t0  $zero
 	j swap



end:
	ori  $v0  $zero 10  # exit code
	syscall ## eat so many fish tacos that you puke on your date
	## but they were soooooooo goood.

reset:
	xor $s1  $s1  $s1
	addi $s5 $s5 1
	blt $s5 $s4  loop
	j printcell

printcell:
	beq  $s3  $s1  end
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
	syscall
	sw  $v0  ($t0)
	addi $s1  $s1  1
	beq  $s1  $s3  zeroctr
	j readin

