TITLE numero
.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB "Digite um caractere:$"
SIM DB 10,13,"O caractere digitado e um numero.$"
NAO DB 10,13,"O caractere digitado nao e um numero.$"
.CODE
MAIN PROC
;Permite o acesso às variáveis definidas em .DATA
MOV AX, @DATA
MOV DS, AX
;exibe na tela a string da msg1
MOV AH, 9
MOV DX, OFFSET MSG1
INT 21H
;lê um caractere do teclado e salva o caractere lido em ah
MOV AH,1
INT 21H
;copia o caractere lido para bl
MOV BL,AL
;compara o caractere em bl com o valor 48 (equivalente ao 0 no código ASCII)
CMP BL,48
;se o caractere em bl for menor que 48 ("0"), salta para o rotulo NAOENUMERO
JB NAOEUMNUMERO
;compara o caractere em bl com o valor 57 (equivalente ao 9 no codigo ASCII)
CMP BL, 57
;se o caractere em bl for maior que 57("9"), salta para NAOEUMNUMERO
JA NAOEUMNUMERO
;se chegou até aqui, exibe na tela que é um numero
MOV AH,9
MOV DX, OFFSET SIM
INT 21H
;salta para o rotulo FIM
JMP FIM
;define o rotulo NAOENUMERO
NAOEUMNUMERO:
;exibe na tela que nao é um numero
MOV AH, 9
MOV DX, OFFSET NAO
INT 21H
;define o rotulo fim
FIM:
;finaliza o programa
MOV AH,4Ch
INT 21H
END MAIN 

;4) O programa le um caractere digitado pelo usuario e compara-o com as posições na tabela ASCII correspondentes a 0 e 9, para determinar se o caractere é um numero.




