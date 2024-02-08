.data
space:        .asciiz "\n"    # Newline character for output
input_string:   .space 1001     # To store user input
prompt:         .asciiz "Enter a string: "    # Prompt message


.text
main:
    li $v0, 4                   # System call code for print string
    la $a0, prompt              # Load address of input prompt message
    syscall                  

    # Read user input
    li $v0, 8                   
    la $a0, input_string       # Load address of input string
    li $a1, 1000                
    syscall                     