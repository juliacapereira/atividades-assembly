TITLE calculadora
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB "digite um caractere:$"
    MSG2 DB "seus caracteres somados dao:$"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,5

    CARACTERES:
    MOV AH,9
    MOV DX, OFFSET MSG1
    INT 21H

    MOV AH,1
    INT 21H

    MOV BL,AL
    SUB BL,30H
    ADD BH,BL
    LOOP CARACTERES     

    MOV AH,2
    MOV DL,10
    INT 21H

    MOV AH,2
    MOV DL,13
    INT 21H
    
    MOV AH,9
    MOV DX,OFFSET MSG2
    INT 21H

    ADD BH,30H
    MOV AH,2
    MOV DL,BH
    INT 21H

    MOV AH,4CH
    INT 21H

    MAIN ENDP
    END MAIN
