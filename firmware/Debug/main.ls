   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  15                     	bsct
  16  0000               _state:
  17  0000 00            	dc.b	0
  18  0001               _phRaw:
  19  0001 0000          	dc.w	0
  20  0003               _idxBuffer:
  21  0003 00            	dc.b	0
  22                     .bit:	section	.data,bit
  23  0000               _bufferEmpty:
  24  0000 01            	dc.b	1
  25  0001               _need:
  26  0001 01            	dc.b	1
  27                     	bsct
  28  0004               _averagedValue:
  29  0004 00000000      	dc.l	0
  66                     ; 40 main()
  66                     ; 41 {
  68                     	switch	.text
  69  0000               _main:
  73                     ; 42 	init();
  75  0000 ad4e          	call	_init
  77                     ; 44 	SetLED(LED_PANIC, 1);
  79  0002 4b01          	push	#1
  80  0004 aeaaaa        	ldw	x,#43690
  81  0007 cd0000        	call	_SetLED
  83  000a 84            	pop	a
  84                     ; 47 	wfi(); //wait for interrupts
  87  000b 8f            wfi
  90  000c 2021          	jra	L72
  91  000e               L52:
  92                     ; 53 			if (state & STATE_ADC_READY)
  94  000e b600          	ld	a,_state
  95  0010 a501          	bcp	a,#1
  96  0012 2703          	jreq	L33
  97                     ; 55 				HandleADC();				
  99  0014 cd0182        	call	_HandleADC
 101  0017               L33:
 102                     ; 59 			if (state & STATE_I2C_READY  && 1 == 0)
 104  0017 b600          	ld	a,_state
 105  0019 a502          	bcp	a,#2
 107                     ; 65 			if (state & STATE_TMR_TICK)
 110  001b b600          	ld	a,_state
 111  001d a504          	bcp	a,#4
 112  001f 270e          	jreq	L72
 113                     ; 67 				HandleTimerTick();
 115  0021 cd0213        	call	_HandleTimerTick
 117                     ; 68 				if(need == true)
 119                     	btst	_need
 120  0029 2404          	jruge	L72
 121                     ; 70 					need = false;
 123  002b 72110001      	bres	_need
 124  002f               L72:
 125                     ; 50 		while (state > 0)
 127  002f 3d00          	tnz	_state
 128  0031 26db          	jrne	L52
 129                     ; 77 		wfi();
 132  0033 8f            wfi
 136  0034 20f9          	jra	L72
 172                     ; 81 void assert_failed(u8* file, u32 line)
 172                     ; 82 {
 173                     	switch	.text
 174  0036               _assert_failed:
 178                     ; 83 	SetLED(LED_PANIC, 10);
 180  0036 4b0a          	push	#10
 181  0038 aeaaaa        	ldw	x,#43690
 182  003b cd0000        	call	_SetLED
 184  003e 84            	pop	a
 185                     ; 84 }
 188  003f 81            	ret
 222                     ; 86 void Delay(uint16_t nCount)
 222                     ; 87 {
 223                     	switch	.text
 224  0040               _Delay:
 226  0040 89            	pushw	x
 227       00000000      OFST:	set	0
 230  0041 2007          	jra	L101
 231  0043               L77:
 232                     ; 91     nCount--;
 234  0043 1e01          	ldw	x,(OFST+1,sp)
 235  0045 1d0001        	subw	x,#1
 236  0048 1f01          	ldw	(OFST+1,sp),x
 237  004a               L101:
 238                     ; 89   while (nCount != 0)
 240  004a 1e01          	ldw	x,(OFST+1,sp)
 241  004c 26f5          	jrne	L77
 242                     ; 93 }
 245  004e 85            	popw	x
 246  004f 81            	ret
 275                     ; 95 void init()
 275                     ; 96 {
 276                     	switch	.text
 277  0050               _init:
 281                     ; 97   clock_setup();
 283  0050 ad10          	call	_clock_setup
 285                     ; 98   GPIO_setup();
 287  0052 ad72          	call	_GPIO_setup
 289                     ; 99 	ADC_setup();
 291  0054 cd010f        	call	_ADC_setup
 293                     ; 100 	TIM2_setup();
 295  0057 cd0169        	call	_TIM2_setup
 297                     ; 101 	I2C_setup(0x45);
 299  005a ae0045        	ldw	x,#69
 300  005d cd013a        	call	_I2C_setup
 302                     ; 105   enableInterrupts();
 305  0060 9a            rim
 307                     ; 106 }
 311  0061 81            	ret
 344                     ; 108 void clock_setup(void)
 344                     ; 109 {
 345                     	switch	.text
 346  0062               _clock_setup:
 350                     ; 110   CLK_DeInit();
 352  0062 cd0000        	call	_CLK_DeInit
 354                     ; 112   CLK_HSECmd(DISABLE);
 356  0065 4f            	clr	a
 357  0066 cd0000        	call	_CLK_HSECmd
 359                     ; 113   CLK_LSICmd(DISABLE);
 361  0069 4f            	clr	a
 362  006a cd0000        	call	_CLK_LSICmd
 364                     ; 114   CLK_HSICmd(ENABLE);
 366  006d a601          	ld	a,#1
 367  006f cd0000        	call	_CLK_HSICmd
 370  0072               L721:
 371                     ; 115   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 373  0072 ae0102        	ldw	x,#258
 374  0075 cd0000        	call	_CLK_GetFlagStatus
 376  0078 4d            	tnz	a
 377  0079 27f7          	jreq	L721
 378                     ; 117   CLK_ClockSwitchCmd(ENABLE);
 380  007b a601          	ld	a,#1
 381  007d cd0000        	call	_CLK_ClockSwitchCmd
 383                     ; 118   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 385  0080 a608          	ld	a,#8
 386  0082 cd0000        	call	_CLK_HSIPrescalerConfig
 388                     ; 119   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 390  0085 a680          	ld	a,#128
 391  0087 cd0000        	call	_CLK_SYSCLKConfig
 393                     ; 121   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 393                     ; 122 		DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 395  008a 4b01          	push	#1
 396  008c 4b00          	push	#0
 397  008e ae01e1        	ldw	x,#481
 398  0091 cd0000        	call	_CLK_ClockSwitchConfig
 400  0094 85            	popw	x
 401                     ; 124   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
 403  0095 ae0001        	ldw	x,#1
 404  0098 cd0000        	call	_CLK_PeripheralClockConfig
 406                     ; 125   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 408  009b ae0100        	ldw	x,#256
 409  009e cd0000        	call	_CLK_PeripheralClockConfig
 411                     ; 126   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 413  00a1 ae0300        	ldw	x,#768
 414  00a4 cd0000        	call	_CLK_PeripheralClockConfig
 416                     ; 127   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 418  00a7 ae1200        	ldw	x,#4608
 419  00aa cd0000        	call	_CLK_PeripheralClockConfig
 421                     ; 128   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 423  00ad ae1301        	ldw	x,#4865
 424  00b0 cd0000        	call	_CLK_PeripheralClockConfig
 426                     ; 129   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 428  00b3 ae0700        	ldw	x,#1792
 429  00b6 cd0000        	call	_CLK_PeripheralClockConfig
 431                     ; 130   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 433  00b9 ae0501        	ldw	x,#1281
 434  00bc cd0000        	call	_CLK_PeripheralClockConfig
 436                     ; 131   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 438  00bf ae0400        	ldw	x,#1024
 439  00c2 cd0000        	call	_CLK_PeripheralClockConfig
 441                     ; 132 }
 444  00c5 81            	ret
 469                     ; 134 void GPIO_setup()
 469                     ; 135 {
 470                     	switch	.text
 471  00c6               _GPIO_setup:
 475                     ; 137   GPIO_DeInit(LED_port);
 477  00c6 ae500f        	ldw	x,#20495
 478  00c9 cd0000        	call	_GPIO_DeInit
 480                     ; 138   GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_LOW_FAST);
 482  00cc 4be0          	push	#224
 483  00ce 4b08          	push	#8
 484  00d0 ae500f        	ldw	x,#20495
 485  00d3 cd0000        	call	_GPIO_Init
 487  00d6 85            	popw	x
 488                     ; 141 	GPIO_Init(ADDR_port, ADDR_pin_1, GPIO_MODE_IN_PU_NO_IT);
 490  00d7 4b40          	push	#64
 491  00d9 4b10          	push	#16
 492  00db ae500f        	ldw	x,#20495
 493  00de cd0000        	call	_GPIO_Init
 495  00e1 85            	popw	x
 496                     ; 142 	GPIO_Init(ADDR_port, ADDR_pin_2, GPIO_MODE_IN_PU_NO_IT);
 498  00e2 4b40          	push	#64
 499  00e4 4b20          	push	#32
 500  00e6 ae500f        	ldw	x,#20495
 501  00e9 cd0000        	call	_GPIO_Init
 503  00ec 85            	popw	x
 504                     ; 145 	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
 506  00ed 4b00          	push	#0
 507  00ef 4b40          	push	#64
 508  00f1 ae500f        	ldw	x,#20495
 509  00f4 cd0000        	call	_GPIO_Init
 511  00f7 85            	popw	x
 512                     ; 148 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
 514  00f8 4bb0          	push	#176
 515  00fa 4b10          	push	#16
 516  00fc ae5005        	ldw	x,#20485
 517  00ff cd0000        	call	_GPIO_Init
 519  0102 85            	popw	x
 520                     ; 149 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
 522  0103 4bb0          	push	#176
 523  0105 4b20          	push	#32
 524  0107 ae5005        	ldw	x,#20485
 525  010a cd0000        	call	_GPIO_Init
 527  010d 85            	popw	x
 528                     ; 151 }
 531  010e 81            	ret
 559                     ; 153 void ADC_setup()
 559                     ; 154 {
 560                     	switch	.text
 561  010f               _ADC_setup:
 565                     ; 155 	ADC1_DeInit();
 567  010f cd0000        	call	_ADC1_DeInit
 569                     ; 157 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 569                     ; 158              ADC1_CHANNEL_6,
 569                     ; 159              ADC1_PRESSEL_FCPU_D12, 
 569                     ; 160              ADC1_EXTTRIG_GPIO, 
 569                     ; 161              DISABLE, 
 569                     ; 162              ADC1_ALIGN_RIGHT, 
 569                     ; 163              ADC1_SCHMITTTRIG_CHANNEL6, 
 569                     ; 164              DISABLE);
 571  0112 4b00          	push	#0
 572  0114 4b06          	push	#6
 573  0116 4b08          	push	#8
 574  0118 4b00          	push	#0
 575  011a 4b10          	push	#16
 576  011c 4b60          	push	#96
 577  011e ae0106        	ldw	x,#262
 578  0121 cd0000        	call	_ADC1_Init
 580  0124 5b06          	addw	sp,#6
 581                     ; 165 	ADC1_DataBufferCmd(ENABLE);
 583  0126 a601          	ld	a,#1
 584  0128 cd0000        	call	_ADC1_DataBufferCmd
 586                     ; 166 	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
 588  012b 4b01          	push	#1
 589  012d ae0020        	ldw	x,#32
 590  0130 cd0000        	call	_ADC1_ITConfig
 592  0133 84            	pop	a
 593                     ; 167 	ADC1_Cmd(ENABLE);
 595  0134 a601          	ld	a,#1
 596  0136 cd0000        	call	_ADC1_Cmd
 598                     ; 168 }
 601  0139 81            	ret
 639                     .const:	section	.text
 640  0000               L42:
 641  0000 000f4240      	dc.l	1000000
 642                     ; 170 void I2C_setup(uint16_t address)
 642                     ; 171 {
 643                     	switch	.text
 644  013a               _I2C_setup:
 646  013a 89            	pushw	x
 647       00000000      OFST:	set	0
 650                     ; 174 	I2C_DeInit();
 652  013b cd0000        	call	_I2C_DeInit
 654                     ; 175 	I2C_Init(100000, 
 654                     ; 176 					 address << 1, 
 654                     ; 177 					 I2C_DUTYCYCLE_2, 
 654                     ; 178 					 I2C_ACK_CURR, 
 654                     ; 179 					 I2C_ADDMODE_7BIT, 
 654                     ; 180 					 (CLK_GetClockFreq() / 1000000));
 656  013e cd0000        	call	_CLK_GetClockFreq
 658  0141 ae0000        	ldw	x,#L42
 659  0144 cd0000        	call	c_ludv
 661  0147 b603          	ld	a,c_lreg+3
 662  0149 88            	push	a
 663  014a 4b00          	push	#0
 664  014c 4b01          	push	#1
 665  014e 4b00          	push	#0
 666  0150 1e05          	ldw	x,(OFST+5,sp)
 667  0152 58            	sllw	x
 668  0153 89            	pushw	x
 669  0154 ae86a0        	ldw	x,#34464
 670  0157 89            	pushw	x
 671  0158 ae0001        	ldw	x,#1
 672  015b 89            	pushw	x
 673  015c cd0000        	call	_I2C_Init
 675  015f 5b0a          	addw	sp,#10
 676                     ; 183   I2C_ITConfig((I2C_IT_TypeDef)(I2C_IT_ERR | I2C_IT_EVT | I2C_IT_BUF), ENABLE);
 678  0161 ae0701        	ldw	x,#1793
 679  0164 cd0000        	call	_I2C_ITConfig
 681                     ; 187 }
 684  0167 85            	popw	x
 685  0168 81            	ret
 712                     ; 189 void TIM2_setup(void)
 712                     ; 190 {
 713                     	switch	.text
 714  0169               _TIM2_setup:
 718                     ; 191     TIM2_DeInit();
 720  0169 cd0000        	call	_TIM2_DeInit
 722                     ; 192     TIM2_TimeBaseInit(TIM2_PRESCALER_32, 32000);
 724  016c ae7d00        	ldw	x,#32000
 725  016f 89            	pushw	x
 726  0170 a605          	ld	a,#5
 727  0172 cd0000        	call	_TIM2_TimeBaseInit
 729  0175 85            	popw	x
 730                     ; 193 		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 732  0176 ae0101        	ldw	x,#257
 733  0179 cd0000        	call	_TIM2_ITConfig
 735                     ; 194     TIM2_Cmd(ENABLE);
 737  017c a601          	ld	a,#1
 738  017e cd0000        	call	_TIM2_Cmd
 740                     ; 195 }
 743  0181 81            	ret
 784                     ; 197 void HandleADC()
 784                     ; 198 {
 785                     	switch	.text
 786  0182               _HandleADC:
 788  0182 88            	push	a
 789       00000001      OFST:	set	1
 792                     ; 199 	uint8_t x = 0;
 794                     ; 202 	adcValues[idxBuffer] = 0;
 796  0183 b603          	ld	a,_idxBuffer
 797  0185 5f            	clrw	x
 798  0186 97            	ld	xl,a
 799  0187 58            	sllw	x
 800  0188 905f          	clrw	y
 801  018a ef00          	ldw	(_adcValues,x),y
 802                     ; 203 	for(x = 0; x < 8; x++)
 804  018c 0f01          	clr	(OFST+0,sp)
 806  018e               L712:
 807                     ; 205 		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 3);
 809  018e 7b01          	ld	a,(OFST+0,sp)
 810  0190 cd0000        	call	_ADC1_GetBufferValue
 812  0193 58            	sllw	x
 813  0194 58            	sllw	x
 814  0195 58            	sllw	x
 815  0196 b603          	ld	a,_idxBuffer
 816  0198 905f          	clrw	y
 817  019a 9097          	ld	yl,a
 818  019c 9058          	sllw	y
 819  019e 01            	rrwa	x,a
 820  019f 90eb01        	add	a,(_adcValues+1,y)
 821  01a2 01            	rrwa	x,a
 822  01a3 90e900        	adc	a,(_adcValues,y)
 823  01a6 01            	rrwa	x,a
 824  01a7 90ef00        	ldw	(_adcValues,y),x
 825                     ; 203 	for(x = 0; x < 8; x++)
 827  01aa 0c01          	inc	(OFST+0,sp)
 831  01ac 7b01          	ld	a,(OFST+0,sp)
 832  01ae a108          	cp	a,#8
 833  01b0 25dc          	jrult	L712
 834                     ; 210 	if(bufferEmpty)
 836                     	btst	_bufferEmpty
 837  01b7 241a          	jruge	L522
 838                     ; 212 		bufferEmpty = false;
 840  01b9 72110000      	bres	_bufferEmpty
 841                     ; 213 		for(x = 1; x < BUFFER_SIZE; x++)
 843  01bd a601          	ld	a,#1
 844  01bf 6b01          	ld	(OFST+0,sp),a
 846  01c1               L722:
 847                     ; 215 			adcValues[x] = adcValues[0];
 849  01c1 7b01          	ld	a,(OFST+0,sp)
 850  01c3 5f            	clrw	x
 851  01c4 97            	ld	xl,a
 852  01c5 58            	sllw	x
 853  01c6 90be00        	ldw	y,_adcValues
 854  01c9 ef00          	ldw	(_adcValues,x),y
 855                     ; 213 		for(x = 1; x < BUFFER_SIZE; x++)
 857  01cb 0c01          	inc	(OFST+0,sp)
 861  01cd 7b01          	ld	a,(OFST+0,sp)
 862  01cf a140          	cp	a,#64
 863  01d1 25ee          	jrult	L722
 864  01d3               L522:
 865                     ; 220 	averagedValue = 0;
 867  01d3 ae0000        	ldw	x,#0
 868  01d6 bf06          	ldw	_averagedValue+2,x
 869  01d8 ae0000        	ldw	x,#0
 870  01db bf04          	ldw	_averagedValue,x
 871                     ; 221 	for(x = 0; x < BUFFER_SIZE; x++)
 873  01dd 0f01          	clr	(OFST+0,sp)
 875  01df               L532:
 876                     ; 223 		averagedValue += adcValues[x];
 878  01df 7b01          	ld	a,(OFST+0,sp)
 879  01e1 5f            	clrw	x
 880  01e2 97            	ld	xl,a
 881  01e3 58            	sllw	x
 882  01e4 ee00          	ldw	x,(_adcValues,x)
 883  01e6 cd0000        	call	c_uitolx
 885  01e9 ae0004        	ldw	x,#_averagedValue
 886  01ec cd0000        	call	c_lgadd
 888                     ; 221 	for(x = 0; x < BUFFER_SIZE; x++)
 890  01ef 0c01          	inc	(OFST+0,sp)
 894  01f1 7b01          	ld	a,(OFST+0,sp)
 895  01f3 a140          	cp	a,#64
 896  01f5 25e8          	jrult	L532
 897                     ; 225 	averagedValue = averagedValue / (BUFFER_SIZE * 8);
 899  01f7 ae0004        	ldw	x,#_averagedValue
 900  01fa a609          	ld	a,#9
 901  01fc cd0000        	call	c_lgursh
 903                     ; 226 	phRaw = averagedValue;
 905  01ff be06          	ldw	x,_averagedValue+2
 906  0201 bf01          	ldw	_phRaw,x
 907                     ; 228 	idxBuffer++;
 909  0203 3c03          	inc	_idxBuffer
 910                     ; 229 	if (idxBuffer >= BUFFER_SIZE)
 912  0205 b603          	ld	a,_idxBuffer
 913  0207 a140          	cp	a,#64
 914  0209 2502          	jrult	L342
 915                     ; 231 		idxBuffer = 0;
 917  020b 3f03          	clr	_idxBuffer
 918  020d               L342:
 919                     ; 234 	state &= ~(STATE_ADC_READY);
 921  020d 72110000      	bres	_state,#0
 922                     ; 235 }
 925  0211 84            	pop	a
 926  0212 81            	ret
 951                     ; 237 void HandleTimerTick()
 951                     ; 238 {
 952                     	switch	.text
 953  0213               _HandleTimerTick:
 957                     ; 239 	LEDTick();
 959  0213 cd0000        	call	_LEDTick
 961                     ; 240 	state &= ~(STATE_TMR_TICK);	
 963  0216 72150000      	bres	_state,#2
 964                     ; 241 }
 967  021a 81            	ret
