; Collection of Macros to create short BASIC programs containing a SYS
; statement to the start of the machine code.
;
; Copyright (C) 2013 Lawrence Woodman <http://techtinkering.com>
;
; Licensed under an MIT licence.  Please see LICENCE.md for details.
;

; BASIC Stub for an Unexpanded Vic:
;   year SYS 4110
#define basicStubUnexpanded(year)                                          \
            .(                                                            :\
            * = $1001                                                     :\
            .word basicEnd    ; Next Line, here end of BASIC program      :\
            .word year        ; The line number for the SYS statement     :\
            .byt  $9e         ; SYS token                                 :\
            .asc  " "                                                     :\
            .asc "4110"       ; Start of machine language                 :\
            .byt 0            ; End of BASIC line                         :\
basicEnd    .word 0           ; End of BASIC program                      :\
            .)

