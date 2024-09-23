TITLE while
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
    ;Compara AL (os caracteres inseridos) com 13D (correspondente ao espaço na tabela ASCII)
    CMP AL,13D
    ;Salta para a função mensagem
    JE MENSAGEM
    ;Incrementa um a CX
    INC CX
    ;salta para o inicio da função atual
    JMP CONTADOR
    
    ;Imprime a MSG2 na tela
    MENSAGEM:
    MOV AH,9
    MOV DX,OFFSET MSG2
    INT 21H
    JMP ASTERISCO ;Salta para a função asterisco
    

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

   
