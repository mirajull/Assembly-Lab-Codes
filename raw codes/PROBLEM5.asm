.MODEL SMALL

.STACK 100H

.DATA
A DB ?
B DB ?
C DB ?
D DB ?
MSG1 DB 'PLEASE INPUT FIRST LETTER:$'
MSG2 DB 0DH,0AH,'PLEASE INPUT SECOND LETTER:$'
MSG3 DB 'BOTH OF THE INPUT ARE NOT LETTER.$'

.CODE

MAIN PROC
    
LOOP_MAIN:
    
    ;LOADING DATA
    MOV AX,@DATA   
    MOV DS,AX
    
    ;PRINTING USER PROMT
    LEA DX,MSG1
    MOV AH,9
    INT 21H 
    
    ;TAKING FIRST INPUT
    MOV AH,1
    INT 21H
    MOV A,AL
    
    ;PRINTING USER PROMT
    LEA DX,MSG2
    MOV AH,9
    INT 21H 
    
    ;TAKING SECOND INPUT
    MOV AH,1
    INT 21H
    MOV B,AL
    
    ;PRINTING NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
CHECK_1: ;CHECKING WHETHER A IS A LETTER
    MOV BL,A
    MOV DL,1
    JMP COMP_1 

CHECK_2: ;CHECKING WHETHER B IS A LETTER
    MOV BL,B
    MOV DL,2
    JMP COMP_1
    
COMP_1:  ;CHECKING WHETHER THE ASCHII VALUE
         ;IS GREATER THAN THE ASCHII VALUE
         ;OF 'A'
           
    CMP BL,65
    JL OUT_1 ;IF NOT ITS NOT A LETTER
    JGE COMP_2
    
COMP_2:  ;CHECKING WHETHER THE ASCHII VALUE
         ;IS LESS THAN THE ASCHII VALUE
         ;OF 'Z'
         
    CMP BL,90
    JG COMP_3 ;IF NOT THEN CHECK FOR LOWERCASE
    JLE CHECK_CONTROL

COMP_3:  ;CHECKING WHETHER THE ASCHII VALUE
         ;IS GREATER THAN THE ASCHII VALUE
         ;OF 'a'
         
    CMP BL,97
    JL OUT_1  ;IF NOT ITS NOT A LETTER
    JGE COMP_4
    
COMP_4:  ;CHECKING WHETHER THE ASCHII VALUE
         ;IS LESS THAN THE ASCHII VALUE
         ;OF 'z'
            
    CMP BL,122
    JG OUT_1  ;IF NOT ITS NOT A LETTER
    JLE CHECK_CONTROL
    
CHECK_CONTROL: ;SWITCHING VARIABLES
    CMP DL,1
    JE CHECK_2
    CMP DL,2
    JE LOOP_CONTROL ;IF BOTH THE VARIABLES
                    ;ARE LETTERS THEN GO FOR
                    ;LOOPING AND PRINTING
                    
LOOP_CONTROL: ;CHECKING WHICH METHOD SHOULD
              ;WE USE

    MOV BL,A
    CMP BL,B  ;CHECKING IF THE LETTERS ARE 
              ;SAME AND CASE IS SAME
              
    MOV CX,4  ;SETTING LOOP COUNTER TO 4
    JE LOOP_1
    JG CHECK_5
    JL CHECK_6 
    
LOOP_1:       ;METHOD 1:LETTERS ARE SAME
    MOV AH,2
    MOV DL,BL
    INT 21H
    INC BL
    LOOP LOOP_1
    JMP END_1 
    
CHECK_5:      ;CHECKING IF LETTERS ARE SAME
              ;BUT A IS UPPERCASE ,B LOWER
              
    SUB BL,20H
    CMP BL,B
    MOV BL,A
    JE LOOP_1
    JNE CHECK_CASE1 
    
CHECK_6:      ;CHECKING IF LETTERS ARE SAME
              ;BUT B IS UPPERCASE ,A LOWER

    MOV AL,B
    SUB AL,20H
    CMP BL,AL
    JE LOOP_1
    JNE CHECK_CASE1
    
CHECK_CASE1:  ;CASE CHECKING FOR A
    MOV AL,A
    MOV DL,1
    JMP CHECK_7
    
CHECK_CASE2:  ;CASE CHECKING FOR B
    MOV AL,B
    MOV DL,2
    JMP CHECK_7
    
CHECK_7:      ;CHECKING CASE
    CMP AL,91
    JL CASE_1
    JG CASE_2 
    
CASE_1:       ;UPPERCASE POSITION
    SUB AL,64
    JMP CASE_CONTROL
    
CASE_2:       ;LOWERCASE POSITION
    SUB AL,96
    JMP CASE_CONTROL
    
CASE_CONTROL: ;SWITCHING VARIABLES
    CMP DL,1
    JE ASSIGN_C
    CMP DL,2
    JE ASSIGN_D
    
ASSIGN_C:     ;ASSIGNING POSITION OF A
    MOV C,AL
    JMP CHECK_CASE2  
    
ASSIGN_D:     ;ASSIGNING POSITION OF B
    MOV D,AL
    JMP LOOP_SETUP
    
LOOP_SETUP:   ;CALCULATING LOOP COUNT
    MOV CL,D
    SUB CL,C
    INC CL
    CBW
    MOV DL,A
    JMP LOOP_2
    
LOOP_2:       ;METHOD 2:LETTERS ARE DIFFERENT

    MOV AH,2
    INT 21H
    INC DL
    LOOP LOOP_2
    JMP END_1
      
OUT_1:        ;PRINTING ERROR MESSAGE 

    LEA DX,MSG3
    MOV AH,9
    INT 21H
    JMP END_1
    
END_1:        ;REPEATING THE WHOLE PROCESS 
    
    ;PRINTING NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    ;GOING BACK TO START
    JMP LOOP_MAIN
    
    ;RETURNING TO DOS
    ;THOUGH THIS LINES WILL NEVER EXECUTE
    MOV AH,4CH
    INT 21H
    
MAIN ENDP

    END MAIN            