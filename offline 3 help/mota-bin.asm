TITLE:BINARY CONVERSION

.MODEL SMALL

.STACK 100H
;Input DW ?

.DATA

.CODE

MAIN PROC
    
    MOV AH,1
    INT 21H
    ;MOV Input,AX
    MOV AH,0
    ;MOV AX,3
    MOV BX,2
    PUSH AX
    CALL BINARY
    
    MOV AH,4CH
    INT 21H 
    
    MAIN ENDP

BINARY PROC NEAR
    
    PUSH BP
    MOV BP,SP
    CMP WORD PTR[BP+4],0
    JNE KAJ_HOBE
    JMP RETURN
    
    
    
KAJ_HOBE:
    XOR DX,DX
    MOV AX,[BP+4]
    MOV BX,2
    DIV BX
    PUSH AX
    CALL BINARY
    MOV AX,[BP+4] 
    XOR DX,DX
    MOV BX,2
    DIV BX
    MOV AH,2
    ADD DX,30H
    INT 21H
               
    
     
RETURN: 
    POP BP
    RET 2
     
    
    BINARY ENDP

END MAIN
