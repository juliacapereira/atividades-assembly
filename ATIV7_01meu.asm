TITLE prova
.model small
.stack 100h
.DATA
    msg1 db 13,10,"Digite o dividendo:$"
    msg2 db 13,10,"Digite o divisor:$"
    msg3 db 13,10,"Quociente:$"
    msg4 db 13,10,"Resto:$"
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        XOR CH,CH

        MOV AH,9
        MOV DS, OFFSET msg1
        INT 21H

        mov ah,1
        INT 21H
        mov bl,al
        SUB bl,30H
        

        mov ah,9
        mov ds,offset msg2
        int 21H                     

        mov ah,1
        INT 21H
        mov cl,al
        SUB CL,30H

CONTA1:
        cmp Bl, Cl
        JB CONTA2
        sub bl,cl
        INC CH
        cmp Bl,Cl
        JAE CONTA1


CONTA2:
        MOV AH,9
        MOV DX, OFFSET msg3
        INT 21H

        ADD CH,30H;
        MOV AH,2
        MOV DL,CH
        INT 21H

        MOV AH,9
        MOV DX, OFFSET msg4
        INT 21H

        ADD BL, 30H;
        MOV DL, BL
        MOV AH, 2
        INT 21H


        FIM:
        mov ah,4ch
        int 21H
    
        main endp
        END MAIN



