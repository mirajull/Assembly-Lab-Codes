.MODEL SMALL

.STACK 100H

.DATA

A DB ?
B DB ?
RES DB ?

.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,1
    INT 21H
    MOV A,AL
    MOV BL,AL
    INT 21H
    MOV B,AL
    MOV BH,AL
    
    
    
    CMP BL,B
    JE MULTIPLY
    JL SWAP
    JG MOD
    
    
    MULTIPLY:
    
    MOV AL,A
    IMUL B
    MOV RES,AL
    
    MOV AH,2
    MOV DL,RES
    INT 21H
    
    JMP NEXT
   
    
    SWAP:
    
    MOV AL,BL
    MOV BL,BH
    MOV BH,AL
    
    MOV A,BL
    MOV B,BH
   
    MOV AH,2
    MOV DL,A
    INT 21H
    MOV DL,10
    INT 21H
    MOV DL,','
    INT 21H
    MOV DL,B
    INT 21H
    
    JMP NEXT
    
    
    MOD:
                       
    MOV AL,A
    CBW 
    IDIV B
    MOV RES,AH
    
    
    MOV AH,2
    MOV DL,RES
    INT 21H
    
    NEXT:
    
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
    END MAIN