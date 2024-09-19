TITLE alfabeto
.MODEL SMALL
.STACK 100h
.CODE
MAIN PROC
    MOV CX,26 ;CX assume o valor 26
    MOV DL,41H ;DL assume o valor 41h da tabela ASCII ("A")

    MAIUSCULA:
    ;imprime na tela a sequencia
    MOV AH,2
    INT 21h
    ;incrementa um a DL
    INC DL
    ;o loop faz a impressão de 26 caracteres a partir das mudanças de DL
    LOOP MAIUSCULA

;exibe o caracter line feed (move o cursor pra proxima linha)
    MOV AH,2
    MOV DL,10
    INT 21h

;move o cursor para a esquerda da tela
    MOV AH,2
    MOV DL,13
    INT 21h

;reinicia o código anterior porém começando do valor 61h da tabela ASCII("a")
    MOV CX,26
    MOV DL,61H

    MINUSCULA:
    MOV AH,2
    INT 21h
    INC DL
    LOOP MINUSCULA

;finaliza o código
    MOV AH,4Ch
    INT 21h

    MAIN ENDP
    END MAIN