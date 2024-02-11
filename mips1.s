.data
input_string:   .space 1001             
.text
main:
    li $v0, 4                  
    la $a0, prompt              
    syscall  

    li $v0, 8                   
    la $a0, input_string       
    li $a1, 1000                
    syscall      

    jal process_whole_string   

    li $v0, 10                  
    syscall                     

process_whole_string:
    move $s0, $a0               
    li $t0, 0                   

loop:
    lb $t1, 0($s0)              
    beqz $t1, end_loop          

    li $t2, 48                  
    li $t3, 57                  
    blt $t1, $t2, check_alphabet 
    bgt $t1, $t3, check_alphabet 

    sub $t1, $t1, 48            
    add $t0, $t0, $t1           
    j next_character            

check_alphabet:
    li $t2, 65                  
    li $t3, 114                 
    blt $t1, $t2, invalid_char  
    bgt $t1, $t3, after_r       

    li $t4, 97                  
    bge $t1, $t4, to_uppercase  

    sub $t1, $t1, $t2           
    addi $t1, $t1, 10           
    add $t0, $t0, $t1           
    j next_character            

to_uppercase:
    addi $t1, $t1, -32          
    j check_alphabet            

after_r:
    li $t4, 122                 
    blt $t1, $t4, invalid_char  

    li $t1, 0                   
    add $t0, $t0, $t1           
    j next_character            

next_character:
    addi $s0, $s0, 1            
    j loop                      

end_loop:
    li $v0, 1                   
    move $a0, $t0               
    syscall                     
    jr $ra                      

invalid_char:
    j next_character            
