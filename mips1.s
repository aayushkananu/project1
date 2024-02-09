# X = 03086745, N = 26 + (X % 11) = 28, M = N-10 =18, 27
.data
space:        .asciiz "\n"    # Newline character for output
input_string:   .space 1001     # To store user input
prompt:         .asciiz "Enter a string: "    # Prompt message


.text
main:
	li $v0, 4                   # System call code for print string
	la $a0, prompt              # Load address of input prompt message
	syscall  
                
	li $v0, 8                   
	la $a0, input_string       # Load address of input string
	li $a1, 1000                	
	syscall      

	jal process_whole_string   #jump to processing the input strong

	
	li $v0, 10
	syscall            #system call to exit program

process_whole_string:
	move $s0, $a0
	li $t0, 0



loop:
	lb $t1, 0($s0) 	#load byte from input string
	beqz $t1, end_loop	#if it reaches the end of the input string loop ends
	
	li $t2, 48
	blt $t1, $t2, not_integer
	li $t2, 57
	bgt $t1, $t2, not_integer

	sub $t1, $t1, 48
	add $t0, $t0, $t1

not_integer:
	addi $s0, $s0, 1
	j loop

 	

end_loop:
	li $v0,1
	move $a0, $t0
	syscall

