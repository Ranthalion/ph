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
  72  0000 ad47          	call	_init
  74                     ; 42 	SetLED(LED_PANIC, 1);
  76  0002 4b01          	push	#1
  77  0004 ae3333        	ldw	x,#13107
  78  0007 cd0000        	call	_SetLED
  80  000a 84            	pop	a
  81                     ; 44 	wfi(); //wait for interrupts
  84  000b 8f            wfi
  87  000c 201a          	jra	L72
  88  000e               L52:
  89                     ; 50 			if (state & STATE_ADC_READY)
  91  000e b600          	ld	a,_state
  92  0010 a501          	bcp	a,#1
  93  0012 2703          	jreq	L33
  94                     ; 52 				HandleADC();				
  96  0014 cd018b        	call	_HandleADC
  98  0017               L33:
  99                     ; 56 			if (state & STATE_I2C_READY  && 1 == 0)
 101  0017 b600          	ld	a,_state
 102  0019 a502          	bcp	a,#2
 104                     ; 62 			if (state & STATE_TMR_TICK)
 107  001b b600          	ld	a,_state
 108  001d a504          	bcp	a,#4
 109  001f 2707          	jreq	L72
 110                     ; 64 				LEDTick();
 112  0021 cd0000        	call	_LEDTick
 114                     ; 65 				state &= ~(STATE_TMR_TICK);
 116  0024 72150000      	bres	_state,#2
 117  0028               L72:
 118                     ; 47 		while (state > 0)
 120  0028 3d00          	tnz	_state
 121  002a 26e2          	jrne	L52
 122                     ; 69 		wfi();
 125  002c 8f            wfi
 129  002d 20f9          	jra	L72
 165                     ; 73 void assert_failed(u8* file, u32 line)
 165                     ; 74 {
 166                     	switch	.text
 167  002f               _assert_failed:
 171                     ; 75 	SetLED(LED_PANIC, 10);
 173  002f 4b0a          	push	#10
 174  0031 ae3333        	ldw	x,#13107
 175  0034 cd0000        	call	_SetLED
 177  0037 84            	pop	a
 178                     ; 76 }
 181  0038 81            	ret
 215                     ; 78 void Delay(uint16_t nCount)
 215                     ; 79 {
 216                     	switch	.text
 217  0039               _Delay:
 219  0039 89            	pushw	x
 220       00000000      OFST:	set	0
 223  003a 2007          	jra	L77
 224  003c               L57:
 225                     ; 83     nCount--;
 227  003c 1e01          	ldw	x,(OFST+1,sp)
 228  003e 1d0001        	subw	x,#1
 229  0041 1f01          	ldw	(OFST+1,sp),x
 230  0043               L77:
 231                     ; 81   while (nCount != 0)
 233  0043 1e01          	ldw	x,(OFST+1,sp)
 234  0045 26f5          	jrne	L57
 235                     ; 85 }
 238  0047 85            	popw	x
 239  0048 81            	ret
 269                     ; 87 void init()
 269                     ; 88 {
 270                     	switch	.text
 271  0049               _init:
 275                     ; 89   clock_setup();
 277  0049 ad1c          	call	_clock_setup
 279                     ; 90   GPIO_setup();
 281  004b ad7d          	call	_GPIO_setup
 283                     ; 91 	ADC_setup();
 285  004d cd0113        	call	_ADC_setup
 287                     ; 92 	TIM2_setup();
 289  0050 cd0172        	call	_TIM2_setup
 291                     ; 93 	I2C_setup(0x45);
 293  0053 ae0045        	ldw	x,#69
 294  0056 cd013e        	call	_I2C_setup
 296                     ; 95 	ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF, ITC_PRIORITYLEVEL_2);
 298  0059 ae0d00        	ldw	x,#3328
 299  005c cd0000        	call	_ITC_SetSoftwarePriority
 301                     ; 96 	ITC_SetSoftwarePriority(ITC_IRQ_ADC1, ITC_PRIORITYLEVEL_2);
 303  005f ae1600        	ldw	x,#5632
 304  0062 cd0000        	call	_ITC_SetSoftwarePriority
 306                     ; 99   enableInterrupts();
 309  0065 9a            rim
 311                     ; 100 }
 315  0066 81            	ret
 348                     ; 102 void clock_setup(void)
 348                     ; 103 {
 349                     	switch	.text
 350  0067               _clock_setup:
 354                     ; 104   CLK_DeInit();
 356  0067 cd0000        	call	_CLK_DeInit
 358                     ; 106   CLK_HSECmd(DISABLE);
 360  006a 4f            	clr	a
 361  006b cd0000        	call	_CLK_HSECmd
 363                     ; 107   CLK_LSICmd(DISABLE);
 365  006e 4f            	clr	a
 366  006f cd0000        	call	_CLK_LSICmd
 368                     ; 108   CLK_HSICmd(ENABLE);
 370  0072 a601          	ld	a,#1
 371  0074 cd0000        	call	_CLK_HSICmd
 374  0077               L521:
 375                     ; 109   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 377  0077 ae0102        	ldw	x,#258
 378  007a cd0000        	call	_CLK_GetFlagStatus
 380  007d 4d            	tnz	a
 381  007e 27f7          	jreq	L521
 382                     ; 111   CLK_ClockSwitchCmd(ENABLE);
 384  0080 a601          	ld	a,#1
 385  0082 cd0000        	call	_CLK_ClockSwitchCmd
 387                     ; 112   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 389  0085 4f            	clr	a
 390  0086 cd0000        	call	_CLK_HSIPrescalerConfig
 392                     ; 113   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 394  0089 a680          	ld	a,#128
 395  008b cd0000        	call	_CLK_SYSCLKConfig
 397                     ; 115   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 397                     ; 116 		DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 399  008e 4b01          	push	#1
 400  0090 4b00          	push	#0
 401  0092 ae01e1        	ldw	x,#481
 402  0095 cd0000        	call	_CLK_ClockSwitchConfig
 404  0098 85            	popw	x
 405                     ; 118   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
 407  0099 ae0001        	ldw	x,#1
 408  009c cd0000        	call	_CLK_PeripheralClockConfig
 410                     ; 119   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 412  009f ae0100        	ldw	x,#256
 413  00a2 cd0000        	call	_CLK_PeripheralClockConfig
 415                     ; 120   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 417  00a5 ae0300        	ldw	x,#768
 418  00a8 cd0000        	call	_CLK_PeripheralClockConfig
 420                     ; 121   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 422  00ab ae1200        	ldw	x,#4608
 423  00ae cd0000        	call	_CLK_PeripheralClockConfig
 425                     ; 122   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 427  00b1 ae1301        	ldw	x,#4865
 428  00b4 cd0000        	call	_CLK_PeripheralClockConfig
 430                     ; 123   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 432  00b7 ae0700        	ldw	x,#1792
 433  00ba cd0000        	call	_CLK_PeripheralClockConfig
 435                     ; 124   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 437  00bd ae0501        	ldw	x,#1281
 438  00c0 cd0000        	call	_CLK_PeripheralClockConfig
 440                     ; 125   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 442  00c3 ae0400        	ldw	x,#1024
 443  00c6 cd0000        	call	_CLK_PeripheralClockConfig
 445                     ; 126 }
 448  00c9 81            	ret
 473                     ; 128 void GPIO_setup()
 473                     ; 129 {
 474                     	switch	.text
 475  00ca               _GPIO_setup:
 479                     ; 131   GPIO_DeInit(LED_port);
 481  00ca ae500f        	ldw	x,#20495
 482  00cd cd0000        	call	_GPIO_DeInit
 484                     ; 132   GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_LOW_FAST);
 486  00d0 4be0          	push	#224
 487  00d2 4b08          	push	#8
 488  00d4 ae500f        	ldw	x,#20495
 489  00d7 cd0000        	call	_GPIO_Init
 491  00da 85            	popw	x
 492                     ; 135 	GPIO_Init(ADDR_port, ADDR_pin_1, GPIO_MODE_IN_PU_NO_IT);
 494  00db 4b40          	push	#64
 495  00dd 4b10          	push	#16
 496  00df ae500f        	ldw	x,#20495
 497  00e2 cd0000        	call	_GPIO_Init
 499  00e5 85            	popw	x
 500                     ; 136 	GPIO_Init(ADDR_port, ADDR_pin_2, GPIO_MODE_IN_PU_NO_IT);
 502  00e6 4b40          	push	#64
 503  00e8 4b20          	push	#32
 504  00ea ae500f        	ldw	x,#20495
 505  00ed cd0000        	call	_GPIO_Init
 507  00f0 85            	popw	x
 508                     ; 139 	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
 510  00f1 4b00          	push	#0
 511  00f3 4b40          	push	#64
 512  00f5 ae500f        	ldw	x,#20495
 513  00f8 cd0000        	call	_GPIO_Init
 515  00fb 85            	popw	x
 516                     ; 142 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
 518  00fc 4bb0          	push	#176
 519  00fe 4b10          	push	#16
 520  0100 ae5005        	ldw	x,#20485
 521  0103 cd0000        	call	_GPIO_Init
 523  0106 85            	popw	x
 524                     ; 143 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
 526  0107 4bb0          	push	#176
 527  0109 4b20          	push	#32
 528  010b ae5005        	ldw	x,#20485
 529  010e cd0000        	call	_GPIO_Init
 531  0111 85            	popw	x
 532                     ; 145 }
 535  0112 81            	ret
 563                     ; 147 void ADC_setup()
 563                     ; 148 {
 564                     	switch	.text
 565  0113               _ADC_setup:
 569                     ; 149 	ADC1_DeInit();
 571  0113 cd0000        	call	_ADC1_DeInit
 573                     ; 151 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 573                     ; 152              ADC1_CHANNEL_6,
 573                     ; 153              ADC1_PRESSEL_FCPU_D12, 
 573                     ; 154              ADC1_EXTTRIG_GPIO, 
 573                     ; 155              DISABLE, 
 573                     ; 156              ADC1_ALIGN_RIGHT, 
 573                     ; 157              ADC1_SCHMITTTRIG_CHANNEL6, 
 573                     ; 158              DISABLE);
 575  0116 4b00          	push	#0
 576  0118 4b06          	push	#6
 577  011a 4b08          	push	#8
 578  011c 4b00          	push	#0
 579  011e 4b10          	push	#16
 580  0120 4b60          	push	#96
 581  0122 ae0106        	ldw	x,#262
 582  0125 cd0000        	call	_ADC1_Init
 584  0128 5b06          	addw	sp,#6
 585                     ; 159 	ADC1_DataBufferCmd(ENABLE);
 587  012a a601          	ld	a,#1
 588  012c cd0000        	call	_ADC1_DataBufferCmd
 590                     ; 160 	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
 592  012f 4b01          	push	#1
 593  0131 ae0020        	ldw	x,#32
 594  0134 cd0000        	call	_ADC1_ITConfig
 596  0137 84            	pop	a
 597                     ; 161 	ADC1_Cmd(ENABLE);
 599  0138 a601          	ld	a,#1
 600  013a cd0000        	call	_ADC1_Cmd
 602                     ; 162 }
 605  013d 81            	ret
 644                     .const:	section	.text
 645  0000               L42:
 646  0000 000f4240      	dc.l	1000000
 647                     ; 164 void I2C_setup(uint16_t address)
 647                     ; 165 {
 648                     	switch	.text
 649  013e               _I2C_setup:
 651  013e 89            	pushw	x
 652       00000000      OFST:	set	0
 655                     ; 168 	I2C_DeInit();
 657  013f cd0000        	call	_I2C_DeInit
 659                     ; 169 	I2C_Init(400000, 
 659                     ; 170 					 address << 1, 
 659                     ; 171 					 I2C_DUTYCYCLE_2, 
 659                     ; 172 					 I2C_ACK_CURR, 
 659                     ; 173 					 I2C_ADDMODE_7BIT, 
 659                     ; 174 					 (CLK_GetClockFreq() / 1000000));
 661  0142 cd0000        	call	_CLK_GetClockFreq
 663  0145 ae0000        	ldw	x,#L42
 664  0148 cd0000        	call	c_ludv
 666  014b b603          	ld	a,c_lreg+3
 667  014d 88            	push	a
 668  014e 4b00          	push	#0
 669  0150 4b01          	push	#1
 670  0152 4b00          	push	#0
 671  0154 1e05          	ldw	x,(OFST+5,sp)
 672  0156 58            	sllw	x
 673  0157 89            	pushw	x
 674  0158 ae1a80        	ldw	x,#6784
 675  015b 89            	pushw	x
 676  015c ae0006        	ldw	x,#6
 677  015f 89            	pushw	x
 678  0160 cd0000        	call	_I2C_Init
 680  0163 5b0a          	addw	sp,#10
 681                     ; 178   I2C_ITConfig((I2C_IT_TypeDef)(I2C_IT_ERR | I2C_IT_EVT | I2C_IT_BUF), ENABLE);
 683  0165 ae0701        	ldw	x,#1793
 684  0168 cd0000        	call	_I2C_ITConfig
 686                     ; 180 	I2C_Cmd(ENABLE);
 688  016b a601          	ld	a,#1
 689  016d cd0000        	call	_I2C_Cmd
 691                     ; 182 }
 694  0170 85            	popw	x
 695  0171 81            	ret
 722                     ; 184 void TIM2_setup(void)
 722                     ; 185 {
 723                     	switch	.text
 724  0172               _TIM2_setup:
 728                     ; 186     TIM2_DeInit();
 730  0172 cd0000        	call	_TIM2_DeInit
 732                     ; 187     TIM2_TimeBaseInit(TIM2_PRESCALER_32, 32000);
 734  0175 ae7d00        	ldw	x,#32000
 735  0178 89            	pushw	x
 736  0179 a605          	ld	a,#5
 737  017b cd0000        	call	_TIM2_TimeBaseInit
 739  017e 85            	popw	x
 740                     ; 188 		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 742  017f ae0101        	ldw	x,#257
 743  0182 cd0000        	call	_TIM2_ITConfig
 745                     ; 189     TIM2_Cmd(ENABLE);
 747  0185 a601          	ld	a,#1
 748  0187 cd0000        	call	_TIM2_Cmd
 750                     ; 190 }
 753  018a 81            	ret
 794                     ; 192 void HandleADC()
 794                     ; 193 {
 795                     	switch	.text
 796  018b               _HandleADC:
 798  018b 88            	push	a
 799       00000001      OFST:	set	1
 802                     ; 194 	uint8_t x = 0;
 804                     ; 197 	adcValues[idxBuffer] = 0;
 806  018c b603          	ld	a,_idxBuffer
 807  018e 5f            	clrw	x
 808  018f 97            	ld	xl,a
 809  0190 58            	sllw	x
 810  0191 905f          	clrw	y
 811  0193 ef00          	ldw	(_adcValues,x),y
 812                     ; 198 	for(x = 0; x < 8; x++)
 814  0195 0f01          	clr	(OFST+0,sp)
 816  0197               L512:
 817                     ; 200 		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 3);
 819  0197 7b01          	ld	a,(OFST+0,sp)
 820  0199 cd0000        	call	_ADC1_GetBufferValue
 822  019c 58            	sllw	x
 823  019d 58            	sllw	x
 824  019e 58            	sllw	x
 825  019f b603          	ld	a,_idxBuffer
 826  01a1 905f          	clrw	y
 827  01a3 9097          	ld	yl,a
 828  01a5 9058          	sllw	y
 829  01a7 01            	rrwa	x,a
 830  01a8 90eb01        	add	a,(_adcValues+1,y)
 831  01ab 01            	rrwa	x,a
 832  01ac 90e900        	adc	a,(_adcValues,y)
 833  01af 01            	rrwa	x,a
 834  01b0 90ef00        	ldw	(_adcValues,y),x
 835                     ; 198 	for(x = 0; x < 8; x++)
 837  01b3 0c01          	inc	(OFST+0,sp)
 841  01b5 7b01          	ld	a,(OFST+0,sp)
 842  01b7 a108          	cp	a,#8
 843  01b9 25dc          	jrult	L512
 844                     ; 205 	if(bufferEmpty)
 846                     	btst	_bufferEmpty
 847  01c0 241a          	jruge	L322
 848                     ; 207 		bufferEmpty = false;
 850  01c2 72110000      	bres	_bufferEmpty
 851                     ; 208 		for(x = 1; x < BUFFER_SIZE; x++)
 853  01c6 a601          	ld	a,#1
 854  01c8 6b01          	ld	(OFST+0,sp),a
 856  01ca               L522:
 857                     ; 210 			adcValues[x] = adcValues[0];
 859  01ca 7b01          	ld	a,(OFST+0,sp)
 860  01cc 5f            	clrw	x
 861  01cd 97            	ld	xl,a
 862  01ce 58            	sllw	x
 863  01cf 90be00        	ldw	y,_adcValues
 864  01d2 ef00          	ldw	(_adcValues,x),y
 865                     ; 208 		for(x = 1; x < BUFFER_SIZE; x++)
 867  01d4 0c01          	inc	(OFST+0,sp)
 871  01d6 7b01          	ld	a,(OFST+0,sp)
 872  01d8 a140          	cp	a,#64
 873  01da 25ee          	jrult	L522
 874  01dc               L322:
 875                     ; 215 	averagedValue = 0;
 877  01dc ae0000        	ldw	x,#0
 878  01df bf06          	ldw	_averagedValue+2,x
 879  01e1 ae0000        	ldw	x,#0
 880  01e4 bf04          	ldw	_averagedValue,x
 881                     ; 216 	for(x = 0; x < BUFFER_SIZE; x++)
 883  01e6 0f01          	clr	(OFST+0,sp)
 885  01e8               L332:
 886                     ; 218 		averagedValue += adcValues[x];
 888  01e8 7b01          	ld	a,(OFST+0,sp)
 889  01ea 5f            	clrw	x
 890  01eb 97            	ld	xl,a
 891  01ec 58            	sllw	x
 892  01ed ee00          	ldw	x,(_adcValues,x)
 893  01ef cd0000        	call	c_uitolx
 895  01f2 ae0004        	ldw	x,#_averagedValue
 896  01f5 cd0000        	call	c_lgadd
 898                     ; 216 	for(x = 0; x < BUFFER_SIZE; x++)
 900  01f8 0c01          	inc	(OFST+0,sp)
 904  01fa 7b01          	ld	a,(OFST+0,sp)
 905  01fc a140          	cp	a,#64
 906  01fe 25e8          	jrult	L332
 907                     ; 220 	averagedValue = averagedValue / (BUFFER_SIZE * 8);
 909  0200 ae0004        	ldw	x,#_averagedValue
 910  0203 a609          	ld	a,#9
 911  0205 cd0000        	call	c_lgursh
 913                     ; 221 	phRaw = averagedValue;
 915  0208 be06          	ldw	x,_averagedValue+2
 916  020a bf01          	ldw	_phRaw,x
 917                     ; 223 	idxBuffer++;
 919  020c 3c03          	inc	_idxBuffer
 920                     ; 224 	if (idxBuffer >= BUFFER_SIZE)
 922  020e b603          	ld	a,_idxBuffer
 923  0210 a140          	cp	a,#64
 924  0212 2502          	jrult	L142
 925                     ; 226 		idxBuffer = 0;
 927  0214 3f03          	clr	_idxBuffer
 928  0216               L142:
 929                     ; 229 	state &= ~(STATE_ADC_READY);
 931  0216 72110000      	bres	_state,#0
 932                     ; 230 }
 935  021a 84            	pop	a
 936  021b 81            	ret