1048                     	xdef	_main
1049                     	xdef	_averagedValue
1050                     	xdef	_need
1051                     	xdef	_bufferEmpty
1052                     	xdef	_idxBuffer
1053                     	switch	.ubsct
1054  0000               _adcValues:
1055  0000 000000000000  	ds.b	128
1056                     	xdef	_adcValues
1057                     	xdef	_HandleTimerTick
1058                     	xdef	_HandleADC
1059                     	xdef	_Delay
1060                     	xdef	_TIM2_setup
1061                     	xdef	_I2C_setup
1062                     	xdef	_ADC_setup
1063                     	xdef	_GPIO_setup
1064                     	xdef	_clock_setup
1065                     	xdef	_init
1066                     	xref	_LEDTick
1067                     	xref	_SetLED
1068                     	xdef	_phRaw
1069                     	xdef	_state
1070                     	xdef	_assert_failed
1071                     	xref	_TIM2_ITConfig
1072                     	xref	_TIM2_Cmd
1073                     	xref	_TIM2_TimeBaseInit
1074                     	xref	_TIM2_DeInit
1075                     	xref	_I2C_ITConfig
1076                     	xref	_I2C_Init
1077                     	xref	_I2C_DeInit
1078                     	xref	_GPIO_Init
1079                     	xref	_GPIO_DeInit
1080                     	xref	_CLK_GetFlagStatus
1081                     	xref	_CLK_GetClockFreq
1082                     	xref	_CLK_SYSCLKConfig
1083                     	xref	_CLK_HSIPrescalerConfig
1084                     	xref	_CLK_ClockSwitchConfig
1085                     	xref	_CLK_PeripheralClockConfig
1086                     	xref	_CLK_ClockSwitchCmd
1087                     	xref	_CLK_LSICmd
1088                     	xref	_CLK_HSICmd
1089                     	xref	_CLK_HSECmd
1090                     	xref	_CLK_DeInit
1091                     	xref	_ADC1_GetBufferValue
1092                     	xref	_ADC1_ITConfig
1093                     	xref	_ADC1_DataBufferCmd
1094                     	xref	_ADC1_Cmd
1095                     	xref	_ADC1_Init
1096                     	xref	_ADC1_DeInit
1097                     	xref.b	c_lreg
1098                     	xref.b	c_x
1118                     	xref	c_lgursh
1119                     	xref	c_lgadd
1120                     	xref	c_uitolx
1121                     	xref	c_ludv
1122                     	end
