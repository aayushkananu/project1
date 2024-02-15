.data
space:          .asciiz "\n"           
input_string:   .space 1001 #allocate space for user input of maximum 1000 characters
slash: .asciiz "/" # slash character            
prompt:         .asciiz "Enter a string: "    #prompt message

.text
main:
    li $v0, 4                  
    la $a0, prompt              #load address of input prompt 
    syscall  

    li $v0, 8                   
    la $a0, input_string       
    li $a1, 1000                
    syscall      

    jal process_whole_string   

    li $v0, 10                  #system call code for exit program
    syscall                    


process_whole_string:
    move $s0, $a0               #store address of input string from $a0 to $s0
    li $t0, 0                   #initialize $t0 to 0

loop:
    lb $t1, 0($s0)              #load the first byte from $s0
    beqz $t1, end_loop          # if it reaches the end of the input string, end_loop is called

 
    li $t2, 48                 
    li $t3, 57                  
    blt $t1, $t2, check_alphabet # if the ascii value is less than 48 it isn't a number so check if it is alphabet 
    bgt $t1, $t3, check_alphabet # if ascii value is greater than 57 it isn't a number so check if it is alphabet

   
    sub $t1, $t1, 48           
    add $t0, $t0, $t1          
    j next_character      # jump to another character     

check_alphabet:
    li $t2, 65      #ascii value of capital a loaded to $t2           
    li $t3, 114     #ascii value of small r loaded           
    blt $t1, $t2, invalid_char  #if ascii value is less so check in another label
    bgt $t1, $t3, after_r       

    # Convert lowercase to uppercase
    li $t4, 97                 
    bge $t1, $t4, to_uppercase 

    # Calculate the value of the alphabet and add to sum
    sub $t1, $t1, $t2           
    addi $t1, $t1, 10           
    add $t0, $t0, $t1           
    j next_character         

to_uppercase:
    addi $t1, $t1, -32    #subtract 32 to get   
    j check_alphabet           

after_r:
    li $t4, 122                 
    blt $t1, $t4, invalid_char 

   
    li $t1, 0                   #set value to 0
    add $t0, $t0, $t1     
    j next_character            #jump to process the next character

invalid_char:
    j next_character            # jump to process the next character

next_character:
    addi $s0, $s0, 1           
    j loop                     

end_loop:
    beq $t0, $zero, hyphen
    li $v0, 1                  
    move $a0, $t0              
    syscall                      #return to the calling function


hyphen:
    li $v0, 11
    li  $a0, 45 
    syscall

end_program:
    li $v0, 10
    syscall 