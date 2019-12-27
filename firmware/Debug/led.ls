   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  64                     ; 5 void SetLED(uint16_t pattern, uint8_t repeatCount)
  64                     ; 6 {
  66                     	switch	.text
  67  0000               _SetLED:
  69  0000 89            	pushw	x
  70       00000000      OFST:	set	0
  73                     ; 7 	led.pattern = pattern;
  75  0001 bf01          	ldw	_led+1,x
  76                     ; 8 	led.duration = repeatCount;
  78  0003 7b05          	ld	a,(OFST+5,sp)
  79  0005 b703          	ld	_led+3,a
  80                     ; 9 	led.ctr = 0;
  82  0007 3f00          	clr	_led
  83                     ; 10 }
  86  0009 85            	popw	x
  87  000a 81            	ret
 113                     ; 12 void LEDTick()
 113                     ; 13 {
 114                     	switch	.text
 115  000b               _LEDTick:
 119                     ; 14 	if (led.pattern & (1 << led.ctr))
 121  000b ae0001        	ldw	x,#1
 122  000e b600          	ld	a,_led
 123  0010 4d            	tnz	a
 124  0011 2704          	jreq	L01
 125  0013               L21:
 126  0013 58            	sllw	x
 127  0014 4a            	dec	a
 128  0015 26fc          	jrne	L21
 129  0017               L01:
 130  0017 01            	rrwa	x,a
 131  0018 b402          	and	a,_led+2
 132  001a 01            	rrwa	x,a
 133  001b b401          	and	a,_led+1
 134  001d 01            	rrwa	x,a
 135  001e a30000        	cpw	x,#0
 136  0021 270b          	jreq	L34
 137                     ; 16 		GPIO_WriteLow(LED_port, LED_pin);
 139  0023 4b08          	push	#8
 140  0025 ae500f        	ldw	x,#20495
 141  0028 cd0000        	call	_GPIO_WriteLow
 143  002b 84            	pop	a
 145  002c 2009          	jra	L54
 146  002e               L34:
 147                     ; 20 		GPIO_WriteHigh(LED_port, LED_pin);					
 149  002e 4b08          	push	#8
 150  0030 ae500f        	ldw	x,#20495
 151  0033 cd0000        	call	_GPIO_WriteHigh
 153  0036 84            	pop	a
 154  0037               L54:
 155                     ; 23 	led.ctr++;
 157  0037 3c00          	inc	_led
 158                     ; 24 	if(led.ctr >= 16)
 160  0039 b600          	ld	a,_led
 161  003b a110          	cp	a,#16
 162  003d 2511          	jrult	L74
 163                     ; 26 		if (led.duration == 1)
 165  003f b603          	ld	a,_led+3
 166  0041 a101          	cp	a,#1
 167  0043 2603          	jrne	L15
 168                     ; 28 			led.pattern = LED_OFF;
 170  0045 5f            	clrw	x
 171  0046 bf01          	ldw	_led+1,x
 172  0048               L15:
 173                     ; 30 		if (led.duration > 0)
 175  0048 3d03          	tnz	_led+3
 176  004a 2702          	jreq	L35
 177                     ; 32 			led.duration--;
 179  004c 3a03          	dec	_led+3
 180  004e               L35:
 181                     ; 34 		led.ctr = 0;					
 183  004e 3f00          	clr	_led
 184  0050               L74:
 185                     ; 36 }
 188  0050 81            	ret
 241                     	xdef	_LEDTick
 242                     	xdef	_SetLED
 243                     	switch	.ubsct
 244  0000               _led:
 245  0000 00000000      	ds.b	4
 246                     	xdef	_led
 247                     	xref	_GPIO_WriteLow
 248                     	xref	_GPIO_WriteHigh
 268                     	end
