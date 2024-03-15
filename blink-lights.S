

;Mmela Gabriel Dyantyi, Partner - Bokang Difeto ( contacts on request )


#include "avr/io.h"
#define __SFR_OFFSET 0

.global mainSS
.global blink

//Sets the functions used 

main:
 
    ldi r26, 0b00000100 //sets the intial condition of whether the the pin is HIGH or LOW in the first cycle 1 = HIGH
    sts 0x25, r26

  sbi DDRB, 4 ; //sets PB5 (PIN 13) to output by toggling the bit at Hex location 0x24 to 1 
  sbi DDRB, 2 ; //sets PB5 (PIN 10)

blink:
  sbi PINB, 4 ; //toggles the PB5 (PIN 13). Since the value of the bit in 0x25, it is intially at 0, the first time it is done it it is toggled to a 1 (HIGH)
  sbi PINB, 2 ; //toggles the PB2 (PIN 10)
  ldi   r25, hi8(1000)
  ldi   r24, lo8(1000)
  call  delay_ms
  jmp   blink

delay_ms:
  ; Delay about (r25:r24)*ms. Clobbers r30, and r31.
  ; One millisecond is about 16000 cycles at 16MHz.
  ; The inner loop takes 4 cycles, so we repeat it 3000 times
  ldi   r31, hi8(4000)
  ldi   r30, lo8(4000)
run:
  sbiw    r30, 1
  brne    run
  sbiw    r24, 1
  brne    delay_ms
  ret