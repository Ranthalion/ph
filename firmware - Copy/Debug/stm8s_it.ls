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
 133                     ; 61 	void I2C_byte_received(u8 u8_RxData)
 133                     ; 62 	{
 134                     	switch	.text
 135  0006               _I2C_byte_received:
 137  0006 88            	push	a
 138       00000000      OFST:	set	0
 141                     ; 63 		if (MessageBegin == TRUE  &&  u8_RxData < MAX_BUFFER) {
 143  0007 b603          	ld	a,_MessageBegin
 144  0009 a101          	cp	a,#1
 145  000b 2612          	jrne	L74
 147  000d 7b01          	ld	a,(OFST+1,sp)
 148  000f a120          	cp	a,#32
 149  0011 240c          	jruge	L74
 150                     ; 64 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
 152  0013 7b01          	ld	a,(OFST+1,sp)
 153  0015 ab06          	add	a,#_u8_My_Buffer
 154  0017 5f            	clrw	x
 155  0018 97            	ld	xl,a
 156  0019 bf04          	ldw	_u8_MyBuffp,x
 157                     ; 65 			MessageBegin = FALSE;
 159  001b 3f03          	clr	_MessageBegin
 161  001d 2014          	jra	L15
 162  001f               L74:
 163                     ; 67     else if(u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
 165  001f be04          	ldw	x,_u8_MyBuffp
 166  0021 a30026        	cpw	x,#_u8_My_Buffer+32
 167  0024 240d          	jruge	L15
 168                     ; 68       *(u8_MyBuffp++) = u8_RxData;
 170  0026 7b01          	ld	a,(OFST+1,sp)
 171  0028 be04          	ldw	x,_u8_MyBuffp
 172  002a 1c0001        	addw	x,#1
 173  002d bf04          	ldw	_u8_MyBuffp,x
 174  002f 1d0001        	subw	x,#1
 175  0032 f7            	ld	(x),a
 176  0033               L15:
 177                     ; 69 	}
 180  0033 84            	pop	a
 181  0034 81            	ret
 206                     ; 70 	u8 I2C_byte_write(void)
 206                     ; 71 	{
 207                     	switch	.text
 208  0035               _I2C_byte_write:
 212                     ; 72 		return 0x54;
 214  0035 a654          	ld	a,#84
 217  0037 81            	ret
 242                     ; 98  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 242                     ; 99 {
 244                     	switch	.text
 245  0038               f_ADC1_IRQHandler:
 247  0038 8a            	push	cc
 248  0039 84            	pop	a
 249  003a a4bf          	and	a,#191
 250  003c 88            	push	a
 251  003d 86            	pop	cc
 252  003e 3b0002        	push	c_x+2
 253  0041 be00          	ldw	x,c_x
 254  0043 89            	pushw	x
 255  0044 3b0002        	push	c_y+2
 256  0047 be00          	ldw	x,c_y
 257  0049 89            	pushw	x
 260                     ; 103 	state |= STATE_ADC_READY;
 262  004a 72100000      	bset	_state,#0
 263                     ; 104 	ADC1_ClearFlag(ADC1_FLAG_EOC);
 265  004e a680          	ld	a,#128
 266  0050 cd0000        	call	_ADC1_ClearFlag
 268                     ; 105 }
 271  0053 85            	popw	x
 272  0054 bf00          	ldw	c_y,x
 273  0056 320002        	pop	c_y+2
 274  0059 85            	popw	x
 275  005a bf00          	ldw	c_x,x
 276  005c 320002        	pop	c_x+2
 277  005f 80            	iret
 302                     ; 141  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 302                     ; 142 {
 303                     	switch	.text
 304  0060               f_TIM2_UPD_OVF_BRK_IRQHandler:
 306  0060 8a            	push	cc
 307  0061 84            	pop	a
 308  0062 a4bf          	and	a,#191
 309  0064 88            	push	a
 310  0065 86            	pop	cc
 311  0066 3b0002        	push	c_x+2
 312  0069 be00          	ldw	x,c_x
 313  006b 89            	pushw	x
 314  006c 3b0002        	push	c_y+2
 315  006f be00          	ldw	x,c_y
 316  0071 89            	pushw	x
 319                     ; 143 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 321  0072 ae0001        	ldw	x,#1
 322  0075 cd0000        	call	_TIM2_ClearFlag
 324                     ; 144 	state |= STATE_TMR_TICK;	
 326  0078 72140000      	bset	_state,#2
 327                     ; 145 }
 330  007c 85            	popw	x
 331  007d bf00          	ldw	c_y,x
 332  007f 320002        	pop	c_y+2
 333  0082 85            	popw	x
 334  0083 bf00          	ldw	c_x,x
 335  0085 320002        	pop	c_x+2
 336  0088 80            	iret
 338                     	switch	.ubsct
 339  0000               L501_sr1:
 340  0000 00            	ds.b	1
 341  0001               L701_sr2:
 342  0001 00            	ds.b	1
 343  0002               L111_sr3:
 344  0002 00            	ds.b	1
 399                     ; 154 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 399                     ; 155 {
 400                     	switch	.text
 401  0089               f_I2C_IRQHandler:
 403  0089 8a            	push	cc
 404  008a 84            	pop	a
 405  008b a4bf          	and	a,#191
 406  008d 88            	push	a
 407  008e 86            	pop	cc
 408  008f 3b0002        	push	c_x+2
 409  0092 be00          	ldw	x,c_x
 410  0094 89            	pushw	x
 411  0095 3b0002        	push	c_y+2
 412  0098 be00          	ldw	x,c_y
 413  009a 89            	pushw	x
 416                     ; 161 	sr1 = I2C->SR1;
 418  009b 5552170000    	mov	L501_sr1,21015
 419                     ; 162 	sr2 = I2C->SR2;
 421  00a0 5552180001    	mov	L701_sr2,21016
 422                     ; 163 	sr3 = I2C->SR3;
 424  00a5 5552190002    	mov	L111_sr3,21017
 425                     ; 166   if (sr1 & I2C_SR1_ADDR)
 427  00aa b600          	ld	a,L501_sr1
 428  00ac a502          	bcp	a,#2
 429  00ae 2706          	jreq	L141
 430                     ; 168 		GPIOD->ODR &= 0b11110111;
 432  00b0 7217500f      	bres	20495,#3
 433                     ; 169 		Rx_Idx = 0;  //Should I put this at the stop bit instead?
 435  00b4 3f01          	clr	_Rx_Idx
 436  00b6               L141:
 437                     ; 175   if (sr1 & I2C_SR1_TXE)
 439  00b6 b600          	ld	a,L501_sr1
 440  00b8 a580          	bcp	a,#128
 441  00ba 2711          	jreq	L341
 442                     ; 177 		GPIOD->ODR &= 0b11011111;
 444  00bc 721b500f      	bres	20495,#5
 445                     ; 194 		I2C->DR = i2cBuffer1[Rx_Idx++];
 447  00c0 b601          	ld	a,_Rx_Idx
 448  00c2 97            	ld	xl,a
 449  00c3 3c01          	inc	_Rx_Idx
 450  00c5 9f            	ld	a,xl
 451  00c6 5f            	clrw	x
 452  00c7 97            	ld	xl,a
 453  00c8 e600          	ld	a,(_i2cBuffer1,x)
 454  00ca c75216        	ld	21014,a
 455  00cd               L341:
 456                     ; 203   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
 458  00cd b601          	ld	a,L701_sr2
 459  00cf a52b          	bcp	a,#43
 460  00d1 270e          	jreq	L541
 461                     ; 205 		GPIOD->ODR = 0x00;	
 463  00d3 725f500f      	clr	20495
 464                     ; 207     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
 466  00d7 72125211      	bset	21009,#1
 467                     ; 208     I2C->SR2= 0;					    // clear all error flags
 469  00db 725f5218      	clr	21016
 470                     ; 209 		return;
 472  00df 204a          	jra	L22
 473  00e1               L541:
 474                     ; 214   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
 476  00e1 b600          	ld	a,L501_sr1
 477  00e3 a444          	and	a,#68
 478  00e5 a144          	cp	a,#68
 479  00e7 2606          	jrne	L741
 480                     ; 216     I2C_byte_received(I2C->DR);
 482  00e9 c65216        	ld	a,21014
 483  00ec cd0006        	call	_I2C_byte_received
 485  00ef               L741:
 486                     ; 221   if (sr1 & I2C_SR1_RXNE)
 488  00ef b600          	ld	a,L501_sr1
 489  00f1 a540          	bcp	a,#64
 490  00f3 2706          	jreq	L151
 491                     ; 223     I2C_byte_received(I2C->DR);		
 493  00f5 c65216        	ld	a,21014
 494  00f8 cd0006        	call	_I2C_byte_received
 496  00fb               L151:
 497                     ; 227   if (sr2 & I2C_SR2_AF)
 499  00fb b601          	ld	a,L701_sr2
 500  00fd a504          	bcp	a,#4
 501  00ff 2707          	jreq	L351
 502                     ; 229     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
 504  0101 72155218      	bres	21016,#2
 505                     ; 230 		I2C_transaction_end();		
 507  0105 cd0005        	call	_I2C_transaction_end
 509  0108               L351:
 510                     ; 234   if (sr1 & I2C_SR1_STOPF) 
 512  0108 b600          	ld	a,L501_sr1
 513  010a a510          	bcp	a,#16
 514  010c 2707          	jreq	L551
 515                     ; 236     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
 517  010e 72145211      	bset	21009,#2
 518                     ; 237 		I2C_transaction_end();		
 520  0112 cd0005        	call	_I2C_transaction_end
 522  0115               L551:
 523                     ; 241   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
 525  0115 b600          	ld	a,L501_sr1
 526  0117 a484          	and	a,#132
 527  0119 a184          	cp	a,#132
 528  011b 2606          	jrne	L751
 529                     ; 243 		I2C->DR = I2C_byte_write();
 531  011d cd0035        	call	_I2C_byte_write
 533  0120 c75216        	ld	21014,a
 534  0123               L751:
 535                     ; 245 	GPIOD->ODR |= 0b00101000;
 537  0123 c6500f        	ld	a,20495
 538  0126 aa28          	or	a,#40
 539  0128 c7500f        	ld	20495,a
 540                     ; 246 }
 541  012b               L22:
 544  012b 85            	popw	x
 545  012c bf00          	ldw	c_y,x
 546  012e 320002        	pop	c_y+2
 547  0131 85            	popw	x
 548  0132 bf00          	ldw	c_x,x
 549  0134 320002        	pop	c_x+2
 550  0137 80            	iret
 573                     ; 255  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 573                     ; 256 {
 574                     	switch	.text
 575  0138               f_TIM2_CAP_COM_IRQHandler:
 579                     ; 260 }
 582  0138 80            	iret
 605                     ; 300  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 605                     ; 301 {
 606                     	switch	.text
 607  0139               f_UART1_TX_IRQHandler:
 611                     ; 305 }
 614  0139 80            	iret
 637                     ; 313  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 637                     ; 314 {
 638                     	switch	.text
 639  013a               f_UART1_RX_IRQHandler:
 643                     ; 318 }
 646  013a 80            	iret
 669                     ; 399  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 669                     ; 400 {
 670                     	switch	.text
 671  013b               f_TIM4_UPD_OVF_IRQHandler:
 675                     ; 404 }
 678  013b 80            	iret
 701                     ; 413 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 701                     ; 414 {
 702                     	switch	.text
 703  013c               f_EEPROM_EEC_IRQHandler:
 707                     ; 418 }
 710  013c 80            	iret
 733                     ; 426 @far @interrupt void NonHandledInterrupt(void)
 733                     ; 427 {
 734                     	switch	.text
 735  013d               f_NonHandledInterrupt:
 739                     ; 431 }
 742  013d 80            	iret
 764                     ; 438 @far @interrupt void TRAP_IRQHandler(void)
 764                     ; 439 {
 765                     	switch	.text
 766  013e               f_TRAP_IRQHandler:
 770                     ; 443 }
 773  013e 80            	iret
 795                     ; 465 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 795                     ; 466 {
 796                     	switch	.text
 797  013f               f_TLI_IRQHandler:
 801                     ; 470 }
 804  013f 80            	iret
 826                     ; 478 INTERRUPT_HANDLER(AWU_IRQHandler, 1)	
 826                     ; 479 {
 827                     	switch	.text
 828  0140               f_AWU_IRQHandler:
 832                     ; 483 }
 835  0140 80            	iret
 857                     ; 491 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 857                     ; 492 {
 858                     	switch	.text
 859  0141               f_CLK_IRQHandler:
 863                     ; 496 }
 866  0141 80            	iret
 889                     ; 504 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 889                     ; 505 {
 890                     	switch	.text
 891  0142               f_EXTI_PORTA_IRQHandler:
 895                     ; 509 }
 898  0142 80            	iret
 921                     ; 516 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 921                     ; 517 {
 922                     	switch	.text
 923  0143               f_EXTI_PORTB_IRQHandler:
 927                     ; 521 }
 930  0143 80            	iret
 953                     ; 529 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 953                     ; 530 {
 954                     	switch	.text
 955  0144               f_EXTI_PORTC_IRQHandler:
 959                     ; 534 }
 962  0144 80            	iret
 985                     ; 542 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 985                     ; 543 {
 986                     	switch	.text
 987  0145               f_EXTI_PORTD_IRQHandler:
 991                     ; 547 }
 994  0145 80            	iret
1017                     ; 555 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
1017                     ; 556 {
1018                     	switch	.text
1019  0146               f_EXTI_PORTE_IRQHandler:
1023                     ; 560 }
1026  0146 80            	iret
1048                     ; 610 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
1048                     ; 611 {
1049                     	switch	.text
1050  0147               f_SPI_IRQHandler:
1054                     ; 615 }
1057  0147 80            	iret
1080                     ; 623 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
1080                     ; 624 {
1081                     	switch	.text
1082  0148               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
1086                     ; 628 }
1089  0148 80            	iret
1112                     ; 636 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
1112                     ; 637 {
1113                     	switch	.text
1114  0149               f_TIM1_CAP_COM_IRQHandler:
1118                     ; 641 }
1121  0149 80            	iret
1202                     	xdef	_I2C_byte_write
1203                     	xdef	_I2C_byte_received
1204                     	xdef	_I2C_transaction_end
1205                     	xdef	_I2C_transaction_begin
1206                     	switch	.ubsct
1207  0003               _MessageBegin:
1208  0003 00            	ds.b	1
1209                     	xdef	_MessageBegin
1210  0004               _u8_MyBuffp:
1211  0004 0000          	ds.b	2
1212                     	xdef	_u8_MyBuffp
1213  0006               _u8_My_Buffer:
1214  0006 000000000000  	ds.b	32
1215                     	xdef	_u8_My_Buffer
1216  0026               _Slave_Buffer_Rx:
1217  0026 000000000000  	ds.b	8
1218                     	xdef	_Slave_Buffer_Rx
1219                     	xdef	_Rx_Idx
1220                     	xdef	_idxMode
1221  002e               _modeBuffer:
1222  002e 00000000      	ds.b	4
1223                     	xdef	_modeBuffer
1224                     	xref.b	_i2cBuffer1
1225                     	xref.b	_state
1226                     	xdef	f_EEPROM_EEC_IRQHandler
1227                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1228                     	xdef	f_ADC1_IRQHandler
1229                     	xdef	f_I2C_IRQHandler
1230                     	xdef	f_UART1_RX_IRQHandler
1231                     	xdef	f_UART1_TX_IRQHandler
1232                     	xdef	f_TIM2_CAP_COM_IRQHandler
1233                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1234                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1235                     	xdef	f_TIM1_CAP_COM_IRQHandler
1236                     	xdef	f_SPI_IRQHandler
1237                     	xdef	f_EXTI_PORTE_IRQHandler
1238                     	xdef	f_EXTI_PORTD_IRQHandler
1239                     	xdef	f_EXTI_PORTC_IRQHandler
1240                     	xdef	f_EXTI_PORTB_IRQHandler
1241                     	xdef	f_EXTI_PORTA_IRQHandler
1242                     	xdef	f_CLK_IRQHandler
1243                     	xdef	f_AWU_IRQHandler
1244                     	xdef	f_TLI_IRQHandler
1245                     	xdef	f_TRAP_IRQHandler
1246                     	xdef	f_NonHandledInterrupt
1247                     	xref	_TIM2_ClearFlag
1248                     	xref	_ADC1_ClearFlag
1249                     	xref.b	c_x
1250                     	xref.b	c_y
1270                     	end
