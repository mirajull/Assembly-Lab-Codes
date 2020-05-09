.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB 'SUBSTRING',0DH,0AH,'$'
MSG2 DB 0DH,0AH,'MAINSTRING',0DH,0AH,'$'
MSG3 DB 0DH,0AH,'REVERS STRING','$'

MAINSTRING DB 100 DUP(0)
SUBSTRING DB 100 DUP(0) 
;NEWSTRING DB 100 DUP(0)

FINISH DW ? 

START DW ?
LENGTH DW ?                                  

.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    LEA DI,SUBSTRING
    CALL INPUT
    MOV LENGTH,BX
    
    LEA DX,MSG3
    INT 21H
    
    
    MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
  
    LEA SI,SUBSTRING+BX-1
    LEA DI,SUBSTRING
    
    MOV CX,BX
    SHR CX,1
    REV:
    MOV AL,[SI]
    XCHG AL,[DI]
    MOV [SI],AL
    SUB SI,1
    ADD DI,1 
    LOOP REV
     
    
    
    
    
     
    MOV CX,BX
    LEA SI,SUBSTRING 
    MOV BX,0 
    
    DISPLAY:
     
    
    MOV DX,[SI+BX] 
    MOV AH,2
    INT 21H
    ADD BX,1
    LOOP DISPLAY
    
   
    
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    LEA DI,MAINSTRING
    CALL INPUT
    
    OR BX,BX 
    
    
    MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H 
  
    
    LEA SI,SUBSTRING
    LEA DI,MAINSTRING
    CLD
           
    MOV FINISH,DI   
    ADD FINISH,BX 
    MOV CX,LENGTH
    MOV START,DI 
    REPEAT: 
    MOV CX,LENGTH
   
    MOV DI,START
    LEA SI,SUBSTRING 
    
    REPE CMPSB
    JE YES
    MOV DI,START
    MOV DX,[DI]
    MOV AH,2
    INT 21H
    INC START
    MOV AX,START
    CMP AX,FINISH
 
    JNLE ENDING
    JMP REPEAT
    YES:
    MOV AX,0
    MOV AX,START
    ADD AX,LENGTH 
    MOV START,AX
    JMP REPEAT
  
    
    
; MAIN ENDP


 INPUT PROC NEAR    
    
    PUSH AX
    PUSH DI
    CLD
    XOR BX,BX
    MOV AH,1
    INT 21H
    FOR:
    CMP AL,0DH
    JE ENDI
    CMP AL,8H
    JNE THAN
    
    DEC DI
    DEC BX
    JMP GO
    THAN:
    STOSB
    INC BX
    GO:
    INT 21H
    JMP FOR
    ENDI:
    POP DI
    POP AX
    RET
 ENDING: 
 MOV AH,4CH
 INT 21H

END MAIN
    
    
    