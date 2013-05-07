; Create a simulated TTY on the Vic-20
;
; Copyright (C) 2013 Lawrence Woodman <http://techtinkering.com>
;
; Licensed under an MIT licence.  Please see LICENCE.md for details.
;
#include "basicstubs.inc"

#define Volume          $900e
#define Speaker2        $900b
#define CassetteBuffer  $033c

#define VolMax      $0f
#define TTYNoise    $80

#define Space       $20
#define CR          $0d

OrigOutVect = $f27a
ProgStart   = $1001

            .word ProgStart     ; PRG Header to say where to load program
            * = ProgStart
            basicStubUnexpanded(2013)

            ;--------------------------------------------------------
            ; Initialize TTY routine to be used when $FFD2 is called
            ;--------------------------------------------------------

            ; Copy the TTY routine to the cassette buffer
            ldx #(EndMain-Main-1)
CopyLoop    lda CopyFrom, x
            sta CassetteBuffer, x
            dex
            bpl CopyLoop

            ; Point output vector used by $FFD2 to the cassette buffer
            lda #<CassetteBuffer
            sta $0326
            lda #>CassetteBuffer
            sta $0327

            ; Set volume to max
            lda #VolMax
            sta Volume

            rts

            ;-----------------------------------------------
            ; The main TTY simulation code that is called
            ; when CHROUT ($FFD2) is called
            ;-----------------------------------------------
CopyFrom    ; Where the TTY code should be copied from

            * = CassetteBuffer
Main        pha            ; Save the character to be printed

            cmp #Space     ; Skip making a noise if a space character
            beq Delays
            cmp #CR        ; Skip making a noise if a return character
            beq Delays

            ; Make the lowest note possible with speaker 2
            lda #TTYNoise
            sta Speaker2

Delays      ; Save registers because $FFD2 doesn't alter them
            txa
            pha
            tya
            pha

            ; Hold note if making a noise or give equal gap
            ldy #$00
            ldx #$15
NoteDelay   dey
            bne NoteDelay
            dex
            bne NoteDelay

            ; Turn off speaker 2
            lda #$00
            sta Speaker2

            ; Delay between letters
            ldy #$00
            ldx #$10
GapDelay    dey
            bne GapDelay
            dex
            bne GapDelay

            ; Restore registers
            pla
            tay
            pla
            tax
            pla

            ; Jump to the normal output vector stored in $0326
            jmp OrigOutVect
EndMain
