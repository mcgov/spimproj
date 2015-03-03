#nrbubblesort
## Bal, Clark, Holm, McGovern

.data
list: .word 5 , 10, 12, 13, 15 ,19 , 20  ## set up an array ahead of time
##TODO: Do we need to do a input function?

.text

.globl main

main:
la $s0 list #load the array into s0
xor $s1 $s1 $s1 #set to 0 
jal printcell
j end

swap:
	or  $t0 $a0  $zero  ##swap a0 and a1
	or  $a0  $a1  $zero 
	or  $a1  $a0  $zero
	j   $ra

end:
	ori  $v0  $zero 10  # exit code
	syscall ## eat so many fish tacos that you puke on your date
	## but they were soooooooo goood.

printcell:
	addi $v0  $zero 1   #print int code
	sll  $t0  $s1  2  # multiply the counter by 4
	add  $t0  $t0  $s0  # add the counter to the base address
	lw   $a0  0($t0)  ## load the word at that computed address
	syscall  ## dance the forbidden dance of love
	addi $v0 $zero  11  # print character code
	addi $a0 $zero  32  ## 32 is the ascii code for ' '
	syscall ## fall for a much older lover
	j $ra  ## jump return
