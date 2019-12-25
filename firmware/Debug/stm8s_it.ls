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
  51                     ; 55 @far @interrupt void NonHandledInterrupt(void)
  51                     ; 56 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 60 }
  60  0000 80            	iret
  82                     ; 67 @far @interrupt void TRAP_IRQHandler(void)
  82                     ; 68 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 72 }
  91  0001 80            	iret
 113                     ; 94 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 95 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 99 }
 122  0002 80            	iret
 144                     ; 107 INTERRUPT_HANDLER(AWU_IRQHandler, 1)	
 144                     ; 108 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 112 }
 153  0003 80            	iret
 175                     ; 120 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 121 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 125 }
 184  0004 80            	iret
 207                     ; 133 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 134 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 138 }
 216  0005 80            	iret
 239                     ; 145 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 146 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 150 }
 248  0006 80            	iret
 271                     ; 158 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 159 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 163 }
 280  0007 80            	iret
 303                     ; 171 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 172 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 176 }
 312  0008 80            	iret
 335                     ; 184 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 185 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 189 }
 344  0009 80            	iret
 366                     ; 239 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 240 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 244 }
 375  000a 80            	iret
 398                     ; 252 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 253 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 257 }
 407  000b 80            	iret
 430                     ; 265 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 266 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 270 }
 439  000c 80            	iret
 464                     ; 305  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 464                     ; 306 {
 465                     	switch	.text
 466  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 468  000d 8a            	push	cc
 469  000e 84            	pop	a
 470  000f a4bf          	and	a,#191
 471  0011 88            	push	a
 472  0012 86            	pop	cc
 473  0013 3b0002        	push	c_x+2
 474  0016 be00          	ldw	x,c_x
 475  0018 89            	pushw	x
 476  0019 3b0002        	push	c_y+2
 477  001c be00          	ldw	x,c_y
 478  001e 89            	pushw	x
 481                     ; 311 	state |= STATE_TMR_TICK;
 483  001f 72140000      	bset	_state,#2
 484                     ; 312 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 486  0023 ae0001        	ldw	x,#1
 487  0026 cd0000        	call	_TIM2_ClearFlag
 489                     ; 313 }
 492  0029 85            	popw	x
 493  002a bf00          	ldw	c_y,x
 494  002c 320002        	pop	c_y+2
 495  002f 85            	popw	x
 496  0030 bf00          	ldw	c_x,x
 497  0032 320002        	pop	c_x+2
 498  0035 80            	iret
 521                     ; 321  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 521                     ; 322 {
 522                     	switch	.text
 523  0036               f_TIM2_CAP_COM_IRQHandler:
 527                     ; 326 }
 530  0036 80            	iret
 553                     ; 366  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 553                     ; 367 {
 554                     	switch	.text
 555  0037               f_UART1_TX_IRQHandler:
 559                     ; 371 }
 562  0037 80            	iret
 585                     ; 379  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 585                     ; 380 {
 586                     	switch	.text
 587  0038               f_UART1_RX_IRQHandler:
 591                     ; 384 }
 594  0038 80            	iret
 623                     ; 393 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 623                     ; 394 {
 624                     	switch	.text
 625  0039               f_I2C_IRQHandler:
 627  0039 8a            	push	cc
 628  003a 84            	pop	a
 629  003b a4bf          	and	a,#191
 630  003d 88            	push	a
 631  003e 86            	pop	cc
 632  003f 3b0002        	push	c_x+2
 633  0042 be00          	ldw	x,c_x
 634  0044 89            	pushw	x
 635  0045 3b0002        	push	c_y+2
 636  0048 be00          	ldw	x,c_y
 637  004a 89            	pushw	x
 640                     ; 396   if ((I2C->SR2) != 0)
 642  004b 725d5218      	tnz	21016
 643  004f 2704          	jreq	L542
 644                     ; 399     I2C->SR2 = 0;
 646  0051 725f5218      	clr	21016
 647  0055               L542:
 648                     ; 406   Event = I2C_GetLastEvent();
 650  0055 cd0000        	call	_I2C_GetLastEvent
 652  0058 bf02          	ldw	_Event,x
 653                     ; 407   switch (Event)
 655  005a be02          	ldw	x,_Event
 657                     ; 436     default:
 657                     ; 437       break;
 658  005c 1d0010        	subw	x,#16
 659  005f 2735          	jreq	L132
 660  0061 1d0230        	subw	x,#560
 661  0064 271f          	jreq	L722
 662  0066 1d0440        	subw	x,#1088
 663  0069 2709          	jreq	L322
 664  006b 1d0002        	subw	x,#2
 665  006e 262a          	jrne	L152
 666                     ; 411     case I2C_EVENT_SLAVE_TRANSMITTER_ADDRESS_MATCHED:
 666                     ; 412       Tx_Idx = 0;
 668  0070 3f00          	clr	_Tx_Idx
 669                     ; 413       break;
 671  0072 2026          	jra	L152
 672  0074               L322:
 673                     ; 416     case I2C_EVENT_SLAVE_BYTE_TRANSMITTING:
 673                     ; 417       /* Transmit data */
 673                     ; 418       I2C_SendData(Slave_Buffer_Rx[Tx_Idx++]);
 675  0074 b600          	ld	a,_Tx_Idx
 676  0076 97            	ld	xl,a
 677  0077 3c00          	inc	_Tx_Idx
 678  0079 9f            	ld	a,xl
 679  007a 5f            	clrw	x
 680  007b 97            	ld	xl,a
 681  007c e600          	ld	a,(_Slave_Buffer_Rx,x)
 682  007e cd0000        	call	_I2C_SendData
 684                     ; 419       break;
 686  0081 2017          	jra	L152
 687  0083               L522:
 688                     ; 422     case I2C_EVENT_SLAVE_RECEIVER_ADDRESS_MATCHED:
 688                     ; 423       break;
 690  0083 2015          	jra	L152
 691  0085               L722:
 692                     ; 426     case I2C_EVENT_SLAVE_BYTE_RECEIVED:
 692                     ; 427       Slave_Buffer_Rx[Rx_Idx++] = I2C_ReceiveData();
 694  0085 b601          	ld	a,_Rx_Idx
 695  0087 97            	ld	xl,a
 696  0088 3c01          	inc	_Rx_Idx
 697  008a 9f            	ld	a,xl
 698  008b 5f            	clrw	x
 699  008c 97            	ld	xl,a
 700  008d 89            	pushw	x
 701  008e cd0000        	call	_I2C_ReceiveData
 703  0091 85            	popw	x
 704  0092 e700          	ld	(_Slave_Buffer_Rx,x),a
 705                     ; 428       break;
 707  0094 2004          	jra	L152
 708  0096               L132:
 709                     ; 431     case (I2C_EVENT_SLAVE_STOP_DETECTED):
 709                     ; 432             /* write to CR2 to clear STOPF flag */
 709                     ; 433             I2C->CR2 |= I2C_CR2_ACK;
 711  0096 72145211      	bset	21009,#2
 712                     ; 434       break;
 714  009a               L332:
 715                     ; 436     default:
 715                     ; 437       break;
 717  009a               L152:
 718                     ; 440 }
 721  009a 85            	popw	x
 722  009b bf00          	ldw	c_y,x
 723  009d 320002        	pop	c_y+2
 724  00a0 85            	popw	x
 725  00a1 bf00          	ldw	c_x,x
 726  00a3 320002        	pop	c_x+2
 727  00a6 80            	iret
 751                     ; 517  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 751                     ; 518 {
 752                     	switch	.text
 753  00a7               f_ADC1_IRQHandler:
 755  00a7 8a            	push	cc
 756  00a8 84            	pop	a
 757  00a9 a4bf          	and	a,#191
 758  00ab 88            	push	a
 759  00ac 86            	pop	cc
 760  00ad 3b0002        	push	c_x+2
 761  00b0 be00          	ldw	x,c_x
 762  00b2 89            	pushw	x
 763  00b3 3b0002        	push	c_y+2
 764  00b6 be00          	ldw	x,c_y
 765  00b8 89            	pushw	x
 768                     ; 523 	state |= STATE_ADC_READY;
 770  00b9 72100000      	bset	_state,#0
 771                     ; 524 	ADC1_ClearFlag(ADC1_FLAG_EOC);
 773  00bd a680          	ld	a,#128
 774  00bf cd0000        	call	_ADC1_ClearFlag
 776                     ; 525 }
 779  00c2 85            	popw	x
 780  00c3 bf00          	ldw	c_y,x
 781  00c5 320002        	pop	c_y+2
 782  00c8 85            	popw	x
 783  00c9 bf00          	ldw	c_x,x
 784  00cb 320002        	pop	c_x+2
 785  00ce 80            	iret
 808                     ; 548  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 808                     ; 549 {
 809                     	switch	.text
 810  00cf               f_TIM4_UPD_OVF_IRQHandler:
 814                     ; 553 }
 817  00cf 80            	iret
 840                     ; 562 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 840                     ; 563 {
 841                     	switch	.text
 842  00d0               f_EEPROM_EEC_IRQHandler:
 846                     ; 567 }
 849  00d0 80            	iret
 900                     	xdef	_Event
 901                     	xdef	_Rx_Idx
 902                     	xdef	_Tx_Idx
 903                     	switch	.ubsct
 904  0000               _Slave_Buffer_Rx:
 905  0000 000000000000  	ds.b	8
 906                     	xdef	_Slave_Buffer_Rx
 907                     	xref.b	_state
 908                     	xdef	f_EEPROM_EEC_IRQHandler
 909                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 910                     	xdef	f_ADC1_IRQHandler
 911                     	xdef	f_I2C_IRQHandler
 912                     	xdef	f_UART1_RX_IRQHandler
 913                     	xdef	f_UART1_TX_IRQHandler
 914                     	xdef	f_TIM2_CAP_COM_IRQHandler
 915                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 916                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 917                     	xdef	f_TIM1_CAP_COM_IRQHandler
 918                     	xdef	f_SPI_IRQHandler
 919                     	xdef	f_EXTI_PORTE_IRQHandler
 920                     	xdef	f_EXTI_PORTD_IRQHandler
 921                     	xdef	f_EXTI_PORTC_IRQHandler
 922                     	xdef	f_EXTI_PORTB_IRQHandler
 923                     	xdef	f_EXTI_PORTA_IRQHandler
 924                     	xdef	f_CLK_IRQHandler
 925                     	xdef	f_AWU_IRQHandler
 926                     	xdef	f_TLI_IRQHandler
 927                     	xdef	f_TRAP_IRQHandler
 928                     	xdef	f_NonHandledInterrupt
 929                     	xref	_TIM2_ClearFlag
 930                     	xref	_I2C_GetLastEvent
 931                     	xref	_I2C_SendData
 932                     	xref	_I2C_ReceiveData
 933                     	xref	_ADC1_ClearFlag
 934                     	xref.b	c_x
 935                     	xref.b	c_y
 955                     	end
