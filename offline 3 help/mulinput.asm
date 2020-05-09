.MODEL SMALL
.STACK 100H 
.DATA
S1 DW 'GIVE OPTION: $'
S2 DW 'GIVE THE NUMBER: $'
S3 DW 'GIVE THE TWO NUMBERS: $'
A DW ?
B DW ?
C DW ?
.CODE
MAIN PROC  
    
    MOV AX,@DATA
    MOV DS,AX
 YAHOO:
    LEA DX,S1
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    MOV AH,1
    INT 21H
    CMP AL,31H
    JE ONEINPUT               ;1
    JMP TWOINPUT               ;2
    
    ONEINPUT:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    LEA DX,S2
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    CALL INDECBIN 
    ;JMP YAHOO     
    ;PUSH AX             ;1 INPUT
    ;MOV A,AX
    ;CALL BIN            ; BIN PROC
    ;CALL OUTDEC
    
    TWOINPUT:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H     
    LEA DX,S3
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    CALL INDECBIN          ;1ST INPUT
    PUSH AX
    MOV B,AX
    XOR AX,AX
    XOR BX,BX
    XOR CX,CX
    XOR DX,DX
    MOV AH,2
    MOV DL,0DH          ;NEWLINE
    INT 21H
    MOV DL,0AH
    INT 21H
    CALL INDECBIN          ;2ND INPUT
    PUSH AX
    MOV C,AX 
    CALL GCD
    
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    ;POP AX
    ;CALL OUTDEC
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
    
BIN PROC
    PUSH BP
    MOV BP,SP
    CMP WORD PTR[BP+4],0
    JNE @DIVBY2
    JMP RETURN
    
    @DIVBY2:
    XOR DX,DX
    MOV AX,[BP+4] 
    MOV BX,2
    DIV BX
    PUSH AX 
    CALL BIN
    
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
    
    BIN ENDP          
              
GCD PROC            ;;;;;;;;;
    
    
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
    CALL BIN
    
      
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP YAHOO
    
    ;JMP BEGIN
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
