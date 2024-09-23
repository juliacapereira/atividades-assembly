TITLE repeat
.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB "Digite os caracteres desejados:$"
    MSG2 DB "Resultado:$"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    ;imprime a msg1
    MOV AH,9
    MOV DX,OFFSET MSG1
    INT 21H
    ;atribui 0 a cx
    XOR CX,CX
    ; Lê um caractere do teclado e salva o caractere lido em AL
    MOV AH,1
    CONTADOR:
    INT 21H
    ;Incrementa um a CX
    INC CX
    ;Compara AL (os caracteres inseridos) com 13D (correspondente ao espaço na tabela ASCII)
    CMP AL,13D
    ;Salta para o inicio da função se 13D não for igual a AL
    JNE CONTADOR
    ;Imprime a MSG2 na tela
    MOV AH,9
    MOV DX,OFFSET MSG2
    INT 21H
    

    ASTERISCO:
    ;Imprime '*' na tela
    MOV DL,'*'
    MOV AH,2
    INT 21H
    ;Faz ASTERISCO entrar em loop (que decresce um de cx enquanto cx for diferente de 0)
    LOOP ASTERISCO
    ;Finaliza o programa
    MOV AH,4Ch
    INT 21H

    MAIN ENDP 
    END MAIN

   
;A difereça entre este programa e o programa da parte 1 é que este imprime um asterisco a mais que os caracteres inseridos pois conta o enter como um caracter inserido