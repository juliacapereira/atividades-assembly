TITLE ATIV8
.MODEL SMALL
.STACK 100h
.DATA
MSG1 DB "DIGITE UM NUMERO HEXADECIMAL (DE 0 A 9 OU A A F): $"
MSG2 DB 13,10,"O NUMERO HEXADECIMAL EH: $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS, AX

    ;imprime a string msg1
    MOV AH,9
    LEA DX,MSG1
    INT 21H

    ;atribui o valor 4 para cx
    MOV  CX, 4
    ;zera bx
    XOR  BX, BX
    ;começa a leitura dos caracteres
    MOV  AH,1      
    LERCARACTER:   
        ;efetivamente lê os caracteres
        INT  21H
        ;compara AL com 0DH ou 13d (enter) e se for igual, pula para fim
        CMP  AL,0DH    
        JE FIM
        ;compara AL (caracter lido) com 39h (9 na tabela ascii)
        CMP  AL,39H    
        ;se for maior, pula para letra
        JA   LETRA
        ;substitui o sub al,30h para encontrar o correspondente na tabela (o numero entra em hexa e com o and al,0fh cai de volta para 
        AND AL,0FH         ;sua forma natural, ex. 7 entra como 37h e com o and ele se torna 7h, que o programa registra como 7)
        JMP NUMERO
    LETRA:
        ;converte a-f para 10-15
        SUB AL,55d ;ex. A entra como 41h, que corresponde a 65d, quando subtrai 55d vai para 10d que corresponde a A em hexa 
    NUMERO:
        ;desloca bx 4 posições para a esquerda
        SHL BX,4
        ;insere os novos caracteres (al) em bl
        OR BL,AL
        ;coloca lercaracter em loop
        LOOP LERCARACTER
        ;imprime a msg2
        MOV AH,9
        LEA DX, MSG2
        INT 21H

    ;atribui 4 a cx como contador dos digitos que serão impressos (hexa possui 4 numeros)
    MOV CX, 4
    IMPRIMIR:
    ;move os caracteres inseridos NOS HIGH BYTES DE BX (os 2 primeiros caracteres de BX, ex: 78BA, o 78)
    ;para O LOW BYTE DE dl (entra em dl como 0078)
    MOV DL, BH 
    ;desloca 4 para  direita (ex. entra 0078, dai desloca 4 para a direita e fica 0007 para imprimir somente o caracter desejado)
    SHR DL,4
    ;compara dl com 10 (se for menor, é numero então vai para numeroinverso para imprimir o caracter)
    CMP DL, 10
    JB NUMEROINVERSO

    ;adiciona 55d de volta ao caracter para ir a letra correspondente seguindo a parte hexa da tabela 
    LETRAINVERSO: ;(para que a impressão ocorra corretamente) ex. A entra como 41h no programa, subtrai 55d para ele cair 
    ADD DL, 55d ;na parte da tabela onde o hexa corresponde a A e assim ler A em vez de 41h, 
    MOV AH,2 ;porém para imprimir o programa deve receber o HEXA, então devolve-se a posição da tabela onde a impressão é A, ou seja, 41h
    MOV DL,DL ; ou seja, 41h e imprime o caracter armazenado em dl
    INT 21H

    ;desloca 4 posições para a esquerda em bx (tira de bx o numero já impresso, por ex. se era 78BA, fica 8BA0)
    SHL BX,4
    ;decresce 1 em cx pois já imprimiu um caracter 
    DEC CX
    ;compara cx com 0 pois se for 0 já imprimiu todos
    CMP CX,0
    ;se nao for igual, ou seja não é 0
    JNE IMPRIMIR
    ;se for igual pula pra finalizar o programa
    JE FIM

    ; adiciona 30h ao caracter que tá sendo lido, para devolve-lo ao seu correspondente em hexa e ser impresso correto 
    NUMEROINVERSO:;ex. digita 7, que entra como 37h, la no começo para o programa fazemos and al,0fh que o leva a 07h
    OR DL,30H ;para o programa ler ele como 7, porém o programa só imprime em hexa, e 7h corresponde a bell na tabela ascii, então
    MOV AH,2 ;devolvemos 30h para o programa interpretar como 37h, que na tabela ascii imprime 7
    MOV DL,DL
    INT 21H

    ;desloca bx 4 caracteres para a esquerda (tira de bx o numero já impresso, por ex. se era 78BA, fica 8BA0)
    SHL BX,4
    DEC CX
    CMP CX,0
    JNE IMPRIMIR
        ;finaliza o programa
    FIM:
        MOV  AH,4CH
        INT  21H
MAIN ENDP
END MAIN