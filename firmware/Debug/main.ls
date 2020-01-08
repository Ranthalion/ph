   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  15                     	bsct
  16  0000               _state:
  17  0000 00            	dc.b	0
  18  0001               _phRaw:
  19  0001 0457          	dc.w	1111
  20  0003               _idxBuffer:
  21  0003 00            	dc.b	0
  22                     .bit:	section	.data,bit
  23  0000               _bufferEmpty:
  24  0000 01            	dc.b	1
  25                     	bsct
  26  0004               _averagedValue:
  27  0004 00000000      	dc.l	0
  68                     ; 29 main()
  68                     ; 30 {
  70                     	switch	.text
  71  0000               _main:
  75                     ; 32 	CLK->CKDIVR = 0;
  77  0000 725f50c6      	clr	20678
  78                     ; 33 	GPIOD->ODR = 0x08;
  80  0004 3508500f      	mov	20495,#8
  81                     ; 36 	GPIOD->CR1 |= 0x38;	//Pull ups on 4 and 5, push-pull on 3
  83  0008 c65012        	ld	a,20498
  84  000b aa38          	or	a,#56
  85  000d c75012        	ld	20498,a
  86                     ; 37 	GPIOD->DDR = 0x08;  //All pins inputs, except PD3
  88  0010 35085011      	mov	20497,#8
  89                     ; 39 	InitI2C();
  91  0014 ad52          	call	_InitI2C
  93                     ; 42 	CLK->PCKENR1 = 0x21;  //TIM2 and I2C
  95  0016 352150c7      	mov	20679,#33
  96                     ; 43 	CLK->PCKENR2 = 0x08;  //ADC
  98  001a 350850ca      	mov	20682,#8
  99                     ; 46   enableInterrupts();
 102  001e 9a            rim
 104                     ; 48 	GPIOD->ODR = 0x08;
 107  001f 3508500f      	mov	20495,#8
 108                     ; 50 	init();
 110  0023 cd00ac        	call	_init
 112                     ; 53 	SetLED(LED_OFF, 0);
 114  0026 4b00          	push	#0
 115  0028 5f            	clrw	x
 116  0029 cd0000        	call	_SetLED
 118  002c 84            	pop	a
 119                     ; 55 	startPoint = &i2cBuffer1[1];
 121  002d ae0085        	ldw	x,#_i2cBuffer1+1
 122  0030 bf82          	ldw	_startPoint,x
 123                     ; 56 	currentPoint = startPoint;
 125  0032 ae0085        	ldw	x,#_i2cBuffer1+1
 126  0035 bf80          	ldw	_currentPoint,x
 127                     ; 57 	I2C->SR2 &= ~I2C_SR2_AF;
 129  0037 72155218      	bres	21016,#2
 130                     ; 58 	wfi(); //wait for interrupts
 133  003b 8f            wfi
 136  003c 2022          	jra	L72
 137  003e               L52:
 138                     ; 64 			if (state & STATE_ADC_READY)
 140  003e b600          	ld	a,_state
 141  0040 a501          	bcp	a,#1
 142  0042 2703          	jreq	L33
 143                     ; 66 				HandleADC();				
 145  0044 cd010c        	call	_HandleADC
 147  0047               L33:
 148                     ; 70 			if (state & STATE_I2C_RESET)
 150  0047 b600          	ld	a,_state
 151  0049 a502          	bcp	a,#2
 152  004b 2706          	jreq	L53
 153                     ; 72 				state &= ~(STATE_I2C_RESET);
 155  004d 72130000      	bres	_state,#1
 156                     ; 73 				InitI2C();				
 158  0051 ad15          	call	_InitI2C
 160  0053               L53:
 161                     ; 77 			if (state & STATE_TMR_TICK)
 163  0053 b600          	ld	a,_state
 164  0055 a504          	bcp	a,#4
 165  0057 2707          	jreq	L72
 166                     ; 79 				LEDTick();
 168  0059 cd0000        	call	_LEDTick
 170                     ; 80 				state &= ~(STATE_TMR_TICK);
 172  005c 72150000      	bres	_state,#2
 173  0060               L72:
 174                     ; 61 		while (state > 0)
 176  0060 3d00          	tnz	_state
 177  0062 26da          	jrne	L52
 178                     ; 84 		wfi();
 181  0064 8f            wfi
 185  0065 20f9          	jra	L72
 220                     ; 88 void assert_failed(u8* file, u32 line)
 220                     ; 89 {
 221                     	switch	.text
 222  0067               _assert_failed:
 226                     ; 91 }
 229  0067 81            	ret
 272                     ; 93 void InitI2C()
 272                     ; 94 {
 273                     	switch	.text
 274  0068               _InitI2C:
 276  0068 89            	pushw	x
 277       00000002      OFST:	set	2
 280                     ; 95 	uint8_t address = 0x42;
 282  0069 a642          	ld	a,#66
 283  006b 6b01          	ld	(OFST-1,sp),a
 285                     ; 96 	uint8_t addressOffset = 0;
 287                     ; 100 	GPIOB->CR1 |= 0x00;
 289  006d c65008        	ld	a,20488
 290                     ; 101 	GPIOB->DDR &= ~0x30;
 292  0070 c65007        	ld	a,20487
 293  0073 a4cf          	and	a,#207
 294  0075 c75007        	ld	20487,a
 295                     ; 102 	GPIOB->CR2 &= ~0x30;
 297  0078 c65009        	ld	a,20489
 298  007b a4cf          	and	a,#207
 299  007d c75009        	ld	20489,a
 300                     ; 105 	addressOffset = (GPIOD->IDR & 0x30) >> 4;
 302  0080 c65010        	ld	a,20496
 303  0083 4e            	swap	a
 304  0084 a40f          	and	a,#15
 305  0086 a403          	and	a,#3
 306  0088 6b02          	ld	(OFST+0,sp),a
 308                     ; 106 	address += addressOffset;
 310  008a 7b01          	ld	a,(OFST-1,sp)
 311  008c 1b02          	add	a,(OFST+0,sp)
 312  008e 6b01          	ld	(OFST-1,sp),a
 314                     ; 109 	I2C->CR1 |= 0x01;  						//Enable I2C peripheral
 316  0090 72105210      	bset	21008,#0
 317                     ; 110 	I2C->CR2 = 0x04;	 						//Enable I2C acknowledgement
 319  0094 35045211      	mov	21009,#4
 320                     ; 111 	I2C->FREQR = 16; 	 						// Set I2C Freq value (16MHz)
 322  0098 35105212      	mov	21010,#16
 323                     ; 112 	I2C->OARL = (address << 1) ;	// set address
 325  009c 7b01          	ld	a,(OFST-1,sp)
 326  009e 48            	sll	a
 327  009f c75213        	ld	21011,a
 328                     ; 113 	I2C->OARH = 0x40;							// Set 7bit address mode
 330  00a2 35405214      	mov	21012,#64
 331                     ; 114 	I2C->ITR	= 0x07;							// all I2C interrupt enable
 333  00a6 3507521a      	mov	21018,#7
 334                     ; 115 }
 337  00aa 85            	popw	x
 338  00ab 81            	ret
 364                     ; 117 void init()
 364                     ; 118 {
 365                     	switch	.text
 366  00ac               _init:
 370                     ; 123 	ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF, ITC_PRIORITYLEVEL_2);
 372  00ac ae0d00        	ldw	x,#3328
 373  00af cd0000        	call	_ITC_SetSoftwarePriority
 375                     ; 124 	ITC_SetSoftwarePriority(ITC_IRQ_ADC1, ITC_PRIORITYLEVEL_2);
 377  00b2 ae1600        	ldw	x,#5632
 378  00b5 cd0000        	call	_ITC_SetSoftwarePriority
 380                     ; 126 	ADC_setup();
 382  00b8 ad03          	call	_ADC_setup
 384                     ; 127 	TIM2_setup();
 386  00ba ad37          	call	_TIM2_setup
 388                     ; 128 }
 391  00bc 81            	ret
 420                     ; 130 void ADC_setup()
 420                     ; 131 {
 421                     	switch	.text
 422  00bd               _ADC_setup:
 426                     ; 132 	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
 428  00bd 4b00          	push	#0
 429  00bf 4b40          	push	#64
 430  00c1 ae500f        	ldw	x,#20495
 431  00c4 cd0000        	call	_GPIO_Init
 433  00c7 85            	popw	x
 434                     ; 133 	ADC1_DeInit();
 436  00c8 cd0000        	call	_ADC1_DeInit
 438                     ; 135 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 438                     ; 136              ADC1_CHANNEL_6,
 438                     ; 137              ADC1_PRESSEL_FCPU_D12, 
 438                     ; 138              ADC1_EXTTRIG_GPIO, 
 438                     ; 139              DISABLE, 
 438                     ; 140              ADC1_ALIGN_RIGHT, 
 438                     ; 141              ADC1_SCHMITTTRIG_CHANNEL6, 
 438                     ; 142              DISABLE);
 440  00cb 4b00          	push	#0
 441  00cd 4b06          	push	#6
 442  00cf 4b08          	push	#8
 443  00d1 4b00          	push	#0
 444  00d3 4b10          	push	#16
 445  00d5 4b60          	push	#96
 446  00d7 ae0106        	ldw	x,#262
 447  00da cd0000        	call	_ADC1_Init
 449  00dd 5b06          	addw	sp,#6
 450                     ; 143 	ADC1_DataBufferCmd(ENABLE);
 452  00df a601          	ld	a,#1
 453  00e1 cd0000        	call	_ADC1_DataBufferCmd
 455                     ; 144 	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
 457  00e4 4b01          	push	#1
 458  00e6 ae0020        	ldw	x,#32
 459  00e9 cd0000        	call	_ADC1_ITConfig
 461  00ec 84            	pop	a
 462                     ; 145 	ADC1_Cmd(ENABLE);
 464  00ed a601          	ld	a,#1
 465  00ef cd0000        	call	_ADC1_Cmd
 467                     ; 146 }
 470  00f2 81            	ret
 497                     ; 148 void TIM2_setup(void)
 497                     ; 149 {
 498                     	switch	.text
 499  00f3               _TIM2_setup:
 503                     ; 150     TIM2_DeInit();
 505  00f3 cd0000        	call	_TIM2_DeInit
 507                     ; 151     TIM2_TimeBaseInit(TIM2_PRESCALER_32, 32000);
 509  00f6 ae7d00        	ldw	x,#32000
 510  00f9 89            	pushw	x
 511  00fa a605          	ld	a,#5
 512  00fc cd0000        	call	_TIM2_TimeBaseInit
 514  00ff 85            	popw	x
 515                     ; 152 		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 517  0100 ae0101        	ldw	x,#257
 518  0103 cd0000        	call	_TIM2_ITConfig
 520                     ; 153     TIM2_Cmd(ENABLE);
 522  0106 a601          	ld	a,#1
 523  0108 cd0000        	call	_TIM2_Cmd
 525                     ; 154 }
 528  010b 81            	ret
 570                     ; 156 void HandleADC()
 570                     ; 157 {
 571                     	switch	.text
 572  010c               _HandleADC:
 574  010c 88            	push	a
 575       00000001      OFST:	set	1
 578                     ; 158 	uint8_t x = 0;
 580                     ; 161 	adcValues[idxBuffer] = 0;
 582  010d b603          	ld	a,_idxBuffer
 583  010f 5f            	clrw	x
 584  0110 97            	ld	xl,a
 585  0111 58            	sllw	x
 586  0112 905f          	clrw	y
 587  0114 ef00          	ldw	(_adcValues,x),y
 588                     ; 162 	for(x = 0; x < 8; x++)
 590  0116 0f01          	clr	(OFST+0,sp)
 592  0118               L741:
 593                     ; 164 		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 3);
 595  0118 7b01          	ld	a,(OFST+0,sp)
 596  011a cd0000        	call	_ADC1_GetBufferValue
 598  011d 58            	sllw	x
 599  011e 58            	sllw	x
 600  011f 58            	sllw	x
 601  0120 b603          	ld	a,_idxBuffer
 602  0122 905f          	clrw	y
 603  0124 9097          	ld	yl,a
 604  0126 9058          	sllw	y
 605  0128 01            	rrwa	x,a
 606  0129 90eb01        	add	a,(_adcValues+1,y)
 607  012c 01            	rrwa	x,a
 608  012d 90e900        	adc	a,(_adcValues,y)
 609  0130 01            	rrwa	x,a
 610  0131 90ef00        	ldw	(_adcValues,y),x
 611                     ; 162 	for(x = 0; x < 8; x++)
 613  0134 0c01          	inc	(OFST+0,sp)
 617  0136 7b01          	ld	a,(OFST+0,sp)
 618  0138 a108          	cp	a,#8
 619  013a 25dc          	jrult	L741
 620                     ; 169 	if(bufferEmpty)
 622                     	btst	_bufferEmpty
 623  0141 241a          	jruge	L551
 624                     ; 171 		bufferEmpty = false;
 626  0143 72110000      	bres	_bufferEmpty
 627                     ; 172 		for(x = 1; x < BUFFER_SIZE; x++)
 629  0147 a601          	ld	a,#1
 630  0149 6b01          	ld	(OFST+0,sp),a
 632  014b               L751:
 633                     ; 174 			adcValues[x] = adcValues[0];
 635  014b 7b01          	ld	a,(OFST+0,sp)
 636  014d 5f            	clrw	x
 637  014e 97            	ld	xl,a
 638  014f 58            	sllw	x
 639  0150 90be00        	ldw	y,_adcValues
 640  0153 ef00          	ldw	(_adcValues,x),y
 641                     ; 172 		for(x = 1; x < BUFFER_SIZE; x++)
 643  0155 0c01          	inc	(OFST+0,sp)
 647  0157 7b01          	ld	a,(OFST+0,sp)
 648  0159 a140          	cp	a,#64
 649  015b 25ee          	jrult	L751
 650  015d               L551:
 651                     ; 179 	averagedValue = 0;
 653  015d ae0000        	ldw	x,#0
 654  0160 bf06          	ldw	_averagedValue+2,x
 655  0162 ae0000        	ldw	x,#0
 656  0165 bf04          	ldw	_averagedValue,x
 657                     ; 180 	for(x = 0; x < BUFFER_SIZE; x++)
 659  0167 0f01          	clr	(OFST+0,sp)
 661  0169               L561:
 662                     ; 182 		averagedValue += adcValues[x];
 664  0169 7b01          	ld	a,(OFST+0,sp)
 665  016b 5f            	clrw	x
 666  016c 97            	ld	xl,a
 667  016d 58            	sllw	x
 668  016e ee00          	ldw	x,(_adcValues,x)
 669  0170 cd0000        	call	c_uitolx
 671  0173 ae0004        	ldw	x,#_averagedValue
 672  0176 cd0000        	call	c_lgadd
 674                     ; 180 	for(x = 0; x < BUFFER_SIZE; x++)
 676  0179 0c01          	inc	(OFST+0,sp)
 680  017b 7b01          	ld	a,(OFST+0,sp)
 681  017d a140          	cp	a,#64
 682  017f 25e8          	jrult	L561
 683                     ; 184 	averagedValue = averagedValue / (BUFFER_SIZE * 8);
 685  0181 ae0004        	ldw	x,#_averagedValue
 686  0184 a609          	ld	a,#9
 687  0186 cd0000        	call	c_lgursh
 689                     ; 185 	phRaw = averagedValue;
 691  0189 be06          	ldw	x,_averagedValue+2
 692  018b bf01          	ldw	_phRaw,x
 693                     ; 186 	i2cBuffer1[0] = phRaw >> 8;
 695  018d 450184        	mov	_i2cBuffer1,_phRaw
 696                     ; 187 	i2cBuffer1[1] = phRaw;
 698  0190 450285        	mov	_i2cBuffer1+1,_phRaw+1
 699                     ; 189 	idxBuffer++;
 701  0193 3c03          	inc	_idxBuffer
 702                     ; 190 	if (idxBuffer >= BUFFER_SIZE)
 704  0195 b603          	ld	a,_idxBuffer
 705  0197 a140          	cp	a,#64
 706  0199 2502          	jrult	L371
 707                     ; 192 		idxBuffer = 0;
 709  019b 3f03          	clr	_idxBuffer
 710  019d               L371:
 711                     ; 195 	state &= ~(STATE_ADC_READY);
 713  019d 72110000      	bres	_state,#0
 714                     ; 196 }
 717  01a1 84            	pop	a
 718  01a2 81            	ret
 819                     	xdef	_main
 820                     	xdef	_averagedValue
 821                     	xdef	_bufferEmpty
 822                     	xdef	_idxBuffer
 823                     	switch	.ubsct
 824  0000               _adcValues:
 825  0000 000000000000  	ds.b	128
 826                     	xdef	_adcValues
 827                     	xdef	_InitI2C
 828                     	xdef	_HandleADC
 829                     	xdef	_TIM2_setup
 830                     	xdef	_ADC_setup
 831                     	xdef	_init
 832                     	xref	_ITC_SetSoftwarePriority
 833                     	xref	_LEDTick
 834                     	xref	_SetLED
 835  0080               _currentPoint:
 836  0080 0000          	ds.b	2
 837                     	xdef	_currentPoint
 838  0082               _startPoint:
 839  0082 0000          	ds.b	2
 840                     	xdef	_startPoint
 841  0084               _i2cBuffer1:
 842  0084 000000        	ds.b	3
 843                     	xdef	_i2cBuffer1
 844                     	xdef	_phRaw
 845                     	xdef	_state
 846                     	xdef	_assert_failed
 847                     	xref	_TIM2_ITConfig
 848                     	xref	_TIM2_Cmd
 849                     	xref	_TIM2_TimeBaseInit
 850                     	xref	_TIM2_DeInit
 851                     	xref	_GPIO_Init
 852                     	xref	_ADC1_GetBufferValue
 853                     	xref	_ADC1_ITConfig
 854                     	xref	_ADC1_DataBufferCmd
 855                     	xref	_ADC1_Cmd
 856                     	xref	_ADC1_Init
 857                     	xref	_ADC1_DeInit
 877                     	xref	c_lgursh
 878                     	xref	c_lgadd
 879                     	xref	c_uitolx
 880                     	end
