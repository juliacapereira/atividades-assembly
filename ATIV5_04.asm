TITLE alfabeto
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV CX,26 ;CX recebe o valor 26 devido as 26 letras do alfabeto
    MOV DL,61H ;DL recebe 61h que na tabela ascii corresponde a "a"
    MOV BL,4 ;BL recebe o valor 4
    CMP BL,0 ;compara BL com 0

    LOOPGERAL:
    MOV CX,4
    CMP BL,0

    LOOP1:
    CMP DL,7BH ;compara DL com 7BH ("{" na tabela ascii)
    JE ENCERRA ;salta para "encerra" se DL for igual a 7BH
    
    ;imprime na tela
    MOV AH,2
    INT 21H
    
    INC DL ;incrementa 1 a DL
    DEC BL ;decrescenta 1 de BL
    LOOP LOOP1 ;faz LOOP1 rodar até DL ser igual a 7BH

    ;organiza a impressão na tela como 4 letras seguidas
    SEQUENCIA:
    MOV AH,2
    MOV BL,DL ;BL armazena o conteudo de DL
    MOV DL,10 ;pula para a próxima linha
    INT 21H
    MOV DL,BL ;DL armazena o conteudo de BL
    MOV AH,2
    MOV BL,DL ;BL armazena o conteudo de DL
    MOV DL,13 ;move o cursor para a esquerda
    INT 21H
    MOV DL,BL ;DL armazena o conteudo de BL
    JGE LOOPGERAL ;se DL for maior ou igual, salta para "LOOPGERAL"

    ;encerra o programa
    ENCERRA:
    MOV AH, 4CH
    INT 21H

    MAIN ENDP
    END MAIN