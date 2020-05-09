TITLE:BINARY CONVERSION

.MODEL SMALL

.STACK 100H


.DATA
;M DW 2

.CODE



MAIN PROC
    
    ;CALL INDEC
    
    MOV AX,12
    MOV BX,2
    PUSH AX
    CALL BINARY
    
    MOV AH,4CH
    INT 21H 
    
    MAIN ENDP

BINARY PROC NEAR
    
    PUSH BP
    MOV BP,SP
    CMP [BP+4],0
    JNE KAJ_HOBE
    JMP RETURN
    
    
    
KAJ_HOBE:
    XOR DX,DX
    MOV AX,[BP+4]
    DIV BX
    PUSH AX
    CALL BINARY
    
    MOV AX,[BP+4]
    XOR DX,DX
    DIV BX
    
    MOV AH,2
    ADD DX,30h
    INT 21H
               
    
     
RETURN: 
    POP BP
    RET 2
     
    
    BINARY ENDP  






INDEC PROC
;AX HOLDS THE INPUT


    PUSH BX
    PUSH CX
    PUSH DX

    @BEGIN:

    XOR BX,BX

    XOR CX,CX

    MOV AH,1
    INT 21H

    CMP AL,'-'
    JE @MINUS
    CMP AL,'+'
    JE @PLUS
    JMP @REPEAT2

    @MINUS:
    MOV CX,1

    @PLUS:
    INT 21H

    @REPEAT2:
    CMP AL,'0'
    JNGE @NOT_DIGIT
    CMP AL,'9'
    JNLE @NOT_DIGIT

    AND AX,000FH
    PUSH AX

    MOV AX,10
    MUL BX
    POP BX
    ADD BX,AX

    MOV AH,1
    INT 21H
    CMP AL,0DH
    JNE @REPEAT2

    MOV AX,BX

    OR CX,CX
    JE @EXIT

    NEG AX

    @EXIT:
    POP DX
    POP CX
    POP BX
    RET

    @NOT_DIGIT:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP @BEGIN
    INDEC ENDP

 END MAIN
