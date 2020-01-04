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
  63                     ; 37 main()
  63                     ; 38 {
  65                     	switch	.text
  66  0000               _main:
  70                     ; 39 	init();
  72  0000 ad33          	call	_init
  74                     ; 40 	i2cBuffer1[0] = 0x03;
  76  0002 35030080      	mov	_i2cBuffer1,#3
  77                     ; 41 	i2cBuffer1[1] = 0x49;
  79  0006 35490081      	mov	_i2cBuffer1+1,#73
  80                     ; 42 	i2cBuffer1[2] = 0x00;
  82  000a 3f82          	clr	_i2cBuffer1+2
  83                     ; 45 	GPIOD->ODR = 0b00011000;
  85  000c 3518500f      	mov	20495,#24
  86                     ; 46 	wfi(); //wait for interrupts
  89  0010 8f            wfi
  92  0011 201a          	jra	L72
  93  0013               L52:
  94                     ; 52 			if (state & STATE_ADC_READY)
  96  0013 b600          	ld	a,_state
  97  0015 a501          	bcp	a,#1
  98  0017 2703          	jreq	L33
  99                     ; 54 				HandleADC();				
 101  0019 cd015e        	call	_HandleADC
 103  001c               L33:
 104                     ; 58 			if (state & STATE_I2C_READY  && 1 == 0)
 106  001c b600          	ld	a,_state
 107  001e a502          	bcp	a,#2
 109                     ; 64 			if (state & STATE_TMR_TICK)
 112  0020 b600          	ld	a,_state
 113  0022 a504          	bcp	a,#4
 114  0024 2707          	jreq	L72
 115                     ; 66 				LEDTick();
 117  0026 cd0000        	call	_LEDTick
 119                     ; 67 				state &= ~(STATE_TMR_TICK);
 121  0029 72150000      	bres	_state,#2
 122  002d               L72:
 123                     ; 49 		while (state > 0)
 125  002d 3d00          	tnz	_state
 126  002f 26e2          	jrne	L52
 127                     ; 71 		wfi();
 130  0031 8f            wfi
 134  0032 20f9          	jra	L72
 169                     ; 75 void assert_failed(u8* file, u32 line)
 169                     ; 76 {
 170                     	switch	.text
 171  0034               _assert_failed:
 175                     ; 78 }
 178  0034 81            	ret
 207                     ; 80 void init()
 207                     ; 81 {
 208                     	switch	.text
 209  0035               _init:
 213                     ; 82   clock_setup();
 215  0035 ad19          	call	_clock_setup
 217                     ; 83   GPIO_setup();
 219  0037 ad7a          	call	_GPIO_setup
 221                     ; 84 	ADC_setup();
 223  0039 cd00e6        	call	_ADC_setup
 225                     ; 86 	I2C_setup(0x45);
 227  003c ae0045        	ldw	x,#69
 228  003f cd0111        	call	_I2C_setup
 230                     ; 88 	ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF, ITC_PRIORITYLEVEL_2);
 232  0042 ae0d00        	ldw	x,#3328
 233  0045 cd0000        	call	_ITC_SetSoftwarePriority
 235                     ; 89 	ITC_SetSoftwarePriority(ITC_IRQ_ADC1, ITC_PRIORITYLEVEL_2);
 237  0048 ae1600        	ldw	x,#5632
 238  004b cd0000        	call	_ITC_SetSoftwarePriority
 240                     ; 92   enableInterrupts();
 243  004e 9a            rim
 245                     ; 93 }
 249  004f 81            	ret
 282                     ; 95 void clock_setup(void)
 282                     ; 96 {
 283                     	switch	.text
 284  0050               _clock_setup:
 288                     ; 97   CLK_DeInit();
 290  0050 cd0000        	call	_CLK_DeInit
 292                     ; 99   CLK_HSECmd(DISABLE);
 294  0053 4f            	clr	a
 295  0054 cd0000        	call	_CLK_HSECmd
 297                     ; 100   CLK_LSICmd(DISABLE);
 299  0057 4f            	clr	a
 300  0058 cd0000        	call	_CLK_LSICmd
 302                     ; 101   CLK_HSICmd(ENABLE);
 304  005b a601          	ld	a,#1
 305  005d cd0000        	call	_CLK_HSICmd
 308  0060               L101:
 309                     ; 102   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 311  0060 ae0102        	ldw	x,#258
 312  0063 cd0000        	call	_CLK_GetFlagStatus
 314  0066 4d            	tnz	a
 315  0067 27f7          	jreq	L101
 316                     ; 104   CLK_ClockSwitchCmd(ENABLE);
 318  0069 a601          	ld	a,#1
 319  006b cd0000        	call	_CLK_ClockSwitchCmd
 321                     ; 105   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 323  006e 4f            	clr	a
 324  006f cd0000        	call	_CLK_HSIPrescalerConfig
 326                     ; 106   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 328  0072 a680          	ld	a,#128
 329  0074 cd0000        	call	_CLK_SYSCLKConfig
 331                     ; 108   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 331                     ; 109 		DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 333  0077 4b01          	push	#1
 334  0079 4b00          	push	#0
 335  007b ae01e1        	ldw	x,#481
 336  007e cd0000        	call	_CLK_ClockSwitchConfig
 338  0081 85            	popw	x
 339                     ; 111   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
 341  0082 ae0001        	ldw	x,#1
 342  0085 cd0000        	call	_CLK_PeripheralClockConfig
 344                     ; 112   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 346  0088 ae0100        	ldw	x,#256
 347  008b cd0000        	call	_CLK_PeripheralClockConfig
 349                     ; 113   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 351  008e ae0300        	ldw	x,#768
 352  0091 cd0000        	call	_CLK_PeripheralClockConfig
 354                     ; 114   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 356  0094 ae1200        	ldw	x,#4608
 357  0097 cd0000        	call	_CLK_PeripheralClockConfig
 359                     ; 115   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 361  009a ae1301        	ldw	x,#4865
 362  009d cd0000        	call	_CLK_PeripheralClockConfig
 364                     ; 116   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 366  00a0 ae0700        	ldw	x,#1792
 367  00a3 cd0000        	call	_CLK_PeripheralClockConfig
 369                     ; 117   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 371  00a6 ae0501        	ldw	x,#1281
 372  00a9 cd0000        	call	_CLK_PeripheralClockConfig
 374                     ; 118   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 376  00ac ae0400        	ldw	x,#1024
 377  00af cd0000        	call	_CLK_PeripheralClockConfig
 379                     ; 119 }
 382  00b2 81            	ret
 407                     ; 121 void GPIO_setup()
 407                     ; 122 {
 408                     	switch	.text
 409  00b3               _GPIO_setup:
 413                     ; 124   GPIO_DeInit(LED_port);
 415  00b3 ae500f        	ldw	x,#20495
 416  00b6 cd0000        	call	_GPIO_DeInit
 418                     ; 125   GPIO_Init(LED_port, (LED_pin | GPIO_PIN_5), GPIO_MODE_OUT_PP_LOW_FAST);
 420  00b9 4be0          	push	#224
 421  00bb 4b28          	push	#40
 422  00bd ae500f        	ldw	x,#20495
 423  00c0 cd0000        	call	_GPIO_Init
 425  00c3 85            	popw	x
 426                     ; 133 	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
 428  00c4 4b00          	push	#0
 429  00c6 4b40          	push	#64
 430  00c8 ae500f        	ldw	x,#20495
 431  00cb cd0000        	call	_GPIO_Init
 433  00ce 85            	popw	x
 434                     ; 136 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
 436  00cf 4bb0          	push	#176
 437  00d1 4b10          	push	#16
 438  00d3 ae5005        	ldw	x,#20485
 439  00d6 cd0000        	call	_GPIO_Init
 441  00d9 85            	popw	x
 442                     ; 137 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
 444  00da 4bb0          	push	#176
 445  00dc 4b20          	push	#32
 446  00de ae5005        	ldw	x,#20485
 447  00e1 cd0000        	call	_GPIO_Init
 449  00e4 85            	popw	x
 450                     ; 139 }
 453  00e5 81            	ret
 481                     ; 141 void ADC_setup()
 481                     ; 142 {
 482                     	switch	.text
 483  00e6               _ADC_setup:
 487                     ; 143 	ADC1_DeInit();
 489  00e6 cd0000        	call	_ADC1_DeInit
 491                     ; 145 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 491                     ; 146              ADC1_CHANNEL_6,
 491                     ; 147              ADC1_PRESSEL_FCPU_D12, 
 491                     ; 148              ADC1_EXTTRIG_GPIO, 
 491                     ; 149              DISABLE, 
 491                     ; 150              ADC1_ALIGN_RIGHT, 
 491                     ; 151              ADC1_SCHMITTTRIG_CHANNEL6, 
 491                     ; 152              DISABLE);
 493  00e9 4b00          	push	#0
 494  00eb 4b06          	push	#6
 495  00ed 4b08          	push	#8
 496  00ef 4b00          	push	#0
 497  00f1 4b10          	push	#16
 498  00f3 4b60          	push	#96
 499  00f5 ae0106        	ldw	x,#262
 500  00f8 cd0000        	call	_ADC1_Init
 502  00fb 5b06          	addw	sp,#6
 503                     ; 153 	ADC1_DataBufferCmd(ENABLE);
 505  00fd a601          	ld	a,#1
 506  00ff cd0000        	call	_ADC1_DataBufferCmd
 508                     ; 154 	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
 510  0102 4b01          	push	#1
 511  0104 ae0020        	ldw	x,#32
 512  0107 cd0000        	call	_ADC1_ITConfig
 514  010a 84            	pop	a
 515                     ; 155 	ADC1_Cmd(ENABLE);
 517  010b a601          	ld	a,#1
 518  010d cd0000        	call	_ADC1_Cmd
 520                     ; 156 }
 523  0110 81            	ret
 562                     .const:	section	.text
 563  0000               L22:
 564  0000 000f4240      	dc.l	1000000
 565                     ; 158 void I2C_setup(uint16_t address)
 565                     ; 159 {
 566                     	switch	.text
 567  0111               _I2C_setup:
 569  0111 89            	pushw	x
 570       00000000      OFST:	set	0
 573                     ; 160 	I2C_DeInit();
 575  0112 cd0000        	call	_I2C_DeInit
 577                     ; 161 	I2C_Init(100000, 
 577                     ; 162 					 address << 1, 
 577                     ; 163 					 I2C_DUTYCYCLE_2, 
 577                     ; 164 					 I2C_ACK_CURR, 
 577                     ; 165 					 I2C_ADDMODE_7BIT, 
 577                     ; 166 					 (CLK_GetClockFreq() / 1000000));
 579  0115 cd0000        	call	_CLK_GetClockFreq
 581  0118 ae0000        	ldw	x,#L22
 582  011b cd0000        	call	c_ludv
 584  011e b603          	ld	a,c_lreg+3
 585  0120 88            	push	a
 586  0121 4b00          	push	#0
 587  0123 4b01          	push	#1
 588  0125 4b00          	push	#0
 589  0127 1e05          	ldw	x,(OFST+5,sp)
 590  0129 58            	sllw	x
 591  012a 89            	pushw	x
 592  012b ae86a0        	ldw	x,#34464
 593  012e 89            	pushw	x
 594  012f ae0001        	ldw	x,#1
 595  0132 89            	pushw	x
 596  0133 cd0000        	call	_I2C_Init
 598  0136 5b0a          	addw	sp,#10
 599                     ; 170   I2C_ITConfig((I2C_IT_TypeDef)(I2C_IT_ERR | I2C_IT_EVT | I2C_IT_BUF), ENABLE);
 601  0138 ae0701        	ldw	x,#1793
 602  013b cd0000        	call	_I2C_ITConfig
 604                     ; 172 	I2C_Cmd(ENABLE);
 606  013e a601          	ld	a,#1
 607  0140 cd0000        	call	_I2C_Cmd
 609                     ; 173 }
 612  0143 85            	popw	x
 613  0144 81            	ret
 640                     ; 175 void TIM2_setup(void)
 640                     ; 176 {
 641                     	switch	.text
 642  0145               _TIM2_setup:
 646                     ; 177     TIM2_DeInit();
 648  0145 cd0000        	call	_TIM2_DeInit
 650                     ; 178     TIM2_TimeBaseInit(TIM2_PRESCALER_32, 32000);
 652  0148 ae7d00        	ldw	x,#32000
 653  014b 89            	pushw	x
 654  014c a605          	ld	a,#5
 655  014e cd0000        	call	_TIM2_TimeBaseInit
 657  0151 85            	popw	x
 658                     ; 179 		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 660  0152 ae0101        	ldw	x,#257
 661  0155 cd0000        	call	_TIM2_ITConfig
 663                     ; 180     TIM2_Cmd(ENABLE);
 665  0158 a601          	ld	a,#1
 666  015a cd0000        	call	_TIM2_Cmd
 668                     ; 181 }
 671  015d 81            	ret
 712                     ; 183 void HandleADC()
 712                     ; 184 {
 713                     	switch	.text
 714  015e               _HandleADC:
 716  015e 88            	push	a
 717       00000001      OFST:	set	1
 720                     ; 185 	uint8_t x = 0;
 722                     ; 188 	adcValues[idxBuffer] = 0;
 724  015f b603          	ld	a,_idxBuffer
 725  0161 5f            	clrw	x
 726  0162 97            	ld	xl,a
 727  0163 58            	sllw	x
 728  0164 905f          	clrw	y
 729  0166 ef00          	ldw	(_adcValues,x),y
 730                     ; 189 	for(x = 0; x < 8; x++)
 732  0168 0f01          	clr	(OFST+0,sp)
 734  016a               L171:
 735                     ; 191 		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 3);
 737  016a 7b01          	ld	a,(OFST+0,sp)
 738  016c cd0000        	call	_ADC1_GetBufferValue
 740  016f 58            	sllw	x
 741  0170 58            	sllw	x
 742  0171 58            	sllw	x
 743  0172 b603          	ld	a,_idxBuffer
 744  0174 905f          	clrw	y
 745  0176 9097          	ld	yl,a
 746  0178 9058          	sllw	y
 747  017a 01            	rrwa	x,a
 748  017b 90eb01        	add	a,(_adcValues+1,y)
 749  017e 01            	rrwa	x,a
 750  017f 90e900        	adc	a,(_adcValues,y)
 751  0182 01            	rrwa	x,a
 752  0183 90ef00        	ldw	(_adcValues,y),x
 753                     ; 189 	for(x = 0; x < 8; x++)
 755  0186 0c01          	inc	(OFST+0,sp)
 759  0188 7b01          	ld	a,(OFST+0,sp)
 760  018a a108          	cp	a,#8
 761  018c 25dc          	jrult	L171
 762                     ; 196 	if(bufferEmpty)
 764                     	btst	_bufferEmpty
 765  0193 241a          	jruge	L771
 766                     ; 198 		bufferEmpty = false;
 768  0195 72110000      	bres	_bufferEmpty
 769                     ; 199 		for(x = 1; x < BUFFER_SIZE; x++)
 771  0199 a601          	ld	a,#1
 772  019b 6b01          	ld	(OFST+0,sp),a
 774  019d               L102:
 775                     ; 201 			adcValues[x] = adcValues[0];
 777  019d 7b01          	ld	a,(OFST+0,sp)
 778  019f 5f            	clrw	x
 779  01a0 97            	ld	xl,a
 780  01a1 58            	sllw	x
 781  01a2 90be00        	ldw	y,_adcValues
 782  01a5 ef00          	ldw	(_adcValues,x),y
 783                     ; 199 		for(x = 1; x < BUFFER_SIZE; x++)
 785  01a7 0c01          	inc	(OFST+0,sp)
 789  01a9 7b01          	ld	a,(OFST+0,sp)
 790  01ab a140          	cp	a,#64
 791  01ad 25ee          	jrult	L102
 792  01af               L771:
 793                     ; 206 	averagedValue = 0;
 795  01af ae0000        	ldw	x,#0
 796  01b2 bf06          	ldw	_averagedValue+2,x
 797  01b4 ae0000        	ldw	x,#0
 798  01b7 bf04          	ldw	_averagedValue,x
 799                     ; 207 	for(x = 0; x < BUFFER_SIZE; x++)
 801  01b9 0f01          	clr	(OFST+0,sp)
 803  01bb               L702:
 804                     ; 209 		averagedValue += adcValues[x];
 806  01bb 7b01          	ld	a,(OFST+0,sp)
 807  01bd 5f            	clrw	x
 808  01be 97            	ld	xl,a
 809  01bf 58            	sllw	x
 810  01c0 ee00          	ldw	x,(_adcValues,x)
 811  01c2 cd0000        	call	c_uitolx
 813  01c5 ae0004        	ldw	x,#_averagedValue
 814  01c8 cd0000        	call	c_lgadd
 816                     ; 207 	for(x = 0; x < BUFFER_SIZE; x++)
 818  01cb 0c01          	inc	(OFST+0,sp)
 822  01cd 7b01          	ld	a,(OFST+0,sp)
 823  01cf a140          	cp	a,#64
 824  01d1 25e8          	jrult	L702
 825                     ; 211 	averagedValue = averagedValue / (BUFFER_SIZE * 8);
 827  01d3 ae0004        	ldw	x,#_averagedValue
 828  01d6 a609          	ld	a,#9
 829  01d8 cd0000        	call	c_lgursh
 831                     ; 212 	phRaw = averagedValue;
 833  01db be06          	ldw	x,_averagedValue+2
 834  01dd bf01          	ldw	_phRaw,x
 835                     ; 214 	idxBuffer++;
 837  01df 3c03          	inc	_idxBuffer
 838                     ; 215 	if (idxBuffer >= BUFFER_SIZE)
 840  01e1 b603          	ld	a,_idxBuffer
 841  01e3 a140          	cp	a,#64
 842  01e5 2502          	jrult	L512
 843                     ; 217 		idxBuffer = 0;
 845  01e7 3f03          	clr	_idxBuffer
 846  01e9               L512:
 847                     ; 220 	state &= ~(STATE_ADC_READY);
 849  01e9 72110000      	bres	_state,#0
 850                     ; 221 }
 853  01ed 84            	pop	a
 854  01ee 81            	ret
 935                     	xdef	_main
 936                     	xdef	_averagedValue
 937                     	xdef	_bufferEmpty
 938                     	xdef	_idxBuffer
 939                     	switch	.ubsct
 940  0000               _adcValues:
 941  0000 000000000000  	ds.b	128
 942                     	xdef	_adcValues
 943                     	xdef	_HandleADC
 944                     	xdef	_TIM2_setup
 945                     	xdef	_I2C_setup
 946                     	xdef	_ADC_setup
 947                     	xdef	_GPIO_setup
 948                     	xdef	_clock_setup
 949                     	xdef	_init
 950                     	xref	_ITC_SetSoftwarePriority
 951                     	xref	_LEDTick
 952  0080               _i2cBuffer1:
 953  0080 000000        	ds.b	3
 954                     	xdef	_i2cBuffer1
 955                     	xdef	_phRaw
 956                     	xdef	_state
 957                     	xdef	_assert_failed
 958                     	xref	_TIM2_ITConfig
 959                     	xref	_TIM2_Cmd
 960                     	xref	_TIM2_TimeBaseInit
 961                     	xref	_TIM2_DeInit
 962                     	xref	_I2C_ITConfig
 963                     	xref	_I2C_Cmd
 964                     	xref	_I2C_Init
 965                     	xref	_I2C_DeInit
 966                     	xref	_GPIO_Init
 967                     	xref	_GPIO_DeInit
 968                     	xref	_CLK_GetFlagStatus
 969                     	xref	_CLK_GetClockFreq
 970                     	xref	_CLK_SYSCLKConfig
 971                     	xref	_CLK_HSIPrescalerConfig
 972                     	xref	_CLK_ClockSwitchConfig
 973                     	xref	_CLK_PeripheralClockConfig
 974                     	xref	_CLK_ClockSwitchCmd
 975                     	xref	_CLK_LSICmd
 976                     	xref	_CLK_HSICmd
 977                     	xref	_CLK_HSECmd
 978                     	xref	_CLK_DeInit
 979                     	xref	_ADC1_GetBufferValue
 980                     	xref	_ADC1_ITConfig
 981                     	xref	_ADC1_DataBufferCmd
 982                     	xref	_ADC1_Cmd
 983                     	xref	_ADC1_Init
 984                     	xref	_ADC1_DeInit
 985                     	xref.b	c_lreg
 986                     	xref.b	c_x
1006                     	xref	c_lgursh
1007                     	xref	c_lgadd
1008                     	xref	c_uitolx
1009                     	xref	c_ludv
1010                     	end
