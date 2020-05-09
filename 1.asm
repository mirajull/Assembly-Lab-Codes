.MODEL SMALL
.STACK 100H


.DATA



M DW ?
N DW ? 
CAP DW ?

MAT1 DW 5 DUP (?)
     DW 5 DUP (?)  
     DW 5 DUP (?)
     DW 5 DUP (?)
     DW 5 DUP (?)

MAT2 DW 5 DUP (?)
     DW 5 DUP (?)
     DW 5 DUP (?)
     DW 5 DUP (?)
     DW 5 DUP (?)
     
MAT  DW 5 DUP (?)
     DW 5 DUP (?)
     DW 5 DUP (?)
     DW 5 DUP (?)
     DW 5 DUP (?)

.CODE

MAIN PROC 
    
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,1
    INT 21H
    MOV AH,0
    MOV M,AX
    SUB M,'0'
    
   
    MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H

    
    MOV AH,1
    INT 21H
    MOV AH,0
    MOV N,AX
    SUB N,'0'
    
    MOV AX,M
    MUL N
    MOV CAP,AX
    
    CALL INPUT1
    CALL INPUT2
    CALL SUM 
    CALL PRINT
    
    
MAIN ENDP



PROC INPUT1
    
    
    MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H

    MOV BX,0
    
    LOOP1:
         
         CMP BX,CAP
         JE END_LOOP1
         
         MOV AH,1
         INT 21H
         MOV AH,0
         SUB AL,'0'
         MOV MAT1[BX],AX
         
         INC BX
         
         MOV DX,0
         MOV AX,BX
         DIV N
         CMP DX,0
         JE NEXTLINE1
         
         JMP LOOP1  
         
         
         
         END_LOOP1: 
                   
           MOV AH,2
           MOV DL,0DH  ;CARRIAGE RETURN
           INT 21H
           MOV DL,0AH  ;LINE FEED
           INT 21H

            RET  
            
         NEXTLINE1:
         
           
            MOV AH,2
            MOV DL,0DH  ;CARRIAGE RETURN
            INT 21H
            MOV DL,0AH  ;LINE FEED
            INT 21H
            JMP LOOP1   
            

INPUT1 ENDP    

        
        
        

PROC INPUT2
            
    
    MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H

    
    MOV BX,0
    
    LOOP2:
         
         CMP BX,CAP
         JE END_LOOP2
         
         MOV AH,1
         INT 21H
         MOV AH,0
         SUB AL,'0'
         MOV MAT2[BX],AX
         
         INC BX
         
         MOV DX,0
         MOV AX,BX
         DIV N
         CMP DX,0
         JE NEXTLINE2
         
         JMP LOOP2  
         
         
         
         END_LOOP2: 
                     
            MOV AH,2
            MOV DL,0DH  ;CARRIAGE RETURN
            INT 21H
            MOV DL,0AH  ;LINE FEED
            INT 21H

            RET  
            
         NEXTLINE2:
         
            
            MOV AH,2
            MOV DL,0DH  ;CARRIAGE RETURN
            INT 21H
            MOV DL,0AH  ;LINE FEED
            INT 21H

            JMP LOOP2   

INPUT2 ENDP 


PROC SUM
    
    MOV BX,0
    
    LOOP3:
    
        CMP BX,CAP
        JE END_LOOP3
        
        MOV CX,MAT1[BX]
        ADD CX,MAT2[BX]
        
        MOV MAT[BX],CX
        
        ADD BX,1
        
        JMP LOOP3
        
    
    END_LOOP3:
        
        RET 
            
            
SUM ENDP


 
 
PROC PRINT NEAR
    
    MOV SI,0
    MOV BX,0
    
  
    MOV AH,2
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H
    MOV DL,0AH  ;LINE FEED
    INT 21H
  
    LOOP4:
    
        CMP BX,CAP
        JE END_LOOP4
        
        MOV CX,0
        MOV CX,N
        MOV SI,0
        
        LOOP5:
            
            MOV DX,0
            MOV DX,MAT[BX][SI]
            ADD DX,'0'
            MOV AH,2
            INT 21H
            
            INC SI
            LOOP LOOP5
            
        
        
        MOV AH,2
        MOV DL,0DH  ;CARRIAGE RETURN
        INT 21H
        MOV DL,0AH  ;LINE FEED
        INT 21H

        ADD BX,N
        JMP LOOP4
        
        END_LOOP4:
            
            RET
              
              
PRINT ENDP


END MAIN
    
    
    
    
    
