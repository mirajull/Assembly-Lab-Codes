.MODEL SMALL
.STACK 100H
.DATA
VAR1 DB ?
VAR2 DB ?
S1 DB '   Both of inputs are not letters.$'
.CODE
MAIN PROC
    
    
    MOV AX,@DATA
    MOV DS,AX
    
    L:
    
    MOV AH,1
    INT 21H
    MOV BL,AL    ;C
    CMP BL,20H   ; SPACE FOR EXIT
    JE EXIT
    INT 21H
    MOV BH,AL    ;c
    
    
    
    ; CHECK BL
    
    CMP BL,41H         ;A->41H
    JGE C1       
    JMP NOTLETTER      ; PRINT NOT CHAR
    
    C1:
    CMP BL,5AH
    JLE YO             ;CAP LETTER
    JG C2
    
    C2:
    CMP BL,61H
    JGE C3
    JMP NOTLETTER      ; NOT CHAR
    
    C3: 
    CMP BL,7AH
    JLE YO
    JMP NOTLETTER      ;NOT CHAR
    
    
    
    ;CHECK BH
    
    YO:    
    CMP BH,41H         ;A->41H
    JGE CC1       
    JMP NOTLETTER      ; PRINT NOT CHAR
    
    CC1:
    CMP BH,5AH
    JLE CHAR1           ;CAP LETTER
    JG CC2
    
    CC2:
    CMP BH,61H
    JGE CC3
    JMP NOTLETTER       ; NOT CHAR
    
    CC3: 
    CMP BH,7AH
    JLE CHAR1
    JMP NOTLETTER       ;NOT CHAR
      
    
    
    CHAR1:
    
    CMP BL,BH
    JE L1     ;C C c c
    JG L2     ;c C
    JL L3     ;C c
   
    
    L1:
    MOV VAR1,BL  ; INPUT+4
    ADD VAR1,4
    JMP LL1
    
    LL1:
    MOV AH,2
    MOV DL,BL   ;POR POR 4 LETTER PRINT
    INT 21H
    INC BL
    CMP VAR1,BL
    JE REPEAT                 ;REPEAT
    LOOP LL1
    
    
    L2:
    MOV CL,BL
    SUB CL,20H
    CMP BH,CL
    JE L1
    JMP DIFFCHAR    ;ONNO KOTHAO

    
    L3:
    MOV CL,BL
    ADD CL,20H
    CMP BH,CL
    JE L1
    JMP DIFFCHAR    ;ONNO KOTHAO
    
    
    DIFFCHAR:  
    
    MOV VAR2,BH
    CMP BL,61H
    JGE U1
    JMP U2
    
    
    
    U1:
    CMP BH,61H       ;bH Xz
    JGE D1
    JMP DD2
    
    U2:
    CMP BH,61H
    JGE DD1
    JMP D1
 
    
    DD1:
    SUB VAR2,1FH
    JMP D1
    
    DD2:
    ADD VAR2,21H
    JMP D1
    
    D1:
    MOV AH,2
    MOV DL,BL
    INT 21H
    INC BL
    CMP VAR2,BL
    JE REPEAT         ; REPEAT
    LOOP D1 
    
    
    NOTLETTER:
    LEA DX,S1         ; IF BOTH ARE NOT LETTER
    MOV AH,9
    INT 21H
    
    
    REPEAT:
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    JMP L
               
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    