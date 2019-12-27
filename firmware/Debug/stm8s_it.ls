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
 182                     ; 117 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 182                     ; 118 {
 183                     	switch	.text
 184  0051               f_I2C_IRQHandler:
 186  0051 8a            	push	cc
 187  0052 84            	pop	a
 188  0053 a4bf          	and	a,#191
 189  0055 88            	push	a
 190  0056 86            	pop	cc
 191  0057 3b0002        	push	c_x+2
 192  005a be00          	ldw	x,c_x
 193  005c 89            	pushw	x
 194  005d 3b0002        	push	c_y+2
 195  0060 be00          	ldw	x,c_y
 196  0062 89            	pushw	x
 199                     ; 120 	reg = I2C->SR2;
 201  0063 5552180004    	mov	_reg,21016
 202                     ; 122   if ((reg) != 0)
 204  0068 3d04          	tnz	_reg
 205  006a 272b          	jreq	L75
 206                     ; 125     I2C->SR2 = 0;
 208  006c 725f5218      	clr	21016
 209                     ; 127 		if (reg != 0x04)
 211  0070 b604          	ld	a,_reg
 212  0072 a104          	cp	a,#4
 213  0074 2709          	jreq	L16
 214                     ; 129 			SetLED(LED_PANIC, 1);
 216  0076 4b01          	push	#1
 217  0078 aeaaaa        	ldw	x,#43690
 218  007b cd0000        	call	_SetLED
 220  007e 84            	pop	a
 221  007f               L16:
 222                     ; 131 		if (reg & 0x04)
 224  007f b604          	ld	a,_reg
 225  0081 a504          	bcp	a,#4
 226  0083 2712          	jreq	L75
 227                     ; 133 			modeBuffer[idxMode++] = 9;
 229  0085 b605          	ld	a,_idxMode
 230  0087 97            	ld	xl,a
 231  0088 3c05          	inc	_idxMode
 232  008a 9f            	ld	a,xl
 233  008b 5f            	clrw	x
 234  008c 97            	ld	xl,a
 235  008d a609          	ld	a,#9
 236  008f e700          	ld	(_modeBuffer,x),a
 237                     ; 134 			idxMode = idxMode & 0x3F;
 239  0091 b605          	ld	a,_idxMode
 240  0093 a43f          	and	a,#63
 241  0095 b705          	ld	_idxMode,a
 242  0097               L75:
 243                     ; 138   Event = I2C_GetLastEvent();
 245  0097 cd0000        	call	_I2C_GetLastEvent
 247  009a bf02          	ldw	_Event,x
 248                     ; 139   switch (Event)
 250  009c be02          	ldw	x,_Event
 252                     ; 199     default:
 252                     ; 200 			//modeBuffer[idxMode++] = 7;
 252                     ; 201 			//idxMode = idxMode & 0x0F;
 252                     ; 202       break;
 253  009e 1d0004        	subw	x,#4
 254  00a1 2604          	jrne	L21
 255  00a3 ac650165      	jpf	L34
 256  00a7               L21:
 257  00a7 1d000c        	subw	x,#12
 258  00aa 2604          	jrne	L41
 259  00ac ac4d014d      	jpf	L14
 260  00b0               L41:
 261  00b0 1d01f2        	subw	x,#498
 262  00b3 2747          	jreq	L53
 263  00b5 1d003e        	subw	x,#62
 264  00b8 2756          	jreq	L73
 265  00ba 1d0440        	subw	x,#1088
 266  00bd 2723          	jreq	L33
 267  00bf 1d0002        	subw	x,#2
 268  00c2 2704          	jreq	L61
 269  00c4 ac800180      	jpf	L76
 270  00c8               L61:
 271                     ; 143     case I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED:
 271                     ; 144       Tx_Idx = 1;
 273  00c8 35010000      	mov	_Tx_Idx,#1
 274                     ; 145 			modeBuffer[idxMode++] = 1;
 276  00cc b605          	ld	a,_idxMode
 277  00ce 97            	ld	xl,a
 278  00cf 3c05          	inc	_idxMode
 279  00d1 9f            	ld	a,xl
 280  00d2 5f            	clrw	x
 281  00d3 97            	ld	xl,a
 282  00d4 a601          	ld	a,#1
 283  00d6 e700          	ld	(_modeBuffer,x),a
 284                     ; 146 			idxMode = idxMode & 0x3F;
 286  00d8 b605          	ld	a,_idxMode
 287  00da a43f          	and	a,#63
 288  00dc b705          	ld	_idxMode,a
 289                     ; 147       break;
 291  00de ac800180      	jpf	L76
 292  00e2               L33:
 293                     ; 150     case I2C_EVENT_SLAVE_BYTE_TRANSMITTING:
 293                     ; 151       /* Transmit data */
 293                     ; 152 			modeBuffer[idxMode++] = 2;
 295  00e2 b605          	ld	a,_idxMode
 296  00e4 97            	ld	xl,a
 297  00e5 3c05          	inc	_idxMode
 298  00e7 9f            	ld	a,xl
 299  00e8 5f            	clrw	x
 300  00e9 97            	ld	xl,a
 301  00ea a602          	ld	a,#2
 302  00ec e700          	ld	(_modeBuffer,x),a
 303                     ; 153 			idxMode = idxMode & 0x3F;
 305  00ee b605          	ld	a,_idxMode
 306  00f0 a43f          	and	a,#63
 307  00f2 b705          	ld	_idxMode,a
 308                     ; 154       I2C_SendData(0x00);
 310  00f4 4f            	clr	a
 311  00f5 cd0000        	call	_I2C_SendData
 313                     ; 161       break;
 315  00f8 ac800180      	jpf	L76
 316  00fc               L53:
 317                     ; 164     case I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED:
 317                     ; 165 			modeBuffer[idxMode++] = 3;
 319  00fc b605          	ld	a,_idxMode
 320  00fe 97            	ld	xl,a
 321  00ff 3c05          	inc	_idxMode
 322  0101 9f            	ld	a,xl
 323  0102 5f            	clrw	x
 324  0103 97            	ld	xl,a
 325  0104 a603          	ld	a,#3
 326  0106 e700          	ld	(_modeBuffer,x),a
 327                     ; 166 			idxMode = idxMode & 0x3F;
 329  0108 b605          	ld	a,_idxMode
 330  010a a43f          	and	a,#63
 331  010c b705          	ld	_idxMode,a
 332                     ; 167       break;
 334  010e 2070          	jra	L76
 335  0110               L73:
 336                     ; 170     case I2C_EVENT_SLAVE_BYTE_RECEIVED:
 336                     ; 171 			modeBuffer[idxMode++] = 4;
 338  0110 b605          	ld	a,_idxMode
 339  0112 97            	ld	xl,a
 340  0113 3c05          	inc	_idxMode
 341  0115 9f            	ld	a,xl
 342  0116 5f            	clrw	x
 343  0117 97            	ld	xl,a
 344  0118 a604          	ld	a,#4
 345  011a e700          	ld	(_modeBuffer,x),a
 346                     ; 172 			idxMode = idxMode & 0x3F;
 348  011c b605          	ld	a,_idxMode
 349  011e a43f          	and	a,#63
 350  0120 b705          	ld	_idxMode,a
 351                     ; 173       Slave_Buffer_Rx[Rx_Idx++] = I2C_ReceiveData();
 353  0122 b601          	ld	a,_Rx_Idx
 354  0124 97            	ld	xl,a
 355  0125 3c01          	inc	_Rx_Idx
 356  0127 9f            	ld	a,xl
 357  0128 5f            	clrw	x
 358  0129 97            	ld	xl,a
 359  012a 89            	pushw	x
 360  012b cd0000        	call	_I2C_ReceiveData
 362  012e 85            	popw	x
 363  012f e740          	ld	(_Slave_Buffer_Rx,x),a
 364                     ; 174 			modeBuffer[idxMode++] = 4;
 366  0131 b605          	ld	a,_idxMode
 367  0133 97            	ld	xl,a
 368  0134 3c05          	inc	_idxMode
 369  0136 9f            	ld	a,xl
 370  0137 5f            	clrw	x
 371  0138 97            	ld	xl,a
 372  0139 a604          	ld	a,#4
 373  013b e700          	ld	(_modeBuffer,x),a
 374                     ; 175 			idxMode = idxMode & 0x3F;
 376  013d b605          	ld	a,_idxMode
 377  013f a43f          	and	a,#63
 378  0141 b705          	ld	_idxMode,a
 379                     ; 176 			if (Rx_Idx >= 8)
 381  0143 b601          	ld	a,_Rx_Idx
 382  0145 a108          	cp	a,#8
 383  0147 2537          	jrult	L76
 384                     ; 178 				Rx_Idx = 0;
 386  0149 3f01          	clr	_Rx_Idx
 387  014b 2033          	jra	L76
 388  014d               L14:
 389                     ; 184     case (I2C_EVENT_SLAVE_STOP_DETECTED):
 389                     ; 185 			modeBuffer[idxMode++] = 5;
 391  014d b605          	ld	a,_idxMode
 392  014f 97            	ld	xl,a
 393  0150 3c05          	inc	_idxMode
 394  0152 9f            	ld	a,xl
 395  0153 5f            	clrw	x
 396  0154 97            	ld	xl,a
 397  0155 a605          	ld	a,#5
 398  0157 e700          	ld	(_modeBuffer,x),a
 399                     ; 186 			idxMode = idxMode & 0x3F;
 401  0159 b605          	ld	a,_idxMode
 402  015b a43f          	and	a,#63
 403  015d b705          	ld	_idxMode,a
 404                     ; 188 			I2C->CR2 |= I2C_CR2_ACK;
 406  015f 72145211      	bset	21009,#2
 407                     ; 191       break;
 409  0163 201b          	jra	L76
 410  0165               L34:
 411                     ; 193 		case (I2C_EVENT_SLAVE_ACK_FAILURE):
 411                     ; 194 			modeBuffer[idxMode++] = 6;
 413  0165 b605          	ld	a,_idxMode
 414  0167 97            	ld	xl,a
 415  0168 3c05          	inc	_idxMode
 416  016a 9f            	ld	a,xl
 417  016b 5f            	clrw	x
 418  016c 97            	ld	xl,a
 419  016d a606          	ld	a,#6
 420  016f e700          	ld	(_modeBuffer,x),a
 421                     ; 195 			idxMode = idxMode & 0x3F;
 423  0171 b605          	ld	a,_idxMode
 424  0173 a43f          	and	a,#63
 425  0175 b705          	ld	_idxMode,a
 426                     ; 196 			SetLED(LED_PANIC, 2);
 428  0177 4b02          	push	#2
 429  0179 aeaaaa        	ldw	x,#43690
 430  017c cd0000        	call	_SetLED
 432  017f 84            	pop	a
 433                     ; 198 			break;
 435  0180               L54:
 436                     ; 199     default:
 436                     ; 200 			//modeBuffer[idxMode++] = 7;
 436                     ; 201 			//idxMode = idxMode & 0x0F;
 436                     ; 202       break;
 438  0180               L76:
 439                     ; 205 }
 442  0180 85            	popw	x
 443  0181 bf00          	ldw	c_y,x
 444  0183 320002        	pop	c_y+2
 445  0186 85            	popw	x
 446  0187 bf00          	ldw	c_x,x
 447  0189 320002        	pop	c_x+2
 448  018c 80            	iret
 471                     ; 214  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 471                     ; 215 {
 472                     	switch	.text
 473  018d               f_TIM2_CAP_COM_IRQHandler:
 477                     ; 219 }
 480  018d 80            	iret
 503                     ; 259  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 503                     ; 260 {
 504                     	switch	.text
 505  018e               f_UART1_TX_IRQHandler:
 509                     ; 264 }
 512  018e 80            	iret
 535                     ; 272  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 535                     ; 273 {
 536                     	switch	.text
 537  018f               f_UART1_RX_IRQHandler:
 541                     ; 277 }
 544  018f 80            	iret
 567                     ; 358  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 567                     ; 359 {
 568                     	switch	.text
 569  0190               f_TIM4_UPD_OVF_IRQHandler:
 573                     ; 363 }
 576  0190 80            	iret
 599                     ; 372 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 599                     ; 373 {
 600                     	switch	.text
 601  0191               f_EEPROM_EEC_IRQHandler:
 605                     ; 377 }
 608  0191 80            	iret
 631                     ; 385 @far @interrupt void NonHandledInterrupt(void)
 631                     ; 386 {
 632                     	switch	.text
 633  0192               f_NonHandledInterrupt:
 637                     ; 390 }
 640  0192 80            	iret
 662                     ; 397 @far @interrupt void TRAP_IRQHandler(void)
 662                     ; 398 {
 663                     	switch	.text
 664  0193               f_TRAP_IRQHandler:
 668                     ; 402 }
 671  0193 80            	iret
 693                     ; 424 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 693                     ; 425 {
 694                     	switch	.text
 695  0194               f_TLI_IRQHandler:
 699                     ; 429 }
 702  0194 80            	iret
 724                     ; 437 INTERRUPT_HANDLER(AWU_IRQHandler, 1)	
 724                     ; 438 {
 725                     	switch	.text
 726  0195               f_AWU_IRQHandler:
 730                     ; 442 }
 733  0195 80            	iret
 755                     ; 450 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 755                     ; 451 {
 756                     	switch	.text
 757  0196               f_CLK_IRQHandler:
 761                     ; 455 }
 764  0196 80            	iret
 787                     ; 463 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 787                     ; 464 {
 788                     	switch	.text
 789  0197               f_EXTI_PORTA_IRQHandler:
 793                     ; 468 }
 796  0197 80            	iret
 819                     ; 475 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 819                     ; 476 {
 820                     	switch	.text
 821  0198               f_EXTI_PORTB_IRQHandler:
 825                     ; 480 }
 828  0198 80            	iret
 851                     ; 488 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 851                     ; 489 {
 852                     	switch	.text
 853  0199               f_EXTI_PORTC_IRQHandler:
 857                     ; 493 }
 860  0199 80            	iret
 883                     ; 501 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 883                     ; 502 {
 884                     	switch	.text
 885  019a               f_EXTI_PORTD_IRQHandler:
 889                     ; 506 }
 892  019a 80            	iret
 915                     ; 514 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 915                     ; 515 {
 916                     	switch	.text
 917  019b               f_EXTI_PORTE_IRQHandler:
 921                     ; 519 }
 924  019b 80            	iret
 946                     ; 569 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 946                     ; 570 {
 947                     	switch	.text
 948  019c               f_SPI_IRQHandler:
 952                     ; 574 }
 955  019c 80            	iret
 978                     ; 582 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 978                     ; 583 {
 979                     	switch	.text
 980  019d               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 984                     ; 587 }
 987  019d 80            	iret
