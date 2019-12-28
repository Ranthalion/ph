   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  15                     	bsct
  16  0000               _Tx_Idx:
  17  0000 00            	dc.b	0
  18  0001               _Rx_Idx:
  19  0001 00            	dc.b	0
  20  0002               _Event:
  21  0002 0000          	dc.w	0
  22  0004               _reg:
  23  0004 00            	dc.b	0
  24  0005               _idxMode:
  25  0005 00            	dc.b	0
  56                     ; 60  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
  56                     ; 61 {
  57                     	switch	.text
  58  0000               f_ADC1_IRQHandler:
  60  0000 8a            	push	cc
  61  0001 84            	pop	a
  62  0002 a4bf          	and	a,#191
  63  0004 88            	push	a
  64  0005 86            	pop	cc
  65  0006 3b0002        	push	c_x+2
  66  0009 be00          	ldw	x,c_x
  67  000b 89            	pushw	x
  68  000c 3b0002        	push	c_y+2
  69  000f be00          	ldw	x,c_y
  70  0011 89            	pushw	x
  73                     ; 66 	state |= STATE_ADC_READY;
  75  0012 72100000      	bset	_state,#0
  76                     ; 67 	ADC1_ClearFlag(ADC1_FLAG_EOC);
  78  0016 a680          	ld	a,#128
  79  0018 cd0000        	call	_ADC1_ClearFlag
  81                     ; 68 }
  84  001b 85            	popw	x
  85  001c bf00          	ldw	c_y,x
  86  001e 320002        	pop	c_y+2
  87  0021 85            	popw	x
  88  0022 bf00          	ldw	c_x,x
  89  0024 320002        	pop	c_x+2
  90  0027 80            	iret
 115                     ; 104  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 115                     ; 105 {
 116                     	switch	.text
 117  0028               f_TIM2_UPD_OVF_BRK_IRQHandler:
 119  0028 8a            	push	cc
 120  0029 84            	pop	a
 121  002a a4bf          	and	a,#191
 122  002c 88            	push	a
 123  002d 86            	pop	cc
 124  002e 3b0002        	push	c_x+2
 125  0031 be00          	ldw	x,c_x
 126  0033 89            	pushw	x
 127  0034 3b0002        	push	c_y+2
 128  0037 be00          	ldw	x,c_y
 129  0039 89            	pushw	x
 132                     ; 106 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 134  003a ae0001        	ldw	x,#1
 135  003d cd0000        	call	_TIM2_ClearFlag
 137                     ; 107 	state |= STATE_TMR_TICK;	
 139  0040 72140000      	bset	_state,#2
 140                     ; 108 }
 143  0044 85            	popw	x
 144  0045 bf00          	ldw	c_y,x
 145  0047 320002        	pop	c_y+2
 146  004a 85            	popw	x
 147  004b bf00          	ldw	c_x,x
 148  004d 320002        	pop	c_x+2
 149  0050 80            	iret
 151                     	switch	.ubsct
 152  0000               L13_sr1:
 153  0000 00            	ds.b	1
 154  0001               L33_sr2:
 155  0001 00            	ds.b	1
 156  0002               L53_sr3:
 157  0002 00            	ds.b	1
 222                     ; 117 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 222                     ; 118 {
 223                     	switch	.text
 224  0051               f_I2C_IRQHandler:
 226  0051 8a            	push	cc
 227  0052 84            	pop	a
 228  0053 a4bf          	and	a,#191
 229  0055 88            	push	a
 230  0056 86            	pop	cc
 231  0057 3b0002        	push	c_x+2
 232  005a be00          	ldw	x,c_x
 233  005c 89            	pushw	x
 234  005d 3b0002        	push	c_y+2
 235  0060 be00          	ldw	x,c_y
 236  0062 89            	pushw	x
 239                     ; 124 	sr1 = I2C->SR1;
 241  0063 5552170000    	mov	L13_sr1,21015
 242                     ; 125 	sr2 = I2C->SR2;
 244  0068 5552180001    	mov	L33_sr2,21016
 245                     ; 126 	sr3 = I2C->SR3;
 247  006d 5552190002    	mov	L53_sr3,21017
 248                     ; 129   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
 250  0072 b601          	ld	a,L33_sr2
 251  0074 a52b          	bcp	a,#43
 252  0076 2708          	jreq	L301
 253                     ; 131     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
 255  0078 72125211      	bset	21009,#1
 256                     ; 132     I2C->SR2= 0;					    // clear all error flags
 258  007c 725f5218      	clr	21016
 259  0080               L301:
 260                     ; 135   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
 262  0080 b600          	ld	a,L13_sr1
 263  0082 a444          	and	a,#68
 264  0084 a144          	cp	a,#68
 265  0086 260f          	jrne	L501
 266                     ; 138 		Slave_Buffer_Rx[Rx_Idx++] = I2C_ReceiveData();
 268  0088 b601          	ld	a,_Rx_Idx
 269  008a 97            	ld	xl,a
 270  008b 3c01          	inc	_Rx_Idx
 271  008d 9f            	ld	a,xl
 272  008e 5f            	clrw	x
 273  008f 97            	ld	xl,a
 274  0090 89            	pushw	x
 275  0091 cd0000        	call	_I2C_ReceiveData
 277  0094 85            	popw	x
 278  0095 e743          	ld	(_Slave_Buffer_Rx,x),a
 279  0097               L501:
 280                     ; 141   if (sr1 & I2C_SR1_RXNE)
 282  0097 b600          	ld	a,L13_sr1
 283  0099 a540          	bcp	a,#64
 284  009b 270f          	jreq	L701
 285                     ; 144 		Slave_Buffer_Rx[Rx_Idx++] = I2C_ReceiveData();
 287  009d b601          	ld	a,_Rx_Idx
 288  009f 97            	ld	xl,a
 289  00a0 3c01          	inc	_Rx_Idx
 290  00a2 9f            	ld	a,xl
 291  00a3 5f            	clrw	x
 292  00a4 97            	ld	xl,a
 293  00a5 89            	pushw	x
 294  00a6 cd0000        	call	_I2C_ReceiveData
 296  00a9 85            	popw	x
 297  00aa e743          	ld	(_Slave_Buffer_Rx,x),a
 298  00ac               L701:
 299                     ; 147   if (sr2 & I2C_SR2_AF)
 301  00ac b601          	ld	a,L33_sr2
 302  00ae a504          	bcp	a,#4
 303  00b0 270b          	jreq	L111
 304                     ; 149     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
 306  00b2 72155218      	bres	21016,#2
 307                     ; 150 		if (led.pattern == LED_OFF)
 309  00b6 be01          	ldw	x,_led+1
 310  00b8 2603          	jrne	L111
 311                     ; 152 			LEDOff();
 313  00ba cd0000        	call	_LEDOff
 315  00bd               L111:
 316                     ; 157   if (sr1 & I2C_SR1_STOPF) 
 318  00bd b600          	ld	a,L13_sr1
 319  00bf a510          	bcp	a,#16
 320  00c1 2704          	jreq	L511
 321                     ; 159     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
 323  00c3 72145211      	bset	21009,#2
 324  00c7               L511:
 325                     ; 163   if (sr1 & I2C_SR1_ADDR)
 327  00c7 b600          	ld	a,L13_sr1
 328  00c9 a502          	bcp	a,#2
 329  00cb 2702          	jreq	L711
 330                     ; 165 		Rx_Idx = 0;
 332  00cd 3f01          	clr	_Rx_Idx
 333  00cf               L711:
 334                     ; 169   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
 336  00cf b600          	ld	a,L13_sr1
 337  00d1 a484          	and	a,#132
 338  00d3 a184          	cp	a,#132
 339  00d5 2604          	jrne	L121
 340                     ; 172 		I2C_SendData(0x00);
 342  00d7 4f            	clr	a
 343  00d8 cd0000        	call	_I2C_SendData
 345  00db               L121:
 346                     ; 175   if (sr1 & I2C_SR1_TXE)
 348  00db b600          	ld	a,L13_sr1
 349  00dd a580          	bcp	a,#128
 350  00df 271f          	jreq	L321
 351                     ; 177 		if (led.pattern == LED_OFF)
 353  00e1 be01          	ldw	x,_led+1
 354  00e3 2603          	jrne	L521
 355                     ; 179 			LEDToggle();
 357  00e5 cd0000        	call	_LEDToggle
 359  00e8               L521:
 360                     ; 182 		if (Rx_Idx == 0)
 362  00e8 3d01          	tnz	_Rx_Idx
 363  00ea 260b          	jrne	L721
 364                     ; 185 			I2C_SendData(((phRaw >> 8) & 0x00FF));
 366  00ec b600          	ld	a,_phRaw
 367  00ee cd0000        	call	_I2C_SendData
 369                     ; 186 			Rx_Idx = 1;
 371  00f1 35010001      	mov	_Rx_Idx,#1
 373  00f5 2009          	jra	L321
 374  00f7               L721:
 375                     ; 190 			I2C_SendData((phRaw & 0x00FF));
 377  00f7 b601          	ld	a,_phRaw+1
 378  00f9 a4ff          	and	a,#255
 379  00fb cd0000        	call	_I2C_SendData
 381                     ; 191 			Rx_Idx = 0;
 383  00fe 3f01          	clr	_Rx_Idx
 384  0100               L321:
 385                     ; 195 	return;
 387  0100               L531:
 388                     ; 289 }
 389  0100               L21:
 392  0100 85            	popw	x
 393  0101 bf00          	ldw	c_y,x
 394  0103 320002        	pop	c_y+2
 395  0106 85            	popw	x
 396  0107 bf00          	ldw	c_x,x
 397  0109 320002        	pop	c_x+2
 398  010c 80            	iret
 421                     ; 298  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 421                     ; 299 {
 422                     	switch	.text
 423  010d               f_TIM2_CAP_COM_IRQHandler:
 427                     ; 303 }
 430  010d 80            	iret
 453                     ; 343  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 453                     ; 344 {
 454                     	switch	.text
 455  010e               f_UART1_TX_IRQHandler:
 459                     ; 348 }
 462  010e 80            	iret
 485                     ; 356  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 485                     ; 357 {
 486                     	switch	.text
 487  010f               f_UART1_RX_IRQHandler:
 491                     ; 361 }
 494  010f 80            	iret
 517                     ; 442  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 517                     ; 443 {
 518                     	switch	.text
 519  0110               f_TIM4_UPD_OVF_IRQHandler:
 523                     ; 447 }
 526  0110 80            	iret
 549                     ; 456 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 549                     ; 457 {
 550                     	switch	.text
 551  0111               f_EEPROM_EEC_IRQHandler:
 555                     ; 461 }
 558  0111 80            	iret
 581                     ; 469 @far @interrupt void NonHandledInterrupt(void)
 581                     ; 470 {
 582                     	switch	.text
 583  0112               f_NonHandledInterrupt:
 587                     ; 474 }
 590  0112 80            	iret
 612                     ; 481 @far @interrupt void TRAP_IRQHandler(void)
 612                     ; 482 {
 613                     	switch	.text
 614  0113               f_TRAP_IRQHandler:
 618                     ; 486 }
 621  0113 80            	iret
 643                     ; 508 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 643                     ; 509 {
 644                     	switch	.text
 645  0114               f_TLI_IRQHandler:
 649                     ; 513 }
 652  0114 80            	iret
 674                     ; 521 INTERRUPT_HANDLER(AWU_IRQHandler, 1)	
 674                     ; 522 {
 675                     	switch	.text
 676  0115               f_AWU_IRQHandler:
 680                     ; 526 }
 683  0115 80            	iret
 705                     ; 534 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 705                     ; 535 {
 706                     	switch	.text
 707  0116               f_CLK_IRQHandler:
 711                     ; 539 }
 714  0116 80            	iret
 737                     ; 547 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 737                     ; 548 {
 738                     	switch	.text
 739  0117               f_EXTI_PORTA_IRQHandler:
 743                     ; 552 }
 746  0117 80            	iret
 769                     ; 559 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 769                     ; 560 {
 770                     	switch	.text
 771  0118               f_EXTI_PORTB_IRQHandler:
 775                     ; 564 }
 778  0118 80            	iret
 801                     ; 572 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 801                     ; 573 {
 802                     	switch	.text
 803  0119               f_EXTI_PORTC_IRQHandler:
 807                     ; 577 }
 810  0119 80            	iret
 833                     ; 585 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 833                     ; 586 {
 834                     	switch	.text
 835  011a               f_EXTI_PORTD_IRQHandler:
 839                     ; 590 }
 842  011a 80            	iret
 865                     ; 598 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 865                     ; 599 {
 866                     	switch	.text
 867  011b               f_EXTI_PORTE_IRQHandler:
 871                     ; 603 }
 874  011b 80            	iret
 896                     ; 653 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 896                     ; 654 {
 897                     	switch	.text
 898  011c               f_SPI_IRQHandler:
 902                     ; 658 }
 905  011c 80            	iret
 928                     ; 666 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 928                     ; 667 {
 929                     	switch	.text
 930  011d               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 934                     ; 671 }
 937  011d 80            	iret
 960                     ; 679 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 960                     ; 680 {
 961                     	switch	.text
 962  011e               f_TIM1_CAP_COM_IRQHandler:
 966                     ; 684 }
 969  011e 80            	iret
