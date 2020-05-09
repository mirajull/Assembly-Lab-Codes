.MODEL SMALL
.STACK 100H 
.DATA
A1 DW 'GIVE OPTION: $'
A2 DW 'GIVE THE NUMBER: $'
A3 DW 'GIVE THE TWO NUMBERS: $'
A DW ?
B DW ?
C DW ?
.CODE
MAIN PROC  
    
    MOV AX,@DATA
    MOV DS,AX
 ABAR:
    LEA DX,A1
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
    
    MOV AH,1
    INT 21H
    CMP AL,31H
    JE PROTHOM     
    JMP DITIYO              
    
    PROTHOM:
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
    LEA DX,A2
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
    
    CALL INDECBIN 
    
    DITIYO:
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H     
    LEA DX,A3
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
    
    CALL INDECBIN   
    PUSH AX
    MOV B,AX
    XOR AX,AX
    XOR BX,BX
    XOR CX,CX
    XOR DX,DX
    MOV AH,2
    MOV DL,13    
    INT 21H
    MOV DL,10
    INT 21H
    CALL INDECBIN
    PUSH AX
    MOV C,AX 
    CALL GCD
    
    
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H
    
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
    
BINARY PROC
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
              
GCD PROC
    
    PUSH BP
    MOV BP,SP
    CMP WORD PTR[BP+4],0
    JNE KAJ
    
    MOV AH,2
    MOV DX,[BP+6]
    ADD DX,30H
    INT 21H
    JMP SESH
    
    KAJ:
    XOR DX,DX
    PUSH [BP+4]
    MOV AX,[BP+6]
    DIV [BP+4]
    PUSH DX  
    CALL BINARY
    
    
    SESH:
    POP BP
    RET 2
    
    GCD ENDP
    
    
INDECBIN PROC    
    PUSH BX
    PUSH CX
    PUSH DX 
    
    BEGIN:
    
    XOR BX,BX
    XOR CX,CX
    
    MOV AH,1
    INT 21H
    
    REPEAT2:
    
    AND AX,000FH
    PUSH AX 
    MOV AX,10
    MUL BX
    POP BX 
    ADD BX,AX
    
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JNE REPEAT2
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    MOV AX,BX   
    ;JMP YO
    ;OR CX,CX
    ;JE @EXIT
    PUSH AX
    CALL BINARY
    
      
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP ABAR
    

    INDECBIN ENDP

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
    RET
    OUTDEC ENDP    
END MAIN
