; Create a simulated TTY on the Vic-20
;
; Copyright (C) 2013 Lawrence Woodman <http://techtinkering.com>
;
; Licensed under an MIT licence.  Please see LICENCE.md for details.
;

					  PROCESSOR 6502

Volume		  EQU	$900e
Speaker2    EQU $900b
VolMax      EQU $0f
TTYNoise    EQU $80

Space			  EQU $20
CR				  EQU $0d

OrigOutVect EQU $f27a


						ORG $033c

            ; Initialize TTY routine to be used when $FFD2 is called
						lda #[<Main]   ; Point output vector used by $FFD2 to our routine
						sta $0326      ; |
						lda #[>Main]   ; |
						sta $0327      ; \
						lda #VolMax    ; Set the volume to maximum
						sta Volume     ; \
						rts

						; Routine that is called when $FFD2 is called
Main			  pha            ; Save the character to be printed

						cmp #Space     ; Skip making a noise if a space character
						beq Delays     ; \
						cmp #CR        ; Skip making a noise if a return character
						beq Delays     ; \

						lda #TTYNoise  ; Make the lowest note possible with speaker 2
						sta Speaker2   ; \

Delays	    txa            ; Save registers because $FFD2 doesn't alter them
						pha            ; |
						tya            ; |
						pha            ; \

					  ldy #$00       ; Hold note if making a noise or give equal gap
					  ldx #$15       ; |
NoteDelay	  dey            ; |
						bne NoteDelay  ; |
						dex            ; |
						bne NoteDelay  ; \

						lda #$00       ; Turn off speaker 2
						sta Speaker2   ; \

						ldy #$00       ; Delay between letters
						ldx #$10       ; |
GapDelay	  dey            ; |
						bne GapDelay   ; |
						dex            ; |
						bne GapDelay   ; \

						pla            ; Restore the registers
						tay            ; |
						pla            ; |
						tax            ; |
						pla            ; \

						jmp OrigOutVect ; Jump to the normal output vector stored in $0326