1048                     	xdef	_idxMode
1049                     	switch	.ubsct
1050  0003               _modeBuffer:
1051  0003 000000000000  	ds.b	64
1052                     	xdef	_modeBuffer
1053                     	xdef	_reg
1054                     	xdef	_Event
1055                     	xdef	_Rx_Idx
1056                     	xdef	_Tx_Idx
1057  0043               _Slave_Buffer_Rx:
1058  0043 000000000000  	ds.b	8
1059                     	xdef	_Slave_Buffer_Rx
1060                     	xref	_LEDOff
1061                     	xref	_LEDToggle
1062                     	xref	_SetLED
1063                     	xref.b	_led
1064                     	xref.b	_phRaw
1065                     	xref.b	_state
1066                     	xdef	f_EEPROM_EEC_IRQHandler
1067                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1068                     	xdef	f_ADC1_IRQHandler
1069                     	xdef	f_I2C_IRQHandler
1070                     	xdef	f_UART1_RX_IRQHandler
1071                     	xdef	f_UART1_TX_IRQHandler
1072                     	xdef	f_TIM2_CAP_COM_IRQHandler
1073                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1074                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1075                     	xdef	f_TIM1_CAP_COM_IRQHandler
1076                     	xdef	f_SPI_IRQHandler
1077                     	xdef	f_EXTI_PORTE_IRQHandler
1078                     	xdef	f_EXTI_PORTD_IRQHandler
1079                     	xdef	f_EXTI_PORTC_IRQHandler
1080                     	xdef	f_EXTI_PORTB_IRQHandler
1081                     	xdef	f_EXTI_PORTA_IRQHandler
1082                     	xdef	f_CLK_IRQHandler
1083                     	xdef	f_AWU_IRQHandler
1084                     	xdef	f_TLI_IRQHandler
1085                     	xdef	f_TRAP_IRQHandler
1086                     	xdef	f_NonHandledInterrupt
1087                     	xref	_TIM2_ClearFlag
1088                     	xref	_I2C_GetLastEvent
1089                     	xref	_I2C_SendData
1090                     	xref	_I2C_ReceiveData
1091                     	xref	_ADC1_ClearFlag
1092                     	xref.b	c_x
1093                     	xref.b	c_y
1113                     	end
