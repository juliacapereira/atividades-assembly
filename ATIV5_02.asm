TITLE asterisco
.MODEL SMALL
.STACK 100h
.CODE
MAIN PROC
              MOV  CX,50D       ;CL assume o valor de CL

    IMPRESSAO:
    ;imprime o asterisco
              MOV  AH,2
              MOV  DL, "*"
              INT  21H

    ;exibe o caracter line feed (move o cursor pra proxima linha)
              MOV  AH,2
              MOV  DL,10
              INT  21h
    ;insere o loop que decresce CX até que chegue em 0
              LOOP IMPRESSAO
    ;finaliza o programa
              MOV  AH, 4Ch
              INT  21H

MAIN ENDP
    END MAIN