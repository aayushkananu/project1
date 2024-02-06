.data
space: .asciiz "\n" 
input: .asciiz "Enter the string: "
input_string: .space 1000 #space for 1000 characters has been allocated, and the main program has been started.

.text
.globl main
main: 
	li $v0, 8 #taking user input for strings
	la $a0, input_string 

