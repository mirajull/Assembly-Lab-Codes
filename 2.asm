.MODEL SMALL

.STACK 100H

.DATA


STRING1 DB 80 DUP (0)
STRING2 DB 80 DUP (0)
STRING3 DB 'ANGELA'
STRING4 DB 6 DUP (0) 

MAINST DB 'ABCABC'
SUBST DB 'AB' 

SUB_LEN DW 2 ;UPDATE IT TO BX
START DW ?
STOP DW ?



NEWLINE DB 0DH,0AH,'$'


.CODE

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
    
    ;1
    ;LEA DI,STRING1
    ;CALL READ_STR_1 
     
    ;LEA SI,STRING1
    ;CALL DISP_STR_1
    
    ;2
   ; LEA DI,STRING2
   ; CALL READ_STR_2
       
    
   ; LEA SI,STRING2
   ; CALL DISP_STR_2 
   
   
   ;REVERSE STRING 
   CALL REVERSE_STR_2;
   
   ;PROCESS STRING
   CALL PROCESS_STR;
    
    
   ;PRINT MAINSTRING
   CALL PRINT_MAIN 
    
    ;EXIT
    MOV AH,4CH
    INT 21H
    

MAIN ENDP
    
 
 
PROC READ_STR_1 NEAR
    
     CLD  
     MOV DI,0
     XOR BX,BX
     MOV AH,1
     INT 21H
     
     
     WHILE_1:
        
        CMP AL,0DH
        JE END_WHILE_1
        
        ;IF BACKSPACE
        CMP AL,8H
        JNE ELSE_1
        
        
        DEC DI
        DEC BX
        
        JMP READ_1
        
        ELSE_1:
        
            STOSB
            INC BX
  
        READ_1:
            
            INT 21H
            JMP WHILE_2
  
        
        END_WHILE_1:
            RET
  
  
READ_STR_1 ENDP         




PROC READ_STR_2 NEAR
    
     CLD  
     MOV DI,0
     XOR BX,BX
     MOV AH,1
     INT 21H
     
     
     WHILE_2:
        
        CMP AL,0DH
        JE END_WHILE_2
        
        ;IF BACKSPACE
        CMP AL,8H
        JNE ELSE_2
        
        
        DEC DI
        DEC BX
        
        JMP READ_2
        
        ELSE_2:
        
            STOSB
            INC BX
  
        READ_2:
            
            INT 21H
            JMP WHILE_2
  
        
        END_WHILE_2:
            RET
  
  
READ_STR_2 ENDP  





PROC DISP_STR_1
        
    LEA DX,NEWLINE
    MOV AH,9
    INT 21H
    
    CLD 
    MOV AH,2
    MOV CX,BX
    
    TOP_1:
        LODSB
        MOV DL,AL
        INT 21H
        LOOP TOP_1
               
    
DISP_STR_1 ENDP   



PROC DISP_STR_2
        
    LEA DX,NEWLINE
    MOV AH,9
    INT 21H
    
    CLD 
    MOV AH,2
    MOV CX,BX
    
    TOP_2:
        LODSB
        MOV DL,AL
        INT 21H
        LOOP TOP_2
               
    
DISP_STR_2 ENDP

 
 
PROC REVERSE_STR_2
    
     LEA SI,STRING3+5
     LEA DI,STRING4 
     
     STD
     
     MOV CX,6 
     
     MOVE:
        MOVSB
        ADD DI,2
        LOOP MOVE
                  
                  
                  
                  
REVERSE_STR_2 ENDP
                  
                  
                  

PROC PROCESS_STR NEAR
    
      LEA SI,SUBST
      LEA DI,MAINST
      
      CLD
      
      ;COMPUTE STOP
      MOV STOP,DI
      ADD STOP,6 ;UPDATE TO ACTUAL LENGTH OF MAINST
      MOV CX,SUB_LEN
      SUB STOP,CX
      
      ;INIT START
      MOV START,DI
      
      REPEAT:
        ;COMPARE CHARACTERS
                
         ;MOV CLEN ??
         MOV DI,START
         LEA SI,SUBST 
         REPE CMPSB
         CALL MAKE_ZERO ;IN MAINSTR,MAKE THE SUBSTR PART ZERO
         XOR BX,BX
         MOV BX,SI
         SUB BX,1
         
         
         ;IF IT'S NOT A SUBSTRING
         INC START               
         
         ;CHECK IF START<=STOP
         MOV AX,START
         CMP AX,STOP
         JNLE END_REPEAT
         JMP REPEAT
         
         
         END_REPEAT:
            RET
                        
                
     
PROCESS_STR ENDP 


PROC MAKE_ZERO NEAR 
                
        MOV CX,SUB_LEN        
        
      LOOP_ZERO:
            
            MOV MAINST[BX],0
            DEC BX
            LOOP LOOP_ZERO
    
    
MAKE_ZERO ENDP 
    
    
    

PROC PRINT_MAIN NEAR
     
    LEA DX,NEWLINE
    MOV AH,9
    INT 21H 
    
    MOV CX,6 ;LATER UPDATE IT TO CORRESPONDING BX
    XOR BX,BX
    
    
    PRINT_LOOP:
        
        MOV AL,MAINST[BX]
        CMP AL,0
        JE CONTINUE
        
        MOV AH,2
        INT 21H
        
        CONTINUE:
            LOOP PRINT_LOOP
    
    
    
PRINT_MAIN ENDP



END MAIN