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
  65                     ; 40 main()
  65                     ; 41 {
  67                     	switch	.text
  68  0000               _main:
  72                     ; 42 	init();
  74  0000 ad41          	call	_init
  76                     ; 47 	wfi(); //wait for interrupts
  79  0002 8f            wfi
  82  0003 2021          	jra	L72
  83  0005               L52:
  84                     ; 53 			if (state & STATE_ADC_READY)
  86  0005 b600          	ld	a,_state
  87  0007 a501          	bcp	a,#1
  88  0009 2703          	jreq	L33
  89                     ; 55 				HandleADC();				
  91  000b cd0175        	call	_HandleADC
  93  000e               L33:
  94                     ; 59 			if (state & STATE_I2C_READY  && 1 == 0)
  96  000e b600          	ld	a,_state
  97  0010 a502          	bcp	a,#2
  99                     ; 65 			if (state & STATE_TMR_TICK)
 102  0012 b600          	ld	a,_state
 103  0014 a504          	bcp	a,#4
 104  0016 270e          	jreq	L72
 105                     ; 67 				HandleTimerTick();
 107  0018 cd0205        	call	_HandleTimerTick
 109                     ; 68 				if(need == true)
 111                     	btst	_need
 112  0020 2404          	jruge	L72
 113                     ; 70 					need = false;
 115  0022 72110001      	bres	_need
 116  0026               L72:
 117                     ; 50 		while (state > 0)
 119  0026 3d00          	tnz	_state
 120  0028 26db          	jrne	L52
 121                     ; 77 		wfi();
 124  002a 8f            wfi
 128  002b 20f9          	jra	L72
 164                     ; 81 void assert_failed(u8* file, u32 line)
 164                     ; 82 {
 165                     	switch	.text
 166  002d               _assert_failed:
 170                     ; 83   led.pattern = LED_PANIC;
 172  002d aeaaaa        	ldw	x,#43690
 173  0030 bf01          	ldw	_led+1,x
 174                     ; 84 }
 177  0032 81            	ret
 211                     ; 86 void Delay(uint16_t nCount)
 211                     ; 87 {
 212                     	switch	.text
 213  0033               _Delay:
 215  0033 89            	pushw	x
 216       00000000      OFST:	set	0
 219  0034 2007          	jra	L101
 220  0036               L77:
 221                     ; 91     nCount--;
 223  0036 1e01          	ldw	x,(OFST+1,sp)
 224  0038 1d0001        	subw	x,#1
 225  003b 1f01          	ldw	(OFST+1,sp),x
 226  003d               L101:
 227                     ; 89   while (nCount != 0)
 229  003d 1e01          	ldw	x,(OFST+1,sp)
 230  003f 26f5          	jrne	L77
 231                     ; 93 }
 234  0041 85            	popw	x
 235  0042 81            	ret
 264                     ; 95 void init()
 264                     ; 96 {
 265                     	switch	.text
 266  0043               _init:
 270                     ; 97   clock_setup();
 272  0043 ad10          	call	_clock_setup
 274                     ; 98   GPIO_setup();
 276  0045 ad72          	call	_GPIO_setup
 278                     ; 99 	ADC_setup();
 280  0047 cd0102        	call	_ADC_setup
 282                     ; 100 	TIM2_setup();
 284  004a cd015c        	call	_TIM2_setup
 286                     ; 101 	I2C_setup(0x45);
 288  004d ae0045        	ldw	x,#69
 289  0050 cd012d        	call	_I2C_setup
 291                     ; 105   enableInterrupts();
 294  0053 9a            rim
 296                     ; 106 }
 300  0054 81            	ret
 333                     ; 108 void clock_setup(void)
 333                     ; 109 {
 334                     	switch	.text
 335  0055               _clock_setup:
 339                     ; 110   CLK_DeInit();
 341  0055 cd0000        	call	_CLK_DeInit
 343                     ; 112   CLK_HSECmd(DISABLE);
 345  0058 4f            	clr	a
 346  0059 cd0000        	call	_CLK_HSECmd
 348                     ; 113   CLK_LSICmd(DISABLE);
 350  005c 4f            	clr	a
 351  005d cd0000        	call	_CLK_LSICmd
 353                     ; 114   CLK_HSICmd(ENABLE);
 355  0060 a601          	ld	a,#1
 356  0062 cd0000        	call	_CLK_HSICmd
 359  0065               L721:
 360                     ; 115   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 362  0065 ae0102        	ldw	x,#258
 363  0068 cd0000        	call	_CLK_GetFlagStatus
 365  006b 4d            	tnz	a
 366  006c 27f7          	jreq	L721
 367                     ; 117   CLK_ClockSwitchCmd(ENABLE);
 369  006e a601          	ld	a,#1
 370  0070 cd0000        	call	_CLK_ClockSwitchCmd
 372                     ; 118   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 374  0073 a608          	ld	a,#8
 375  0075 cd0000        	call	_CLK_HSIPrescalerConfig
 377                     ; 119   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 379  0078 a680          	ld	a,#128
 380  007a cd0000        	call	_CLK_SYSCLKConfig
 382                     ; 121   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 382                     ; 122 		DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 384  007d 4b01          	push	#1
 385  007f 4b00          	push	#0
 386  0081 ae01e1        	ldw	x,#481
 387  0084 cd0000        	call	_CLK_ClockSwitchConfig
 389  0087 85            	popw	x
 390                     ; 124   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
 392  0088 ae0001        	ldw	x,#1
 393  008b cd0000        	call	_CLK_PeripheralClockConfig
 395                     ; 125   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 397  008e ae0100        	ldw	x,#256
 398  0091 cd0000        	call	_CLK_PeripheralClockConfig
 400                     ; 126   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 402  0094 ae0300        	ldw	x,#768
 403  0097 cd0000        	call	_CLK_PeripheralClockConfig
 405                     ; 127   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 407  009a ae1200        	ldw	x,#4608
 408  009d cd0000        	call	_CLK_PeripheralClockConfig
 410                     ; 128   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 412  00a0 ae1301        	ldw	x,#4865
 413  00a3 cd0000        	call	_CLK_PeripheralClockConfig
 415                     ; 129   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 417  00a6 ae0700        	ldw	x,#1792
 418  00a9 cd0000        	call	_CLK_PeripheralClockConfig
 420                     ; 130   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 422  00ac ae0501        	ldw	x,#1281
 423  00af cd0000        	call	_CLK_PeripheralClockConfig
 425                     ; 131   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 427  00b2 ae0400        	ldw	x,#1024
 428  00b5 cd0000        	call	_CLK_PeripheralClockConfig
 430                     ; 132 }
 433  00b8 81            	ret
 458                     ; 134 void GPIO_setup()
 458                     ; 135 {
 459                     	switch	.text
 460  00b9               _GPIO_setup:
 464                     ; 137   GPIO_DeInit(LED_port);
 466  00b9 ae500f        	ldw	x,#20495
 467  00bc cd0000        	call	_GPIO_DeInit
 469                     ; 138   GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_LOW_FAST);
 471  00bf 4be0          	push	#224
 472  00c1 4b08          	push	#8
 473  00c3 ae500f        	ldw	x,#20495
 474  00c6 cd0000        	call	_GPIO_Init
 476  00c9 85            	popw	x
 477                     ; 141 	GPIO_Init(ADDR_port, ADDR_pin_1, GPIO_MODE_IN_PU_NO_IT);
 479  00ca 4b40          	push	#64
 480  00cc 4b10          	push	#16
 481  00ce ae500f        	ldw	x,#20495
 482  00d1 cd0000        	call	_GPIO_Init
 484  00d4 85            	popw	x
 485                     ; 142 	GPIO_Init(ADDR_port, ADDR_pin_2, GPIO_MODE_IN_PU_NO_IT);
 487  00d5 4b40          	push	#64
 488  00d7 4b20          	push	#32
 489  00d9 ae500f        	ldw	x,#20495
 490  00dc cd0000        	call	_GPIO_Init
 492  00df 85            	popw	x
 493                     ; 145 	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
 495  00e0 4b00          	push	#0
 496  00e2 4b40          	push	#64
 497  00e4 ae500f        	ldw	x,#20495
 498  00e7 cd0000        	call	_GPIO_Init
 500  00ea 85            	popw	x
 501                     ; 148 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
 503  00eb 4bb0          	push	#176
 504  00ed 4b10          	push	#16
 505  00ef ae5005        	ldw	x,#20485
 506  00f2 cd0000        	call	_GPIO_Init
 508  00f5 85            	popw	x
 509                     ; 149 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
 511  00f6 4bb0          	push	#176
 512  00f8 4b20          	push	#32
 513  00fa ae5005        	ldw	x,#20485
 514  00fd cd0000        	call	_GPIO_Init
 516  0100 85            	popw	x
 517                     ; 151 }
 520  0101 81            	ret
 548                     ; 153 void ADC_setup()
 548                     ; 154 {
 549                     	switch	.text
 550  0102               _ADC_setup:
 554                     ; 155 	ADC1_DeInit();
 556  0102 cd0000        	call	_ADC1_DeInit
 558                     ; 157 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 558                     ; 158              ADC1_CHANNEL_6,
 558                     ; 159              ADC1_PRESSEL_FCPU_D8, 
 558                     ; 160              ADC1_EXTTRIG_GPIO, 
 558                     ; 161              DISABLE, 
 558                     ; 162              ADC1_ALIGN_RIGHT, 
 558                     ; 163              ADC1_SCHMITTTRIG_CHANNEL6, 
 558                     ; 164              DISABLE);
 560  0105 4b00          	push	#0
 561  0107 4b06          	push	#6
 562  0109 4b08          	push	#8
 563  010b 4b00          	push	#0
 564  010d 4b10          	push	#16
 565  010f 4b40          	push	#64
 566  0111 ae0106        	ldw	x,#262
 567  0114 cd0000        	call	_ADC1_Init
 569  0117 5b06          	addw	sp,#6
 570                     ; 165 	ADC1_DataBufferCmd(ENABLE);
 572  0119 a601          	ld	a,#1
 573  011b cd0000        	call	_ADC1_DataBufferCmd
 575                     ; 166 	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
 577  011e 4b01          	push	#1
 578  0120 ae0020        	ldw	x,#32
 579  0123 cd0000        	call	_ADC1_ITConfig
 581  0126 84            	pop	a
 582                     ; 167 	ADC1_Cmd(ENABLE);
 584  0127 a601          	ld	a,#1
 585  0129 cd0000        	call	_ADC1_Cmd
 587                     ; 168 }
 590  012c 81            	ret
 628                     .const:	section	.text
 629  0000               L42:
 630  0000 000f4240      	dc.l	1000000
 631                     ; 170 void I2C_setup(uint16_t address)
 631                     ; 171 {
 632                     	switch	.text
 633  012d               _I2C_setup:
 635  012d 89            	pushw	x
 636       00000000      OFST:	set	0
 639                     ; 174 	I2C_DeInit();
 641  012e cd0000        	call	_I2C_DeInit
 643                     ; 175 	I2C_Init(100000, 
 643                     ; 176 					 address << 1, 
 643                     ; 177 					 I2C_DUTYCYCLE_2, 
 643                     ; 178 					 I2C_ACK_CURR, 
 643                     ; 179 					 I2C_ADDMODE_7BIT, 
 643                     ; 180 					 (CLK_GetClockFreq() / 1000000));
 645  0131 cd0000        	call	_CLK_GetClockFreq
 647  0134 ae0000        	ldw	x,#L42
 648  0137 cd0000        	call	c_ludv
 650  013a b603          	ld	a,c_lreg+3
 651  013c 88            	push	a
 652  013d 4b00          	push	#0
 653  013f 4b01          	push	#1
 654  0141 4b00          	push	#0
 655  0143 1e05          	ldw	x,(OFST+5,sp)
 656  0145 58            	sllw	x
 657  0146 89            	pushw	x
 658  0147 ae86a0        	ldw	x,#34464
 659  014a 89            	pushw	x
 660  014b ae0001        	ldw	x,#1
 661  014e 89            	pushw	x
 662  014f cd0000        	call	_I2C_Init
 664  0152 5b0a          	addw	sp,#10
 665                     ; 183   I2C_ITConfig((I2C_IT_TypeDef)(I2C_IT_ERR | I2C_IT_EVT | I2C_IT_BUF), ENABLE);
 667  0154 ae0701        	ldw	x,#1793
 668  0157 cd0000        	call	_I2C_ITConfig
 670                     ; 187 }
 673  015a 85            	popw	x
 674  015b 81            	ret
 701                     ; 189 void TIM2_setup(void)
 701                     ; 190 {
 702                     	switch	.text
 703  015c               _TIM2_setup:
 707                     ; 191     TIM2_DeInit();
 709  015c cd0000        	call	_TIM2_DeInit
 711                     ; 192     TIM2_TimeBaseInit(TIM2_PRESCALER_32, 32000);
 713  015f ae7d00        	ldw	x,#32000
 714  0162 89            	pushw	x
 715  0163 a605          	ld	a,#5
 716  0165 cd0000        	call	_TIM2_TimeBaseInit
 718  0168 85            	popw	x
 719                     ; 193 		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 721  0169 ae0101        	ldw	x,#257
 722  016c cd0000        	call	_TIM2_ITConfig
 724                     ; 194     TIM2_Cmd(ENABLE);
 726  016f a601          	ld	a,#1
 727  0171 cd0000        	call	_TIM2_Cmd
 729                     ; 195 }
 732  0174 81            	ret
 773                     ; 197 void HandleADC()
 773                     ; 198 {
 774                     	switch	.text
 775  0175               _HandleADC:
 777  0175 88            	push	a
 778       00000001      OFST:	set	1
 781                     ; 199 	uint8_t x = 0;
 783                     ; 202 	adcValues[idxBuffer] = 0;
 785  0176 b603          	ld	a,_idxBuffer
 786  0178 5f            	clrw	x
 787  0179 97            	ld	xl,a
 788  017a 58            	sllw	x
 789  017b 905f          	clrw	y
 790  017d ef00          	ldw	(_adcValues,x),y
 791                     ; 203 	for(x = 0; x < 8; x++)
 793  017f 0f01          	clr	(OFST+0,sp)
 795  0181               L712:
 796                     ; 205 		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 2);
 798  0181 7b01          	ld	a,(OFST+0,sp)
 799  0183 cd0000        	call	_ADC1_GetBufferValue
 801  0186 58            	sllw	x
 802  0187 58            	sllw	x
 803  0188 b603          	ld	a,_idxBuffer
 804  018a 905f          	clrw	y
 805  018c 9097          	ld	yl,a
 806  018e 9058          	sllw	y
 807  0190 01            	rrwa	x,a
 808  0191 90eb01        	add	a,(_adcValues+1,y)
 809  0194 01            	rrwa	x,a
 810  0195 90e900        	adc	a,(_adcValues,y)
 811  0198 01            	rrwa	x,a
 812  0199 90ef00        	ldw	(_adcValues,y),x
 813                     ; 203 	for(x = 0; x < 8; x++)
 815  019c 0c01          	inc	(OFST+0,sp)
 819  019e 7b01          	ld	a,(OFST+0,sp)
 820  01a0 a108          	cp	a,#8
 821  01a2 25dd          	jrult	L712
 822                     ; 210 	if(bufferEmpty)
 824                     	btst	_bufferEmpty
 825  01a9 241a          	jruge	L522
 826                     ; 212 		bufferEmpty = false;
 828  01ab 72110000      	bres	_bufferEmpty
 829                     ; 213 		for(x = 1; x < BUFFER_SIZE; x++)
 831  01af a601          	ld	a,#1
 832  01b1 6b01          	ld	(OFST+0,sp),a
 834  01b3               L722:
 835                     ; 215 			adcValues[x] = adcValues[0];
 837  01b3 7b01          	ld	a,(OFST+0,sp)
 838  01b5 5f            	clrw	x
 839  01b6 97            	ld	xl,a
 840  01b7 58            	sllw	x
 841  01b8 90be00        	ldw	y,_adcValues
 842  01bb ef00          	ldw	(_adcValues,x),y
 843                     ; 213 		for(x = 1; x < BUFFER_SIZE; x++)
 845  01bd 0c01          	inc	(OFST+0,sp)
 849  01bf 7b01          	ld	a,(OFST+0,sp)
 850  01c1 a120          	cp	a,#32
 851  01c3 25ee          	jrult	L722
 852  01c5               L522:
 853                     ; 220 	averagedValue = 0;
 855  01c5 ae0000        	ldw	x,#0
 856  01c8 bf06          	ldw	_averagedValue+2,x
 857  01ca ae0000        	ldw	x,#0
 858  01cd bf04          	ldw	_averagedValue,x
 859                     ; 221 	for(x = 0; x < BUFFER_SIZE; x++)
 861  01cf 0f01          	clr	(OFST+0,sp)
 863  01d1               L532:
 864                     ; 223 		averagedValue += adcValues[x];
 866  01d1 7b01          	ld	a,(OFST+0,sp)
 867  01d3 5f            	clrw	x
 868  01d4 97            	ld	xl,a
 869  01d5 58            	sllw	x
 870  01d6 ee00          	ldw	x,(_adcValues,x)
 871  01d8 cd0000        	call	c_uitolx
 873  01db ae0004        	ldw	x,#_averagedValue
 874  01de cd0000        	call	c_lgadd
 876                     ; 221 	for(x = 0; x < BUFFER_SIZE; x++)
 878  01e1 0c01          	inc	(OFST+0,sp)
 882  01e3 7b01          	ld	a,(OFST+0,sp)
 883  01e5 a120          	cp	a,#32
 884  01e7 25e8          	jrult	L532
 885                     ; 225 	averagedValue = averagedValue / (BUFFER_SIZE * 8);
 887  01e9 ae0004        	ldw	x,#_averagedValue
 888  01ec a608          	ld	a,#8
 889  01ee cd0000        	call	c_lgursh
 891                     ; 226 	phRaw = averagedValue;
 893  01f1 be06          	ldw	x,_averagedValue+2
 894  01f3 bf01          	ldw	_phRaw,x
 895                     ; 228 	idxBuffer++;
 897  01f5 3c03          	inc	_idxBuffer
 898                     ; 229 	if (idxBuffer > 31)
 900  01f7 b603          	ld	a,_idxBuffer
 901  01f9 a120          	cp	a,#32
 902  01fb 2502          	jrult	L342
 903                     ; 231 		idxBuffer = 0;
 905  01fd 3f03          	clr	_idxBuffer
 906  01ff               L342:
 907                     ; 234 	state &= ~(STATE_ADC_READY);
 909  01ff 72110000      	bres	_state,#0
 910                     ; 235 }
 913  0203 84            	pop	a
 914  0204 81            	ret
 939                     ; 237 void HandleTimerTick()
 939                     ; 238 {
 940                     	switch	.text
 941  0205               _HandleTimerTick:
 945                     ; 239 	LEDTick();
 947  0205 cd0000        	call	_LEDTick
 949                     ; 240 	state &= ~(STATE_TMR_TICK);	
 951  0208 72150000      	bres	_state,#2
 952                     ; 241 }
 955  020c 81            	ret
