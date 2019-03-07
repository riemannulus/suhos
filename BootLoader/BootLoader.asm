[ORG 0x00]  ; 코드의 시작 어드레스를 0x00으로 설정
[BITS 16]   ; 이하 16비트 코드

SECTION.text    ; 텍스트 세그먼트(섹션)을 정의

jmp 0x07C0:START    ; CS레지스터가 보는 위치를 0x07C0로 변경

START:
    mov ax, 0x07C0  ; GPR에 0x07C0 입력
    mov ds, ax      ; DS 레지스터에 AX 값 옮기기    ; CS레지스터가 보는 위치를 0x07C0로 변경
    mov ax, 0xB800
    mov es, ax
    mov si, 0

.SCREENCLEARLOOP:
    mov byte [es: si], 0
    mov byte [es: si+1], 0x0B
    
    add si, 2

    cmp si, 80 * 25 * 2

    jl .SCREENCLEARLOOP

    mov si, 0
    mov di, 0

.MESSAGELOOP:
    mov cl, byte [ si + MESSAGE1 ]  ; CX를 사용하는 이유: CX는 루프의 카운터로 사용되기 때문.

    cmp cl, '\0'
    je .MESSAGEEND

    mov byte [es: di], cl

    add si, 1
    add di, 2

    jmp .MESSAGELOOP

.MESSAGEEND

MESSAGE1: db 'suhOS Boot Loader Start!', '\0'

times 510 - ( $ - $$ ) db 0x00

db 0x55
db 0xAA