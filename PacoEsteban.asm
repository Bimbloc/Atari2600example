    ;Setting the 2600 microprocessor model
    PROCESSOR 6502
    INCLUDE "vcs.h" ;Memory mapping, registers and other Atari2600 specificaitons

    ; Origin where our cartige would start , see vcs.h
    ORG $F000

PreFrame:
        lda #%00000010 ;will use for Vsync signal
        sta VSYNC      ;Waiting for out of screen scanlines
        REPEAT 3
            sta WSYNC
        REPEND 
        lda #0    
        sta VSYNC       ;signal Vsync

ClearPlayfield:   ;We are just using backgroun pixels for the text so we turn off all players
    lda #$00       
    sta ENABL      
    sta ENAM1
    sta ENAM0
    sta GRP1
    sta GRP0
    sta COLUBK      ; Background colour, black
    sta PF2
    sta PF0         
    lda #$AB        ; Text colour , clear blue
    sta COLUPF
    lda #$00        ; Duplicate the background and NOT reflect it
    sta CTRLPF
    ldx #0          ;Vblank wait to tor on thbe beam.
    REPEAT 37       
        sta WSYNC   
    REPEND
    lda #0         
    sta VBLANK


DrawLine: 
    bcs LineEnd ;checking if we need to keep drawing
    txa             
    lsr             
    tay             
    lda Text,y    ;Acces our line info
    sta PF1 

LineEnd:
    sta WSYNC       
    inx             
    cpx #140    ;192 scanlines but we dont use all the screen so we finish before
    bne DrawLine

Overscan:
    lda #%01000010 ;Turning off the beam 
    sta VBLANK     
    REPEAT 30      
        sta WSYNC
    REPEND
    jmp PreFrame  


Text: ;PACO ESTEBAN printed line by line
    .BYTE %00000000 
    .BYTE %01111100
    .BYTE %01000100
    .BYTE %01111000
    .BYTE %01000000
    .BYTE %01000000
    .BYTE %00000000
    .BYTE %00000000 
    .BYTE %0111100
    .BYTE %01000100
    .BYTE %01111100
    .BYTE %01000100
    .BYTE %01000100
    .BYTE %00000000
    .BYTE %00111100
    .BYTE %01000000 
    .BYTE %01000000
    .BYTE %01000000
    .BYTE %00111100
    .BYTE %00000000
    .BYTE %00000000
    .BYTE %00111000
    .BYTE %01000100
    .BYTE %01000100 
    .BYTE %00111000
    .BYTE %00000000
    .BYTE %01111100
    .BYTE %01000000
    .BYTE %01111100
    .BYTE %01000000
    .BYTE %01111100 
    .BYTE %00000000
    .BYTE %00111100
    .BYTE %01000000
    .BYTE %01000000
    .BYTE %01111100
    .BYTE %00000010
    .BYTE %01000010
    .BYTE %00111100
    .BYTE %00000000
    .BYTE %00000000 
    .BYTE %01111100
    .BYTE %00010000
    .BYTE %00010000
    .BYTE %00000000
    .BYTE %01111100
    .BYTE %01000000
    .BYTE %01111100
    .BYTE %01000000
    .BYTE %01111100 
    .BYTE %00000000
    .BYTE %00111100
    .BYTE %01000010
    .BYTE %01111100
    .BYTE %01000010
    .BYTE %00111100
    .BYTE %00000000
    .BYTE %0111100
    .BYTE %01000100
    .BYTE %01111100
    .BYTE %01000100
    .BYTE %01000100
    .BYTE %00000000
    .BYTE %01100010
    .BYTE %01010010 
    .BYTE %01001110
    .BYTE %00000000
    .BYTE %00000000
    .BYTE %00000000
    .BYTE %00000000
    .BYTE %00000000
    .BYTE %00000000
    .BYTE %00000000 
    .BYTE %00000000 ; Last byte written to PF1 (important, ensures lower tip
                    ;                           of letter "D" won't "bleeed")
     ORG $FFFA      ;Config Cartige
    .WORD PreFrame      ;     NMI
    .WORD PreFrame      ;     RESET
    .WORD PreFrame      ;     IRQ

    END