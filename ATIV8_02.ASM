TITLE ATIV8
.MODEL small
.STACK 100h
.DATA
MSG1 DB "INSIRA UMA SEQUENCIA DE 1S E 0S:$"
MSG2 DB "A SEQUENCIA LIDA E:$"
.CODE
MAIN PROC
MOV AX, @DATA
MOV DS, AX

;IMPRIME A MSG1 NA TELA
MOV AH,9
LEA DX, MSG1
INT 21H

;ZERA BX
XOR BX,BX
;atribui 17 a cx para ler o 16º caracter
MOV CX,17

;LÊ CADA CARACTER DIGITADO
MOV AH,1

LERCARACTER:
    ;se cx=0, passa para o print inicial pois já leu todos os caracteres
    CMP CX,0   
    JE PRINTINICIAL

    ;se cx for diferente de 0, continua lendo o caracter digitado
    INT 21H 

    CMP AL,0DH  ;se o caracter digitado for igual a 0DH, ou seja, 13D (carriage return, ou enter), passa para print inicial pois 
    JE PRINTINICIAL ;o usuário já digitou o que queria

    ;realiza a operação and entre Al(caracter digitado) e 0fh(15D ou 0000 1111b) para converter o codigo ASCII de um num em seu binario
    AND AL,0Fh 

    ;desloca para esquerda uma casa de BX
    SHL BX,1 

    ;realiza a operação lógica or entre Al(caracter digitado) e BL(o que está armazenado em BX) 
    OR BL, AL 
    
    ;põe lercaracter em loop até que cx=0
    LOOP LERCARACTER

PRINTINICIAL:
    ;atribui 16 a cx para a impressão dos caracteres digitados
    MOV  CX, 16

    ;imprime a msg2
    MOV AH,9
    LEA DX, MSG2
    INT 21H

    ;começa a imprimir os caracteres lidos
    MOV AH, 02

ESCCARACTER:
    ;rotaciona 1 casa de bx para a esquerda
    ROL  BX,1

    ;se o carry (digito que sai) for 0, salta para zero
    JNC ZERO

    ;imprime '1' (=31h na tabela ascii)
    MOV DL,31H

    ;salta para imprime (que inclui o 21h para realmente exibir no monitor e encerra o programa)
    JMP IMPRIME

ZERO:
    ;imprime '0' (=30h na tabela ascii)
    MOV DL,30H

IMPRIME:
    ;exibe os caracteres na tela
    INT 21H

    ;faz esccaracteres entrar em loop para imprimir todos os caracteres até que cx=0
    LOOP ESCCARACTER
    
    ;finaliza o programa
    MOV  AH,4CH
    INT  21H
MAIN ENDP
END MAIN