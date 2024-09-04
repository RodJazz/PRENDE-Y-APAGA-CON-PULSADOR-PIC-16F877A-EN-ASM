 __CONFIG _WDT_OFF&_PWRTE_ON&_XT_OSC&_LVP_OFF&_CP_OFF 

   LIST p=16F877A
   INCLUDE <P16F877A.INC>
              ORG    0X00
              GOTO   CONFIGURAR
              ORG    0X05
CONFIGURAR:
;DE HOJA DE DATOS INICIALIZACION DEL PUERTO A, VER PAGINA 41 DATASHEET
;+--------------------------------------------------------------------
              BCF STATUS, RP0 ;
              BCF STATUS, RP1 ; Bank0
              CLRF PORTA ; Initialize PORTA by
                         ; clearing output
                         ; data latches
              BSF STATUS, RP0 ; Select Bank 1
              MOVLW 0x06      ; Configure all pins
              MOVWF ADCON1    ; as digital inputs
              MOVLW 0xCE      ; Value used to
                              ; initialize data
                              ; direction
              MOVWF TRISA     ; Set RA<3:0> as inputs
                              ; RA<5:4> as outputs
                              ; TRISA<7:6>are always
                              ; read as '0'.
              CLRF  TRISB       
;+--------------------------------------------------          
           BCF     STATUS,RP0   ;VOLVEMOS AL BANCO 0          
           CLRF    PORTA        ;LIMPIAMOS EL PUERTO A        
           CLRF    PORTB        ;LIMPIAMOS EL PUERTO B          
MAIN:
           BTFSS   PORTA,1      ;TESTEA SI POR EL BIT RA1 HAY UN 1 LOGICO
           GOTO    APAGAR       ;NO HAY 1 LOGICO, POR LO TANTO NO SALTA SE VA A LA ETIQUETA APAGAR
           BSF     PORTA,0      ;SE COLOCA EN 1 LOGICO EL BIT RA0
           BSF     PORTB,0      ;SE COLOCA EN 1 LOGICO EL BIT RB0
           GOTO    MAIN         ;IR A LA ETIQUETA MAIN
APAGAR:                         ;EN ESTA ETIQUE SE LIMPIAN O SE COLOCAN A 0 LOS PUERTOS A Y B
           CLRF    PORTA
           CLRF    PORTB
           GOTO    MAIN
           END                  ;FIN DEL ENSAMBLADOR