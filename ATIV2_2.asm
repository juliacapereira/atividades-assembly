TITLE ativ2
.MODEL SMALL
.DATA
MSG1 DB "Digite um primeiro numero:$"
MSG2 DB 10,13, "Digite um segundo numero:$"
MSG3 DB 10,13, "A soma dos dois numeros e:$"
.CODE
MAIN PROC

; Permite o acesso às variáveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

; Exibe na tela a string MSG1
MOV AH,9
LEA DX,MSG1
INT 21h

; Lê um caracter do teclado e salva o caracter lido em AL
MOV AH,1
INT 21h

; Copia o caracter lido para BL e subtrai 30 em hexadecimal
MOV BL,AL
SUB BL,30h

; Exibe o caracter Line Feed (move o cursor para a linha seguinte)
MOV AH,2
MOV DL,10 
INT 21h

; Exibe o caracter Carriage Return (move o cursor para o canto esquerdo da tela)
MOV AH,2
MOV DL,13 
INT 21h

; Exibe na tela a string MSG2
MOV AH,9
LEA DX,MSG2
INT 21h

; Lê um caracter do teclado e salva o caracter lido em AL
MOV AH,1
INT 21h

; Copia o caracter lido para BH e subtrai 30 em hexadecimal
MOV BH,AL
SUB BH,30h

; Exibe o caracter Line Feed (move o cursor para a linha seguinte)
MOV AH,2
MOV DL,10 
INT 21h

; Exibe o caracter Carriage Return (move o cursor para o canto esquerdo da tela)
MOV AH,2
MOV DL,13 
INT 21h

; Soma os caracteres inseridos e adiciona 30 em hexadecimal
ADD BL,BH
ADD BL,30h

; Exibe na tela a string MSG3
MOV AH,9
LEA DX,MSG3
INT 21h

; Exibe o caracter lido (salvo em BL)
MOV AH,2
MOV DL, BL
INT 21h

; Finaliza o programa
MOV AH,4Ch
INT 21h
MAIN ENDP
END MAIN