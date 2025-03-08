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
; Main loop burada baþlýyor
;-------------------------------------------------------------------------------

MainLoop:
            clr r4                          ; r4 register'ýný sýfýrla

xx:         mov 0200h(r4), 0240h(r4)        ; 0200h adresinden okunan veriyi 0240h adresine taþý
            incd r4                         ; r4 deðerini 2 artýr
            cmp #28h, r4                    ; r4, 28h oldu mu?
            jnz xx                          ; Eðer olmadýysa tekrar xx'e git

            jmp MainLoop                    ; Sonsuz döngüye gir (programýn çalýþmasýný sürdürebilmesi için)

;-------------------------------------------------------------------------------
; Stack Pointer tanýmý
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
