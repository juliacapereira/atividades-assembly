TITLE asterisco
.MODEL SMALL
.STACK 100h
.CODE
MAIN PROC
              MOV BL, 0D ;BL assume o valor de 0D
              MOV CL,50D ;CL assume o valor de CL
              CMP BL,CL ;compara CL com BL

    IMPRESSAO:
    ;imprime o asterisco
              MOV AH,2
              MOV DL, "*"
              INT 21H
    ;exibe o caracter line feed (move o cursor pra proxima linha)
              MOV AH,2
              MOV DL,10
              INT 21h
    ;decresce 1 de CL 
              DEC CL
    ;salta se CL for maior ou igual a BL
              JG IMPRESSAO
    ;finaliza o programa
              MOV AH, 4Ch
              INT 21H

MAIN ENDP
    END MAIN