1036                     	xdef	_main
1037                     	xdef	_averagedValue
1038                     	xdef	_need
1039                     	xdef	_bufferEmpty
1040                     	xdef	_idxBuffer
1041                     	switch	.ubsct
1042  0000               _adcValues:
1043  0000 000000000000  	ds.b	64
1044                     	xdef	_adcValues
1045                     	xdef	_HandleTimerTick
1046                     	xdef	_HandleADC
1047                     	xdef	_Delay
1048                     	xdef	_TIM2_setup
1049                     	xdef	_I2C_setup
1050                     	xdef	_ADC_setup
1051                     	xdef	_GPIO_setup
1052                     	xdef	_clock_setup
1053                     	xdef	_init
1054                     	xref	_LEDTick
1055                     	xref.b	_led
1056                     	xdef	_phRaw
1057                     	xdef	_state
1058                     	xdef	_assert_failed
1059                     	xref	_TIM2_ITConfig
1060                     	xref	_TIM2_Cmd
1061                     	xref	_TIM2_TimeBaseInit
1062                     	xref	_TIM2_DeInit
1063                     	xref	_I2C_ITConfig
1064                     	xref	_I2C_Init
1065                     	xref	_I2C_DeInit
1066                     	xref	_GPIO_Init
1067                     	xref	_GPIO_DeInit
1068                     	xref	_CLK_GetFlagStatus
1069                     	xref	_CLK_GetClockFreq
1070                     	xref	_CLK_SYSCLKConfig
1071                     	xref	_CLK_HSIPrescalerConfig
1072                     	xref	_CLK_ClockSwitchConfig
1073                     	xref	_CLK_PeripheralClockConfig
1074                     	xref	_CLK_ClockSwitchCmd
1075                     	xref	_CLK_LSICmd
1076                     	xref	_CLK_HSICmd
1077                     	xref	_CLK_HSECmd
1078                     	xref	_CLK_DeInit
1079                     	xref	_ADC1_GetBufferValue
1080                     	xref	_ADC1_ITConfig
1081                     	xref	_ADC1_DataBufferCmd
1082                     	xref	_ADC1_Cmd
1083                     	xref	_ADC1_Init
1084                     	xref	_ADC1_DeInit
1085                     	xref.b	c_lreg
1086                     	xref.b	c_x
1106                     	xref	c_lgursh
1107                     	xref	c_lgadd
1108                     	xref	c_uitolx
1109                     	xref	c_ludv
1110                     	end
