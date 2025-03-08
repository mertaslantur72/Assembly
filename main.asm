;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stack pointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
; Main loop burada ba�l�yor
;-------------------------------------------------------------------------------

MainLoop:
            clr r4                          ; r4 register'�n� s�f�rla

xx:         mov 0200h(r4), 0240h(r4)        ; 0200h adresinden okunan veriyi 0240h adresine ta��
            incd r4                         ; r4 de�erini 2 art�r
            cmp #28h, r4                    ; r4, 28h oldu mu?
            jnz xx                          ; E�er olmad�ysa tekrar xx'e git

            jmp MainLoop                    ; Sonsuz d�ng�ye gir (program�n �al��mas�n� s�rd�rebilmesi i�in)

;-------------------------------------------------------------------------------
; Stack Pointer tan�m�
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