1010                     ; 595 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
1010                     ; 596 {
1011                     	switch	.text
1012  019e               f_TIM1_CAP_COM_IRQHandler:
1016                     ; 600 }
1019  019e 80            	iret
1098                     	xdef	_idxMode
1099                     	switch	.ubsct
1100  0000               _modeBuffer:
1101  0000 000000000000  	ds.b	64
1102                     	xdef	_modeBuffer
1103                     	xdef	_reg
1104                     	xdef	_Event
1105                     	xdef	_Rx_Idx
1106                     	xdef	_Tx_Idx
1107  0040               _Slave_Buffer_Rx:
1108  0040 000000000000  	ds.b	8
1109                     	xdef	_Slave_Buffer_Rx
1110                     	xref	_SetLED
1111                     	xref.b	_state
1112                     	xdef	f_EEPROM_EEC_IRQHandler
1113                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1114                     	xdef	f_ADC1_IRQHandler
1115                     	xdef	f_I2C_IRQHandler
1116                     	xdef	f_UART1_RX_IRQHandler
1117                     	xdef	f_UART1_TX_IRQHandler
1118                     	xdef	f_TIM2_CAP_COM_IRQHandler
1119                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1120                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1121                     	xdef	f_TIM1_CAP_COM_IRQHandler
1122                     	xdef	f_SPI_IRQHandler
1123                     	xdef	f_EXTI_PORTE_IRQHandler
1124                     	xdef	f_EXTI_PORTD_IRQHandler
1125                     	xdef	f_EXTI_PORTC_IRQHandler
1126                     	xdef	f_EXTI_PORTB_IRQHandler
1127                     	xdef	f_EXTI_PORTA_IRQHandler
1128                     	xdef	f_CLK_IRQHandler
1129                     	xdef	f_AWU_IRQHandler
1130                     	xdef	f_TLI_IRQHandler
1131                     	xdef	f_TRAP_IRQHandler
1132                     	xdef	f_NonHandledInterrupt
1133                     	xref	_TIM2_ClearFlag
1134                     	xref	_I2C_GetLastEvent
1135                     	xref	_I2C_SendData
1136                     	xref	_I2C_ReceiveData
1137                     	xref	_ADC1_ClearFlag
1138                     	xref.b	c_x
1139                     	xref.b	c_y
1159                     	end
