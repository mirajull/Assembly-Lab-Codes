.model small

.stack 100h

.DATA
      
A DW ?
B DW ?
C DW ?
    
.CODE

MAIN PROC


MOV AX,@DATA
MOV DS,AX

;INPUT
MOV AH,1
INT 21H
SUB AX,30h
MOV A,AX
ADD C,AX

MOV AH,2
MOV DL,0DH  ;CARRIAGE RETURN
INT 21H
MOV DL,0AH  ;LINE FEED
INT 21H

MOV AH,1
INT 21H
SUB AX,30h
MOV B,AX
ADD C,AX


MOV AH,2
MOV DL,0DH  ;CARRIAGE RETURN
INT 21H
MOV DL,0AH  ;LINE FEED
INT 21H

MOV AH,2
MOV DL,0DH  ;CARRIAGE RETURN
INT 21H
MOV DL,0AH  ;LINE FEED
INT 21H
        
MOV AH,2
MOV DX,C
ADD DX,30h
INT 21H
  
;TERMINATION         
MOV AH,4CH
INT 21H

MAIN ENDP
END MAIN