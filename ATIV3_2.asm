TITLE numero
.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB "Digite um caractere:$"
NUMERO DB 10,13,"O caractere digitado e um numero.$"
LETRA DB 10,13,"O caractere digitado e uma letra.$"
DESCONHECIDO DB 10,13,"O caractere digitado e um caractere desconhecido.$"
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
;se o caractere em bl for menor que 48 ("0"), salta para o rotulo DESCONHECIDO2
JB DESCONHECIDO2
;compara o caractere em bl com o valor 57 (equivalente ao 9 no codigo ASCII)
CMP BL,57
;se o caractere for maior que 57, salta para o rotulo maiuscula
JA MAIUSCULA
;se chegou até aqui, exibe na tela que é um numero
MOV AH,9
MOV DX, OFFSET NUMERO
INT 21H
;salta para o rótulo fim
JMP FIM

;define o rotulo maiuscula
MAIUSCULA:
;compara o caractere de BL com 65 ("A")
CMP BL, 65
;se for menor que 65, salta para o rotulo DESCONHECIDO2
JB DESCONHECIDO2
;compara o caractere de BL com 90 ("Z")
CMP BL,90
;se for maior que 90, salta para o rotulo MINUSCULA
JA MINUSCULA
;se chegou até aqui, exibe na tela que é letra
MOV AH, 9
MOV DX, OFFSET LETRA
INT 21H
;salta para o rótulo fim
JMP FIM

;define o rotulo MINUSCULA
MINUSCULA:
;compara o caractere com 97("a")
CMP BL,97
;se for menor, salta para o rotulo DESCONHECIDO2
JB DESCONHECIDO2
;compara o caractere com 122("z")
CMP BL, 122
;se for maior que 122, salta para DESCONHECIDO2
JA DESCONHECIDO2
;se chegou até aqui, exibe na tela que é letra
MOV AH, 9
MOV DX, OFFSET LETRA
INT 21H
;salta para o rótulo fim
JMP FIM

;define o rótulo DESCONHECIDO2
DESCONHECIDO2:
;exibe na tela que é desconhecido
MOV AH,9
MOV DX, OFFSET DESCONHECIDO
INT 21H
;salta para o rótulo fim
JMP FIM

;define o rotulo fim
FIM:
;finaliza o programa
MOV AH,4Ch
INT 21H
END MAIN 