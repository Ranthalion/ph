   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  15                     	bsct
  16  0000               _idxMode:
  17  0000 00            	dc.b	0
  18  0001               _Rx_Idx:
  19  0001 00            	dc.b	0
  50                     ; 53 	void I2C_transaction_begin(void)
  50                     ; 54 	{
  52                     	switch	.text
  53  0000               _I2C_transaction_begin:
  57                     ; 55 		MessageBegin = TRUE;
  59  0000 35010003      	mov	_MessageBegin,#1
  60                     ; 56 	}
  63  0004 81            	ret
  87                     ; 57 	void I2C_transaction_end(void)
  87                     ; 58 	{
  88                     	switch	.text
  89  0005               _I2C_transaction_end:
  93                     ; 60 	}
  96  0005 81            	ret
 130                     ; 61 	void I2C_byte_received(u8 u8_RxData)
 130                     ; 62 	{
 131                     	switch	.text
 132  0006               _I2C_byte_received:
 136                     ; 71 	}
 139  0006 81            	ret
 164                     ; 72 	u8 I2C_byte_write(void)
 164                     ; 73 	{
 165                     	switch	.text
 166  0007               _I2C_byte_write:
 170                     ; 74 		return 0x54;
 172  0007 a654          	ld	a,#84
 175  0009 81            	ret
 200                     ; 100  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 200                     ; 101 {
 202                     	switch	.text
 203  000a               f_ADC1_IRQHandler:
 205  000a 8a            	push	cc
 206  000b 84            	pop	a
 207  000c a4bf          	and	a,#191
 208  000e 88            	push	a
 209  000f 86            	pop	cc
 210  0010 3b0002        	push	c_x+2
 211  0013 be00          	ldw	x,c_x
 212  0015 89            	pushw	x
 213  0016 3b0002        	push	c_y+2
 214  0019 be00          	ldw	x,c_y
 215  001b 89            	pushw	x
 218                     ; 105 	state |= STATE_ADC_READY;
 220  001c 72100000      	bset	_state,#0
 221                     ; 106 	ADC1_ClearFlag(ADC1_FLAG_EOC);
 223  0020 a680          	ld	a,#128
 224  0022 cd0000        	call	_ADC1_ClearFlag
 226                     ; 107 }
 229  0025 85            	popw	x
 230  0026 bf00          	ldw	c_y,x
 231  0028 320002        	pop	c_y+2
 232  002b 85            	popw	x
 233  002c bf00          	ldw	c_x,x
 234  002e 320002        	pop	c_x+2
 235  0031 80            	iret
 260                     ; 143  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 260                     ; 144 {
 261                     	switch	.text
 262  0032               f_TIM2_UPD_OVF_BRK_IRQHandler:
 264  0032 8a            	push	cc
 265  0033 84            	pop	a
 266  0034 a4bf          	and	a,#191
 267  0036 88            	push	a
 268  0037 86            	pop	cc
 269  0038 3b0002        	push	c_x+2
 270  003b be00          	ldw	x,c_x
 271  003d 89            	pushw	x
 272  003e 3b0002        	push	c_y+2
 273  0041 be00          	ldw	x,c_y
 274  0043 89            	pushw	x
 277                     ; 145 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 279  0044 ae0001        	ldw	x,#1
 280  0047 cd0000        	call	_TIM2_ClearFlag
 282                     ; 146 	state |= STATE_TMR_TICK;
 284  004a 72140000      	bset	_state,#2
 285                     ; 147 }
 288  004e 85            	popw	x
 289  004f bf00          	ldw	c_y,x
 290  0051 320002        	pop	c_y+2
 291  0054 85            	popw	x
 292  0055 bf00          	ldw	c_x,x
 293  0057 320002        	pop	c_x+2
 294  005a 80            	iret
 296                     	switch	.ubsct
 297  0000               L77_sr1:
 298  0000 00            	ds.b	1
 299  0001               L101_sr2:
 300  0001 00            	ds.b	1
 301  0002               L301_sr3:
 302  0002 00            	ds.b	1
 358                     ; 156 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 358                     ; 157 {
 359                     	switch	.text
 360  005b               f_I2C_IRQHandler:
 362  005b 8a            	push	cc
 363  005c 84            	pop	a
 364  005d a4bf          	and	a,#191
 365  005f 88            	push	a
 366  0060 86            	pop	cc
 367  0061 3b0002        	push	c_x+2
 368  0064 be00          	ldw	x,c_x
 369  0066 89            	pushw	x
 370  0067 3b0002        	push	c_y+2
 371  006a be00          	ldw	x,c_y
 372  006c 89            	pushw	x
 375                     ; 163 	sr1 = I2C->SR1;
 377  006d 5552170000    	mov	L77_sr1,21015
 378                     ; 164 	sr2 = I2C->SR2;
 380  0072 5552180001    	mov	L101_sr2,21016
 381                     ; 165 	sr3 = I2C->SR3;
 383  0077 5552190002    	mov	L301_sr3,21017
 384                     ; 168   if (sr1 & I2C_SR1_ADDR)
 386  007c b600          	ld	a,L77_sr1
 387  007e a502          	bcp	a,#2
 388  0080 2702          	jreq	L331
 389                     ; 170 		Rx_Idx = 0;
 391  0082 3f01          	clr	_Rx_Idx
 392  0084               L331:
 393                     ; 174   if (sr1 & I2C_SR1_TXE)
 395  0084 b600          	ld	a,L77_sr1
 396  0086 a580          	bcp	a,#128
 397  0088 270b          	jreq	L531
 398                     ; 176 		I2C->DR = i2cBuffer1[Rx_Idx];
 400  008a b601          	ld	a,_Rx_Idx
 401  008c 5f            	clrw	x
 402  008d 97            	ld	xl,a
 403  008e e600          	ld	a,(_i2cBuffer1,x)
 404  0090 c75216        	ld	21014,a
 405                     ; 177 		Rx_Idx++;
 407  0093 3c01          	inc	_Rx_Idx
 408  0095               L531:
 409                     ; 180 	if (led.pattern == LED_OFF)
 411  0095 be01          	ldw	x,_led+1
 412  0097 2604          	jrne	L731
 413                     ; 182 		GPIOD->ODR = 0x00;
 415  0099 725f500f      	clr	20495
 416  009d               L731:
 417                     ; 186   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
 419  009d b601          	ld	a,L101_sr2
 420  009f a52b          	bcp	a,#43
 421  00a1 2719          	jreq	L141
 422                     ; 188     I2C->CR2 |= I2C_CR2_STOP;  // stop communication - release the lines
 424  00a3 72125211      	bset	21009,#1
 425                     ; 189     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF ????
 427  00a7 72145211      	bset	21009,#2
 428                     ; 190     I2C->SR2 = 0;					    // clear all error flags
 430  00ab 725f5218      	clr	21016
 431                     ; 191 		SetLED(LED_PANIC, 2);
 433  00af 4b02          	push	#2
 434  00b1 ae3333        	ldw	x,#13107
 435  00b4 cd0000        	call	_SetLED
 437  00b7 84            	pop	a
 438                     ; 192 		WWDG->CR = 0x80;
 440  00b8 358050d1      	mov	20689,#128
 441  00bc               L141:
 442                     ; 197   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
 444  00bc b600          	ld	a,L77_sr1
 445  00be a444          	and	a,#68
 446  00c0 a144          	cp	a,#68
 447  00c2 2605          	jrne	L341
 448                     ; 199 		Slave_Buffer_Rx[0] = I2C->DR;
 450  00c4 5552160026    	mov	_Slave_Buffer_Rx,21014
 451  00c9               L341:
 452                     ; 204   if (sr1 & I2C_SR1_RXNE)
 454  00c9 b600          	ld	a,L77_sr1
 455  00cb a540          	bcp	a,#64
 456  00cd 2705          	jreq	L541
 457                     ; 207 		Slave_Buffer_Rx[0] = I2C->DR;
 459  00cf 5552160026    	mov	_Slave_Buffer_Rx,21014
 460  00d4               L541:
 461                     ; 211   if (sr2 & I2C_SR2_AF)
 463  00d4 b601          	ld	a,L101_sr2
 464  00d6 a504          	bcp	a,#4
 465  00d8 2704          	jreq	L741
 466                     ; 213     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
 468  00da 72155218      	bres	21016,#2
 469  00de               L741:
 470                     ; 218   if (sr1 & I2C_SR1_STOPF)
 472  00de b600          	ld	a,L77_sr1
 473  00e0 a510          	bcp	a,#16
 474  00e2 2704          	jreq	L151
 475                     ; 220     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
 477  00e4 72145211      	bset	21009,#2
 478  00e8               L151:
 479                     ; 225   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
 481  00e8 b600          	ld	a,L77_sr1
 482  00ea a484          	and	a,#132
 483  00ec a184          	cp	a,#132
 484  00ee 2606          	jrne	L351
 485                     ; 227 		I2C->DR = I2C_byte_write();
 487  00f0 cd0007        	call	_I2C_byte_write
 489  00f3 c75216        	ld	21014,a
 490  00f6               L351:
 491                     ; 230 	if (led.pattern == LED_OFF)
 493  00f6 be01          	ldw	x,_led+1
 494  00f8 2604          	jrne	L551
 495                     ; 232 		GPIOD->ODR |= 0x08;
 497  00fa 7216500f      	bset	20495,#3
 498  00fe               L551:
 499                     ; 235 }
 502  00fe 85            	popw	x
 503  00ff bf00          	ldw	c_y,x
 504  0101 320002        	pop	c_y+2
 505  0104 85            	popw	x
 506  0105 bf00          	ldw	c_x,x
 507  0107 320002        	pop	c_x+2
 508  010a 80            	iret
 531                     ; 244  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 531                     ; 245 {
 532                     	switch	.text
 533  010b               f_TIM2_CAP_COM_IRQHandler:
 537                     ; 249 }
 540  010b 80            	iret
 563                     ; 289  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 563                     ; 290 {
 564                     	switch	.text
 565  010c               f_UART1_TX_IRQHandler:
 569                     ; 294 }
 572  010c 80            	iret
 595                     ; 302  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 595                     ; 303 {
 596                     	switch	.text
 597  010d               f_UART1_RX_IRQHandler:
 601                     ; 307 }
 604  010d 80            	iret
 627                     ; 388  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 627                     ; 389 {
 628                     	switch	.text
 629  010e               f_TIM4_UPD_OVF_IRQHandler:
 633                     ; 393 }
 636  010e 80            	iret
 659                     ; 402 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 659                     ; 403 {
 660                     	switch	.text
 661  010f               f_EEPROM_EEC_IRQHandler:
 665                     ; 407 }
 668  010f 80            	iret
 691                     ; 415 @far @interrupt void NonHandledInterrupt(void)
 691                     ; 416 {
 692                     	switch	.text
 693  0110               f_NonHandledInterrupt:
 697                     ; 420 }
 700  0110 80            	iret
 722                     ; 427 @far @interrupt void TRAP_IRQHandler(void)
 722                     ; 428 {
 723                     	switch	.text
 724  0111               f_TRAP_IRQHandler:
 728                     ; 432 }
 731  0111 80            	iret
 753                     ; 454 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 753                     ; 455 {
 754                     	switch	.text
 755  0112               f_TLI_IRQHandler:
 759                     ; 459 }
 762  0112 80            	iret
 784                     ; 467 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 784                     ; 468 {
 785                     	switch	.text
 786  0113               f_AWU_IRQHandler:
 790                     ; 472 }
 793  0113 80            	iret
 815                     ; 480 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 815                     ; 481 {
 816                     	switch	.text
 817  0114               f_CLK_IRQHandler:
 821                     ; 485 }
 824  0114 80            	iret
 847                     ; 493 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 847                     ; 494 {
 848                     	switch	.text
 849  0115               f_EXTI_PORTA_IRQHandler:
 853                     ; 498 }
 856  0115 80            	iret
 879                     ; 505 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 879                     ; 506 {
 880                     	switch	.text
 881  0116               f_EXTI_PORTB_IRQHandler:
 885                     ; 510 }
 888  0116 80            	iret
 911                     ; 518 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 911                     ; 519 {
 912                     	switch	.text
 913  0117               f_EXTI_PORTC_IRQHandler:
 917                     ; 523 }
 920  0117 80            	iret
 943                     ; 531 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 943                     ; 532 {
 944                     	switch	.text
 945  0118               f_EXTI_PORTD_IRQHandler:
 949                     ; 536 }
 952  0118 80            	iret
 975                     ; 544 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 975                     ; 545 {
 976                     	switch	.text
 977  0119               f_EXTI_PORTE_IRQHandler:
 981                     ; 549 }
 984  0119 80            	iret
1006                     ; 599 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
1006                     ; 600 {
1007                     	switch	.text
1008  011a               f_SPI_IRQHandler:
1012                     ; 604 }
1015  011a 80            	iret
1038                     ; 612 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
1038                     ; 613 {
1039                     	switch	.text
1040  011b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
1044                     ; 617 }
1047  011b 80            	iret
1070                     ; 625 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
1070                     ; 626 {
1071                     	switch	.text
1072  011c               f_TIM1_CAP_COM_IRQHandler:
1076                     ; 630 }
1079  011c 80            	iret
1160                     	xdef	_I2C_byte_write
1161                     	xdef	_I2C_byte_received
1162                     	xdef	_I2C_transaction_end
1163                     	xdef	_I2C_transaction_begin
1164                     	switch	.ubsct
1165  0003               _MessageBegin:
1166  0003 00            	ds.b	1
1167                     	xdef	_MessageBegin
1168  0004               _u8_MyBuffp:
1169  0004 0000          	ds.b	2
1170                     	xdef	_u8_MyBuffp
1171  0006               _u8_My_Buffer:
1172  0006 000000000000  	ds.b	32
1173                     	xdef	_u8_My_Buffer
1174  0026               _Slave_Buffer_Rx:
1175  0026 000000000000  	ds.b	8
1176                     	xdef	_Slave_Buffer_Rx
1177                     	xdef	_Rx_Idx
1178                     	xdef	_idxMode
1179  002e               _modeBuffer:
1180  002e 00000000      	ds.b	4
1181                     	xdef	_modeBuffer
1182                     	xref	_SetLED
1183                     	xref.b	_led
1184                     	xref.b	_i2cBuffer1
1185                     	xref.b	_state
1186                     	xdef	f_EEPROM_EEC_IRQHandler
1187                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1188                     	xdef	f_ADC1_IRQHandler
1189                     	xdef	f_I2C_IRQHandler
1190                     	xdef	f_UART1_RX_IRQHandler
1191                     	xdef	f_UART1_TX_IRQHandler
1192                     	xdef	f_TIM2_CAP_COM_IRQHandler
1193                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1194                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1195                     	xdef	f_TIM1_CAP_COM_IRQHandler
1196                     	xdef	f_SPI_IRQHandler
1197                     	xdef	f_EXTI_PORTE_IRQHandler
1198                     	xdef	f_EXTI_PORTD_IRQHandler
1199                     	xdef	f_EXTI_PORTC_IRQHandler
1200                     	xdef	f_EXTI_PORTB_IRQHandler
1201                     	xdef	f_EXTI_PORTA_IRQHandler
1202                     	xdef	f_CLK_IRQHandler
1203                     	xdef	f_AWU_IRQHandler
1204                     	xdef	f_TLI_IRQHandler
1205                     	xdef	f_TRAP_IRQHandler
1206                     	xdef	f_NonHandledInterrupt
1207                     	xref	_TIM2_ClearFlag
1208                     	xref	_ADC1_ClearFlag
1209                     	xref.b	c_x
1210                     	xref.b	c_y
1230                     	end