1007                     	xdef	_main
1008                     	xdef	_averagedValue
1009                     	xdef	_bufferEmpty
1010                     	xdef	_idxBuffer
1011                     	switch	.ubsct
1012  0000               _adcValues:
1013  0000 000000000000  	ds.b	128
1014                     	xdef	_adcValues
1015                     	xdef	_HandleADC
1016                     	xdef	_Delay
1017                     	xdef	_TIM2_setup
1018                     	xdef	_I2C_setup
1019                     	xdef	_ADC_setup
1020                     	xdef	_GPIO_setup
1021                     	xdef	_clock_setup
1022                     	xdef	_init
1023                     	xref	_ITC_SetSoftwarePriority
1024                     	xref	_LEDTick
1025                     	xref	_SetLED
1026                     	xdef	_phRaw
1027                     	xdef	_state
1028                     	xdef	_assert_failed
1029                     	xref	_TIM2_ITConfig
1030                     	xref	_TIM2_Cmd
1031                     	xref	_TIM2_TimeBaseInit
1032                     	xref	_TIM2_DeInit
1033                     	xref	_I2C_ITConfig
1034                     	xref	_I2C_Cmd
1035                     	xref	_I2C_Init
1036                     	xref	_I2C_DeInit
1037                     	xref	_GPIO_Init
1038                     	xref	_GPIO_DeInit
1039                     	xref	_CLK_GetFlagStatus
1040                     	xref	_CLK_GetClockFreq
1041                     	xref	_CLK_SYSCLKConfig
1042                     	xref	_CLK_HSIPrescalerConfig
1043                     	xref	_CLK_ClockSwitchConfig
1044                     	xref	_CLK_PeripheralClockConfig
1045                     	xref	_CLK_ClockSwitchCmd
1046                     	xref	_CLK_LSICmd
1047                     	xref	_CLK_HSICmd
1048                     	xref	_CLK_HSECmd
1049                     	xref	_CLK_DeInit
1050                     	xref	_ADC1_GetBufferValue
1051                     	xref	_ADC1_ITConfig
1052                     	xref	_ADC1_DataBufferCmd
1053                     	xref	_ADC1_Cmd
1054                     	xref	_ADC1_Init
1055                     	xref	_ADC1_DeInit
1056                     	xref.b	c_lreg
1057                     	xref.b	c_x
1077                     	xref	c_lgursh
1078                     	xref	c_lgadd
1079                     	xref	c_uitolx
1080                     	xref	c_ludv
1081                     	end
