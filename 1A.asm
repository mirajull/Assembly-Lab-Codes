.MODEL SMALL

.STACK 100H

.DATA
M DW ?
N DW ?
C DW ?
MSG1 DW "ENTER COLUM $"
MSG2 DW "ENTER ROW $"
MSG3 DW "FIRST MATRIX $"
MSG4 DW "2ND MATRIX $"
MSG5 DW "OUTPUT $"
    


A DW 10 DUP(0)

B DW 10 DUP(0)



.CODE

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    
     
    
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV AH,0
    MOV M,AX
    
    
  
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    
    
    
    
    
    
    
    
    
    
    
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    MOV AH,1
    
    INT 21H 
    
    SUB AL,30H
    MOV AH,0
    
    MOV N,AX
    
    MOV AX,0
    ;MOV DX,0
    
    MOV AX,M
    MUL N
    
    
    MOV N,AX
    MOV M,AX
    MOV C,AX 
    
    
    
     
    
    
    
    
    
 
    
 
    MAIN ENDP


    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    


    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    



    LEA SI, A
    MOV BX,AX
    
    
    
    
      
   CALL READ_ARRAY1
   
   

   
  
      
   READ_ARRAY1 PROC
   
  

   PUSH AX                       
   PUSH CX                        
   PUSH DX                        

                        
        
      
      
      
    
      
       
     @READ_ARRAY1: 
     
     INDEC1: 
     PUSH BX
    PUSH CX
    PUSH DX 
   
    
  
    
    MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    BEGIN1: 
    
    XOR BX,BX
    XOR CX,CX
    
    MOV AH,1
    INT 21H
    
    
    
    REPEAT1:
    CMP AL,'0'
    JNGE LETTER1
    CMP AL,'9'
    JNLE LETTER1
    
    AND AX,000FH
    PUSH AX
    
    MOV AX,10
    MUL BX
    POP BX
    ADD BX,AX
    
    MOV AH,1
    INT 21H
  
    JMP REPEAT1
    
    LETTER1:
   
    
    MOV AX,BX
            

     
     
     
     
     
     
     
     
     
     
     
     
     
     
                       
                   

     MOV [SI], AX
     
                      
     ADD SI, 2
     SUB M,1
     
    
     
     CMP M,0
                       

                       
    JNE @READ_ARRAY1
     
   
    READ_ARRAY1  ENDP 
   
  
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    LEA DX,MSG4
    MOV AH,9
    INT 21H
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    
   
   
   
   
   
   
   
   
   
   
   
   
  
   
   LEA SI,B
   MOV BX,AX
   
   CALL READ_ARRAY
      
   READ_ARRAY PROC
   
  

   PUSH AX                       
   PUSH CX                        
   PUSH DX                        

  ; MOV ,4                     
        
      
      
      
      
      
       
     @READ_ARRAY: 
     
      INDEC: 
     PUSH BX
    PUSH CX
    PUSH DX  
    
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
   
    
  
    
  
    
    BEGIN: 
    
    XOR BX,BX
    XOR CX,CX
    
    MOV AH,1
    INT 21H
    
    
    
    REPEAT:
    CMP AL,'0'
    JNGE LETTER
    CMP AL,'9'
    JNLE LETTER
    
    AND AX,000FH
    PUSH AX
    
    MOV AX,10
    MUL BX
    POP BX
    ADD BX,AX
    
    MOV AH,1
    INT 21H
  
    JMP REPEAT
    
    LETTER:
   
    
    MOV AX,BX
            

     
    
     
     
     
     
     
     
     
     
     
     
                       
                   

     MOV [SI], AX
     
                      
     ADD SI, 2
     DEC N  
     
     CMP N,0
                       

                       
    JNE @READ_ARRAY
     
   
    READ_ARRAY  ENDP

    
   
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
    





    XOR BX,BX 
    
    LEA SI,A
   
    LEA DI,B
   
    ADDING: 
    
      
     MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H  
     

    
    
    
    
    
    XOR AX,AX
    MOV AX,[SI]
    ADD AX,[DI]
    ;MOV M,BX
    
    
    
    
     
    
    
    OUTDEC PROC 
  
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    OR AX,AX
    JGE @END_IF1
    PUSH AX
    MOV DL,'-'
    MOV AH,2
    INT 21H
    POP AX
    NEG AX
    
    @END_IF1:
    XOR CX,CX
    MOV BX,10D
    
    @REPEAT1:
    XOR DX,DX
    DIV BX
    PUSH DX
    INC CX
    OR AX,AX
    JNE @REPEAT1
    
    MOV AH,2
    
    @PRINT_LOOP:
    
    POP DX
    OR DL,30H
    INT 21H
    LOOP @PRINT_LOOP
    
    POP DX
    POP CX
    POP BX
    POP AX
   ; RET
   
OUTDEC ENDP
 
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
    ADD SI,2
    ADD DI,2
    DEC C
    
   
    
    
    
    CMP C,0
    JE ENDING
  
    JNE ADDING
    
    
    
   
   
    
             
    ENDING:         
    ;TERMINATION         
    MOV AH,4CH
    INT 21H
    
   
END MAIN
    
