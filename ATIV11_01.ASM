TITLE ATIVIDADE11
.MODEL SMALL
.STACK 100H
pula_linha macro
    PUSH AX
    PUSH DX
    MOV AH,02
    MOV DL,10
    INT 21H
    POP DX
    POP AX
endm
.DATA
ENTRADA DB "EM QUAL BASE SERA A ENTRADA? (1-BINARIA; 2-HEXA; 3-DECIMAL)$"
NUMERO DB "DIGITE O NUMERO NA BASE DESEJADA: $"
SAIDA DB "EM QUAL BASE SERA A SAIDA? (1-BINARIA; 2-HEXA; 3-DECIMAL)$"
SAIDANABASE DB "A SAIDA NA BASE DESEJADA E: $"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;IMPRIME A MSG PEDINDO A BASE DE ENTRADA
    MOV AH,9
    LEA DX,ENTRADA
    INT 21H
    ;LE O N DA BASE DESEJADA
    MOV AH,1
    INT 21H
    ;TIRA 30H PARA LER O NUMERO CORRETAMENTE
    AND AL,0FH
    ;JOGA O NUMERO PARA CL
    MOV CL,AL

    ;CHAMA O PROC BASES (QUE LE O NUMERO NA BASE DESEJADA)
    CALL BASES

    ;PULA LINHA COM A MACRO
    pula_linha

    ;IMPRIME A MSG PEDINDO QUAL SERA A BASE DE SAIDA
    MOV AH,9
    LEA DX,SAIDA
    INT 21H
    ;LE O NUMERO DA BASE DESEJADA
    MOV AH,1
    INT 21H
    ;TIRA 30H PARA LER O NUMERO CERTO
    AND AL,0FH
    ;JOGA O NUMERO PARA CL
    MOV CL,AL
    ;CHAMA O PROC SAIDAS (QUE IMPRIME O NUMERO NA BASE DESEJADA)
    CALL SAIDAS

    ;FINALIZA O PROGRAMA
    MOV AH,4CH
    INT 21H

    MAIN ENDP

    BASES PROC
        ;pula linha com a macro
        pula_linha
        ;imprime a msg pedindo para inserir o numero
        MOV AH,9
        LEA DX,NUMERO
        INT 21H

        ;compara o numero da base desejada com as bases possiveis
        CMP CL,1
        JE BINARIA
        CMP CL,2
        JE HEXA
        CMP CL,3
        JE DECIMAL

        ;inicia a leitura do numero na base binaria
        BINARIA:
        XOR CX,CX ;zera cx
        XOR BX,BX ;zera bx
        XOR AX,AX ;zera ax
        MOV CX,16 ;cx=16
        MOV AH,1
            LERBINARIO:
                INT 21H ;le o caracter digitado
                CMP AL,13 ;compara o caracter digitado com o enter
                JE FIM ;se for enter, vai pro fim (que retorna ao principal)
                AND AL,0FH ;subtrai 30h
                SHL BX,1 ;desloca bx uma casa para a esquerda
                OR BL,AL ;realiza or entre al e bl e armazena o resultado em bl (preserva onde tem 1 inserindo em bl)
            LOOP LERBINARIO ;le até 16 caracteres
        JMP FIM ;retorna ao main quando termina de ler os 16 caracteres
        ;binario ta lendo certo (teste com 1111001111000000 que dá F3C0)**********

        HEXA:
        XOR CX,CX ;zera cx
        XOR BX,BX ;zera bx
        XOR AX,AX ;zera ax
        MOV CX,4 ;le ate 4 caracteres inseridos
        MOV AH,1
            LERHEXA:
                INT 21H ;le o caracter inserido
                CMP AL,13 ;compara com enter, se for enter vai pro fim que retorna pro main
                JE FIM
                CMP AL,39h ;compara al com 39h, se for menor o igual é numero e vai para numero2
                JBE NUMERO2
                SUB AL,55D 
                OR BL,AL ;realiza or entre al e bl e armazena o resultado em bl (preserva onde tem 1 inserindo em bl)
                DEC CX ;decremente cx
                CMP CX,0 ;compara cx com 0, se for 0 ja leu todos os caracteres e volta ao main
                JE FIM
                SHL BX,4 ;desloca bx 4 casas para esquerda
                JMP LERHEXA ;volta ao lerhexa

                NUMERO2:
                    AND AL,0FH ;subtrai 30h para cair no numero correspondente
                    OR BL,AL ;realiza or entre al e bl e armazena o resultado em bl (preserva onde tem 1 inserindo em bl)
                    DEC CX ;decrementa 1 de cx
                    CMP CX,0 ;compara cx com 0, se for 0 vai para fim que retorna ao main
                    JE FIM
                    SHL BX,4 ;desloca bx 4 casas para esquerda
                    JMP LERHEXA ;ta lendo certinho hexa (se digitar 8FA7 BX armazena 8FA7)************

        ;permite que o usuário insira o número desejado em decimal (sempre informando primeiro o sinal desejado, se negativo '-', se positivo '+')
        DECIMAL:
        XOR BX,BX
        MOV AH,1
        INT 21H ;LE O SINAL
        MOV CL,AL
            LERDECIMAL:
                MOV AH,1
                INT 21H
                CMP AL,13
                JE CONFERENEG
                AND AL,0FH
                XOR AH,AH
                PUSH AX
                MOV AL,10
                MUL BX
                POP BX
                ADD BX,AX
                JMP LERDECIMAL

            CONFERENEG:
                CMP CL,'-'
                JE NEGATIVO
                JMP FIM
            NEGATIVO:
                NEG BX
        
        FIM:
        RET

        BASES ENDP


        SAIDAS PROC
            ;pula linha com a macro
            pula_linha
            ;imprime a mensagem de que o numero na base desejada é
            MOV AH,9
            LEA DX, SAIDANABASE
            INT 21H

            ;compara o numero inserido com as bases possíveis (numero digitado no main)
            CMP CL,1
            JE BINARIA2
            CMP CL,2
            JE HEXA2
            CMP CL,3
            JE DECIMAL2

            ;deseja imprimir na base binaria
            BINARIA2:
            MOV CX,16 ;cx=16 para imprimir 16 caracteres binarios)
                IMPRIMEBINARIO:
                SHL BX,1 ;desloca bx uma casa para a esquerda
                JC UM ;se o carry(numero que saiu) for 1, pula para um
                MOV AH,2 ;se nao, significa que o numero que saiu foi 0 e imprime 0
                MOV DL,'0'
                INT 21H
                DEC CX ;decrementa cx 
                CMP CX,0 ;compara cx com 0, se for 0, volta ao main
                JE FIM2
                JMP IMPRIMEBINARIO ;volta ao começo para continuar imprimindo os proximos caracteres

                UM:
                MOV AH,2 ;o carry foi um, então imprime 1
                MOV DL,'1'
                INT 21H
                DEC CX ;decrementa cx pois imprimiu caracter
                CMP CX,0 ;compara c com 0, se for 0 volta ao main
                JE FIM2
                JMP IMPRIMEBINARIO ;retorna ao imprimebinario
                ;ta imprimindo de binario para binario certo e de hexa para binario tbm ta imprimindo certo*******

            HEXA2:
                MOV CX,4 ;atribui 4 a cx pois vai imprimir 4 caracteres
                    TRANSFORMAHEXA:
                    MOV DL,BH ;move bh para dl
                    SHR DL,4 ;desloca dl quatro casas para a direita
                    CMP DL,10 ;compara dl com 10, se for menor é numero
                    JB NUMEROHEXA
                    ADD DL,55D ;se nao for menor que 10, é letra então adiciona 55d para imprimir a letra desejada
                    JMP IMPRIMIRHEXA ;vai a imprimirhexa (que imprime o que está em dl, rotaciona bx 4 casas para esquerda e loopa transformahexa)

                    NUMEROHEXA:
                    OR DL,30H ;entra se for numero e adiciona 30h para imprimir o numero desejado
                    JMP IMPRIMIRHEXA ;vai a imprimirhexa (que imprime o que está em dl, rotaciona bx 4 casas para esquerda e loopa transformahexa)

                    IMPRIMIRHEXA:
                    MOV AH,2 ;imprime o que ta em dl
                    MOV DL,DL
                    INT 21H
                    ROL BX,4 ;rotaciona bx 4 casas para a esquerda)
                    LOOP TRANSFORMAHEXA 
                    JMP FIM2 ;quando acaba o loop, vai para fim2 que retorna ao main
                    ;ta imprimindo de binario para hexa certo e de hexa para hexa certo**********

            DECIMAL2:
                XOR CX,CX
                XOR AX,AX
                CMP BX,0
                JB MENOS
                IMPRIMEDECIMAL:
                    MOV AX,BX
                        CONTA:
                            MOV BX,10
                            DIV BX
                            CMP AX,0
                            JE IMPRESSAO
                            PUSH DX
                            INC CX
                            JMP CONTA
                        
                        IMPRESSAO:
                            POP BX
                            OR BX,30H
                            MOV AH,2
                            MOV DX,BX
                            INT 21H
                        LOOP IMPRESSAO
                        JMP FIM

                MENOS:
                    MOV AH,2
                    MOV DL, '-'
                    INT 21H
                    XOR AH,AH
                    NEG BX
                    JMP IMPRIMEDECIMAL

            FIM2:
            RET

        SAIDAS ENDP
        END MAIN
