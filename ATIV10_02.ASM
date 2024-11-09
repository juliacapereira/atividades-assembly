TITLE IMPRIMIR MATRIZ
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
NUMEROSMATRIZ DB "INSIRA OS NUMEROS QUE VC DESEJA INSERIR NA MATRIZ 4X4 (USE DE 0 A 6):$"
MATRIZ4X4 DB 4 DUP('?')
          DB 4 DUP('?')
          DB 4 DUP('?')
          DB 4 DUP('?')
SOMA DB "A SOMA DOS ELEMENTOS DA SUA MATRIZ E:$"
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX ;LE O INSERIDO EM .DATA
        XOR BX,BX ;ZERA BX
        XOR SI,SI ;ZERA SI
        CALL LERNUMEROS
        CALL IMPRIMIR
        MOV AH,4CH
        INT 21H
        MAIN ENDP

    LERNUMEROS PROC
    
    LEA DX, NUMEROSMATRIZ
    MOV AH,9
    INT 21H

    MOV CX,4 

    MOV AH,1
    LER:
    CMP AL,0DH
    JE RETORNA
    MOV MATRIZ4X4[BX][SI],AL
    INT 21H
    INC SI
    LOOP LER

    ADD BX,4
    MOV CX,4
    XOR SI,SI
    CMP BX,12
    JBE LER
    RETORNA:
    RET 
    LERNUMEROS ENDP

    SOMAR PROC  
        XOR BX,BX
        XOR SI,SI
        MOV CX,4
        SOMANDOLINHA:
        ;MOV AL,MATRIZ4X4[BX][SI]
        ADD AL, MATRIZ4X4[BX][SI]
        INC SI
        LOOP LER
        ADD BX,4
        MOV CX,4
        XOR SI,SI
        CMP BX,12
        JBE SOMANDOLINHA
        PUSH AX
        RET 
    SOMAR ENDP

    IMPRIMIR PROC
        XOR BX,BX
        XOR SI,SI
        XOR DL,DL   
        MOV CX,4
pula_linha
        MOV AH,2    
        IMPRIMIRLINHA:
        MOV DL,MATRIZ4X4[BX][SI] ;IMPRIME OS ELEMENTOS DA MATRIZ
        OR DL,30H ;ADICIONA 30H PARA IMPRIMIR O NUMERO CORRESPONDENTE EM HEXA
        INT 21H
        INC SI ;AUMENTA SI PARA IMPRIMIR O PROXIMO ELEMENTO
        LOOP IMPRIMIRLINHA ;IMPRIME TODOS OS ELEMENTOS DE CADA LINHA (USA O CX ATRIBUIDO NO MAIN)
        pula_linha
        XOR SI,SI
        MOV CX,4
        ADD BX,4 ;ADICIONA 4 EM BX PARA PASSAR PARA A PROXIMA LINHA A SER IMPRESSA
        CMP BX,12 ;COMPARA BX COM 12 (A ULTIMA LINHA É 12)
        JBE IMPRIMIRLINHA

        ;MOV AH,9
        ;LEA DX, SOMA
        ;INT 21H
        ;XOR AX,AX
       ; POP AX
        ;MOV AH,2
        ;IMPRESSAOSOMA:
            ;MOV DX,10
            ;DIV DX
           ; MOV DX, DX
            ;OR DX,30H
            ;INT 21H
            ;CMP DX,0
            ;JNE IMPRESSAOSOMA
        RET
        IMPRIMIR ENDP    
END MAIN