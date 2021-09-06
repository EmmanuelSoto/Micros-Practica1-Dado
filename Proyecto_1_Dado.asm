#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED 
MAIN_PROG CODE                      ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
cont equ 0x33
lim equ b'00000110'
;inicio del programa: 
START
    MOVLW 0x07 ;Apagar comparadores
    MOVWF CMCON
    BCF STATUS, RP1 ;Cambiar al banco 1
    BSF STATUS, RP0 
    MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB 
    MOVLW b'00000001' ;Establecer puerto A como salida (los 8 bits del puerto)
    MOVWF TRISA 
    BCF STATUS, RP0 ;Regresar al banco 0

inicio: 

    CLRF PORTB
    MOVLW lim
    MOVWF cont
    MOVF cont, W 
    MOVWF PORTB
    BTFSC PORTA,0
    BTFSS PORTA,0
    GOTO $-2
    DECFSZ cont
    GOTO $-6
    GOTO $-9
    
			
    END