   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  15                     	bsct
  16  0000               _idxMode:
  17  0000 00            	dc.b	0
  48                     ; 57  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
  48                     ; 58 {
  49                     	switch	.text
  50  0000               f_ADC1_IRQHandler:
  52  0000 8a            	push	cc
  53  0001 84            	pop	a
  54  0002 a4bf          	and	a,#191
  55  0004 88            	push	a
  56  0005 86            	pop	cc
  57  0006 3b0002        	push	c_x+2
  58  0009 be00          	ldw	x,c_x
  59  000b 89            	pushw	x
  60  000c 3b0002        	push	c_y+2
  61  000f be00          	ldw	x,c_y
  62  0011 89            	pushw	x
  65                     ; 63 	state |= STATE_ADC_READY;
  67  0012 72100000      	bset	_state,#0
  68                     ; 64 	ADC1_ClearFlag(ADC1_FLAG_EOC);
  70  0016 a680          	ld	a,#128
  71  0018 cd0000        	call	_ADC1_ClearFlag
  73                     ; 65 }
  76  001b 85            	popw	x
  77  001c bf00          	ldw	c_y,x
  78  001e 320002        	pop	c_y+2
  79  0021 85            	popw	x
  80  0022 bf00          	ldw	c_x,x
  81  0024 320002        	pop	c_x+2
  82  0027 80            	iret
 107                     ; 101  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 107                     ; 102 {
 108                     	switch	.text
 109  0028               f_TIM2_UPD_OVF_BRK_IRQHandler:
 111  0028 8a            	push	cc
 112  0029 84            	pop	a
 113  002a a4bf          	and	a,#191
 114  002c 88            	push	a
 115  002d 86            	pop	cc
 116  002e 3b0002        	push	c_x+2
 117  0031 be00          	ldw	x,c_x
 118  0033 89            	pushw	x
 119  0034 3b0002        	push	c_y+2
 120  0037 be00          	ldw	x,c_y
 121  0039 89            	pushw	x
 124                     ; 103 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 126  003a ae0001        	ldw	x,#1
 127  003d cd0000        	call	_TIM2_ClearFlag
 129                     ; 104 	state |= STATE_TMR_TICK;	
 131  0040 72140000      	bset	_state,#2
 132                     ; 105 }
 135  0044 85            	popw	x
 136  0045 bf00          	ldw	c_y,x
 137  0047 320002        	pop	c_y+2
 138  004a 85            	popw	x
 139  004b bf00          	ldw	c_x,x
 140  004d 320002        	pop	c_x+2
 141  0050 80            	iret
 143                     	switch	.ubsct
 144  0000               L13_sr1:
 145  0000 00            	ds.b	1
 146  0001               L33_sr2:
 147  0001 00            	ds.b	1
 148  0002               L53_sr3:
 149  0002 00            	ds.b	1
 207                     ; 114 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 207                     ; 115 {
 208                     	switch	.text
 209  0051               f_I2C_IRQHandler:
 211  0051 8a            	push	cc
 212  0052 84            	pop	a
 213  0053 a4bf          	and	a,#191
 214  0055 88            	push	a
 215  0056 86            	pop	cc
 216  0057 3b0002        	push	c_x+2
 217  005a be00          	ldw	x,c_x
 218  005c 89            	pushw	x
 219  005d 3b0002        	push	c_y+2
 220  0060 be00          	ldw	x,c_y
 221  0062 89            	pushw	x
 224                     ; 121 	sr1 = I2C->SR1;
 226  0063 5552170000    	mov	L13_sr1,21015
 227                     ; 122 	sr2 = I2C->SR2;
 229  0068 5552180001    	mov	L33_sr2,21016
 230                     ; 123 	sr3 = I2C->SR3;
 232  006d 5552190002    	mov	L53_sr3,21017
 233                     ; 126   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
 235  0072 b601          	ld	a,L33_sr2
 236  0074 a52b          	bcp	a,#43
 237  0076 2711          	jreq	L56
 238                     ; 128     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
 240  0078 72125211      	bset	21009,#1
 241                     ; 129     I2C->SR2= 0;					    // clear all error flags
 243  007c 725f5218      	clr	21016
 244                     ; 130 		SetLED(LED_PANIC, 1);
 246  0080 4b01          	push	#1
 247  0082 ae3333        	ldw	x,#13107
 248  0085 cd0000        	call	_SetLED
 250  0088 84            	pop	a
 251  0089               L56:
 252                     ; 134   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
 254  0089 b600          	ld	a,L13_sr1
 255  008b a444          	and	a,#68
 256  008d a144          	cp	a,#68
 257  008f 260d          	jrne	L76
 258                     ; 137 		Slave_Buffer_Rx[Rx_Idx++] = I2C->DR;
 260  0091 b60b          	ld	a,_Rx_Idx
 261  0093 97            	ld	xl,a
 262  0094 3c0b          	inc	_Rx_Idx
 263  0096 9f            	ld	a,xl
 264  0097 5f            	clrw	x
 265  0098 97            	ld	xl,a
 266  0099 c65216        	ld	a,21014
 267  009c e703          	ld	(_Slave_Buffer_Rx,x),a
 268  009e               L76:
 269                     ; 141   if (sr1 & I2C_SR1_RXNE)
 271  009e b600          	ld	a,L13_sr1
 272  00a0 a540          	bcp	a,#64
 273  00a2 270d          	jreq	L17
 274                     ; 144 		Slave_Buffer_Rx[Rx_Idx++] = I2C->DR;
 276  00a4 b60b          	ld	a,_Rx_Idx
 277  00a6 97            	ld	xl,a
 278  00a7 3c0b          	inc	_Rx_Idx
 279  00a9 9f            	ld	a,xl
 280  00aa 5f            	clrw	x
 281  00ab 97            	ld	xl,a
 282  00ac c65216        	ld	a,21014
 283  00af e703          	ld	(_Slave_Buffer_Rx,x),a
 284  00b1               L17:
 285                     ; 148   if (sr2 & I2C_SR2_AF)
 287  00b1 b601          	ld	a,L33_sr2
 288  00b3 a504          	bcp	a,#4
 289  00b5 270b          	jreq	L37
 290                     ; 150     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
 292  00b7 72155218      	bres	21016,#2
 293                     ; 151 		if (led.pattern == LED_OFF)
 295  00bb be01          	ldw	x,_led+1
 296  00bd 2603          	jrne	L37
 297                     ; 153 			LEDOff();
 299  00bf cd0000        	call	_LEDOff
 301  00c2               L37:
 302                     ; 159   if (sr1 & I2C_SR1_STOPF) 
 304  00c2 b600          	ld	a,L13_sr1
 305  00c4 a510          	bcp	a,#16
 306  00c6 270b          	jreq	L77
 307                     ; 161     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
 309  00c8 72145211      	bset	21009,#2
 310                     ; 162 		if (led.pattern == LED_OFF)
 312  00cc be01          	ldw	x,_led+1
 313  00ce 2603          	jrne	L77
 314                     ; 164 			LEDOff();
 316  00d0 cd0000        	call	_LEDOff
 318  00d3               L77:
 319                     ; 170   if (sr1 & I2C_SR1_ADDR)
 321  00d3 b600          	ld	a,L13_sr1
 322  00d5 a502          	bcp	a,#2
 323  00d7 2702          	jreq	L301
 324                     ; 172 		Rx_Idx = 0;
 326  00d9 3f0b          	clr	_Rx_Idx
 327  00db               L301:
 328                     ; 177   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
 330  00db b600          	ld	a,L13_sr1
 331  00dd a484          	and	a,#132
 332  00df a184          	cp	a,#132
 333  00e1 2604          	jrne	L501
 334                     ; 180 		I2C_SendData(0x00);
 336  00e3 4f            	clr	a
 337  00e4 cd0000        	call	_I2C_SendData
 339  00e7               L501:
 340                     ; 184   if (sr1 & I2C_SR1_TXE)
 342  00e7 b600          	ld	a,L13_sr1
 343  00e9 a580          	bcp	a,#128
 344  00eb 2725          	jreq	L701
 345                     ; 186 		if (led.pattern == LED_OFF)
 347  00ed be01          	ldw	x,_led+1
 348  00ef 2603          	jrne	L111
 349                     ; 188 			LEDToggle();
 351  00f1 cd0000        	call	_LEDToggle
 353  00f4               L111:
 354                     ; 191 		if (Rx_Idx == 0)
 356  00f4 3d0b          	tnz	_Rx_Idx
 357  00f6 2607          	jrne	L311
 358                     ; 193 			I2C->DR = (phRaw >> 8);
 360  00f8 5500005216    	mov	21014,_phRaw
 362  00fd 2011          	jra	L511
 363  00ff               L311:
 364                     ; 197 		else if (Rx_Idx ==1)
 366  00ff b60b          	ld	a,_Rx_Idx
 367  0101 a101          	cp	a,#1
 368  0103 2607          	jrne	L711
 369                     ; 199 			I2C->DR = phRaw;
 371  0105 5500015216    	mov	21014,_phRaw+1
 373  010a 2004          	jra	L511
 374  010c               L711:
 375                     ; 205 			I2C->DR = 0xFF;
 377  010c 35ff5216      	mov	21014,#255
 378  0110               L511:
 379                     ; 209 		Rx_Idx++;
 381  0110 3c0b          	inc	_Rx_Idx
 382  0112               L701:
 383                     ; 213 	return;	
 386  0112 85            	popw	x
 387  0113 bf00          	ldw	c_y,x
 388  0115 320002        	pop	c_y+2
 389  0118 85            	popw	x
 390  0119 bf00          	ldw	c_x,x
 391  011b 320002        	pop	c_x+2
 392  011e 80            	iret
 415                     ; 223  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 415                     ; 224 {
 416                     	switch	.text
 417  011f               f_TIM2_CAP_COM_IRQHandler:
 421                     ; 228 }
 424  011f 80            	iret
 447                     ; 268  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 447                     ; 269 {
 448                     	switch	.text
 449  0120               f_UART1_TX_IRQHandler:
 453                     ; 273 }
 456  0120 80            	iret
 479                     ; 281  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 479                     ; 282 {
 480                     	switch	.text
 481  0121               f_UART1_RX_IRQHandler:
 485                     ; 286 }
 488  0121 80            	iret
 511                     ; 367  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 511                     ; 368 {
 512                     	switch	.text
 513  0122               f_TIM4_UPD_OVF_IRQHandler:
 517                     ; 372 }
 520  0122 80            	iret
 543                     ; 381 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 543                     ; 382 {
 544                     	switch	.text
 545  0123               f_EEPROM_EEC_IRQHandler:
 549                     ; 386 }
 552  0123 80            	iret
 575                     ; 394 @far @interrupt void NonHandledInterrupt(void)
 575                     ; 395 {
 576                     	switch	.text
 577  0124               f_NonHandledInterrupt:
 581                     ; 399 }
 584  0124 80            	iret
 606                     ; 406 @far @interrupt void TRAP_IRQHandler(void)
 606                     ; 407 {
 607                     	switch	.text
 608  0125               f_TRAP_IRQHandler:
 612                     ; 411 }
 615  0125 80            	iret
 637                     ; 433 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 637                     ; 434 {
 638                     	switch	.text
 639  0126               f_TLI_IRQHandler:
 643                     ; 438 }
 646  0126 80            	iret
 668                     ; 446 INTERRUPT_HANDLER(AWU_IRQHandler, 1)	
 668                     ; 447 {
 669                     	switch	.text
 670  0127               f_AWU_IRQHandler:
 674                     ; 451 }
 677  0127 80            	iret
 699                     ; 459 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 699                     ; 460 {
 700                     	switch	.text
 701  0128               f_CLK_IRQHandler:
 705                     ; 464 }
 708  0128 80            	iret
 731                     ; 472 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 731                     ; 473 {
 732                     	switch	.text
 733  0129               f_EXTI_PORTA_IRQHandler:
 737                     ; 477 }
 740  0129 80            	iret
 763                     ; 484 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 763                     ; 485 {
 764                     	switch	.text
 765  012a               f_EXTI_PORTB_IRQHandler:
 769                     ; 489 }
 772  012a 80            	iret
 795                     ; 497 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 795                     ; 498 {
 796                     	switch	.text
 797  012b               f_EXTI_PORTC_IRQHandler:
 801                     ; 502 }
 804  012b 80            	iret
 827                     ; 510 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 827                     ; 511 {
 828                     	switch	.text
 829  012c               f_EXTI_PORTD_IRQHandler:
 833                     ; 515 }
 836  012c 80            	iret
 859                     ; 523 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 859                     ; 524 {
 860                     	switch	.text
 861  012d               f_EXTI_PORTE_IRQHandler:
 865                     ; 528 }
 868  012d 80            	iret
 890                     ; 578 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 890                     ; 579 {
 891                     	switch	.text
 892  012e               f_SPI_IRQHandler:
 896                     ; 583 }
 899  012e 80            	iret
 922                     ; 591 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 922                     ; 592 {
 923                     	switch	.text
 924  012f               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 928                     ; 596 }
 931  012f 80            	iret
 954                     ; 604 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 954                     ; 605 {
 955                     	switch	.text
 956  0130               f_TIM1_CAP_COM_IRQHandler:
 960                     ; 609 }
 963  0130 80            	iret
1015                     	switch	.ubsct
1016  0003               _Slave_Buffer_Rx:
1017  0003 000000000000  	ds.b	8
1018                     	xdef	_Slave_Buffer_Rx
1019  000b               _Rx_Idx:
1020  000b 00            	ds.b	1
1021                     	xdef	_Rx_Idx
1022                     	xdef	_idxMode
1023  000c               _modeBuffer:
1024  000c 000000000000  	ds.b	64
1025                     	xdef	_modeBuffer
1026                     	xref	_LEDOff
1027                     	xref	_LEDToggle
1028                     	xref	_SetLED
1029                     	xref.b	_led
1030                     	xref.b	_phRaw
1031                     	xref.b	_state
1032                     	xdef	f_EEPROM_EEC_IRQHandler
1033                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1034                     	xdef	f_ADC1_IRQHandler
1035                     	xdef	f_I2C_IRQHandler
1036                     	xdef	f_UART1_RX_IRQHandler
1037                     	xdef	f_UART1_TX_IRQHandler
1038                     	xdef	f_TIM2_CAP_COM_IRQHandler
1039                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1040                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1041                     	xdef	f_TIM1_CAP_COM_IRQHandler
1042                     	xdef	f_SPI_IRQHandler
1043                     	xdef	f_EXTI_PORTE_IRQHandler
1044                     	xdef	f_EXTI_PORTD_IRQHandler
1045                     	xdef	f_EXTI_PORTC_IRQHandler
1046                     	xdef	f_EXTI_PORTB_IRQHandler
1047                     	xdef	f_EXTI_PORTA_IRQHandler
1048                     	xdef	f_CLK_IRQHandler
1049                     	xdef	f_AWU_IRQHandler
1050                     	xdef	f_TLI_IRQHandler
1051                     	xdef	f_TRAP_IRQHandler
1052                     	xdef	f_NonHandledInterrupt
1053                     	xref	_TIM2_ClearFlag
1054                     	xref	_I2C_SendData
1055                     	xref	_ADC1_ClearFlag
1056                     	xref.b	c_x
1057                     	xref.b	c_y
1077                     	end
