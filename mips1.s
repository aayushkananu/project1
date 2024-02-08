# X = 03086745, N = 26 + (X % 11) = 28, M = N-10 =18
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



loop:
	lb $t0, 0($s0) 	#load byte from input string
	beqz $t2, $t3, end_loop	#if it reaches the end of the input string, loop ends
	
	