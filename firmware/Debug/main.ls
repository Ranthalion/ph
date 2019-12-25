   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  15                     	bsct
  16  0000               _state:
  17  0000 00            	dc.b	0
  18  0001               _idxBuffer:
  19  0001 00            	dc.b	0
  20                     .bit:	section	.data,bit
  21  0000               _bufferEmpty:
  22  0000 01            	dc.b	1
  23                     	bsct
  24  0002               _averagedValue:
  25  0002 00000000      	dc.l	0
  61                     ; 41 main()
  61                     ; 42 {
  63                     	switch	.text
  64  0000               _main:
  68                     ; 43 	init();
  70  0000 ad41          	call	_init
  72                     ; 45 	led.pattern = LED_PANIC | LED_ONCE;
  74  0002 aeeaaa        	ldw	x,#60074
  75  0005 bf41          	ldw	_led+1,x
  76                     ; 47 	wfi(); //wait for interrupts
  79  0007 8f            wfi
  82  0008 201c          	jra	L72
  83  000a               L52:
  84                     ; 53 			if (state & STATE_ADC_READY)
  86  000a b600          	ld	a,_state
  87  000c a501          	bcp	a,#1
  88  000e 2703          	jreq	L33
  89                     ; 55 				HandleADC();				
  91  0010 cd0179        	call	_HandleADC
  93  0013               L33:
  94                     ; 59 			if (state & STATE_I2C_READY)
  96  0013 b600          	ld	a,_state
  97  0015 a502          	bcp	a,#2
  98  0017 2704          	jreq	L53
  99                     ; 61 				state &= ~(STATE_I2C_READY);
 101  0019 72130000      	bres	_state,#1
 102  001d               L53:
 103                     ; 65 			if (state & STATE_TMR_TICK)
 105  001d b600          	ld	a,_state
 106  001f a504          	bcp	a,#4
 107  0021 2703          	jreq	L72
 108                     ; 67 				HandleTimerTick();				
 110  0023 cd0205        	call	_HandleTimerTick
 112  0026               L72:
 113                     ; 50 		while (state > 0)
 115  0026 3d00          	tnz	_state
 116  0028 26e0          	jrne	L52
 117                     ; 71 		wfi();
 120  002a 8f            wfi
 124  002b 20f9          	jra	L72
 160                     ; 75 void assert_failed(u8* file, u32 line)
 160                     ; 76 {
 161                     	switch	.text
 162  002d               _assert_failed:
 166                     ; 79   led.pattern = LED_PANIC;
 168  002d ae2aaa        	ldw	x,#10922
 169  0030 bf41          	ldw	_led+1,x
 170                     ; 80 }
 173  0032 81            	ret
 207                     ; 82 void Delay(uint16_t nCount)
 207                     ; 83 {
 208                     	switch	.text
 209  0033               _Delay:
 211  0033 89            	pushw	x
 212       00000000      OFST:	set	0
 215  0034 2007          	jra	L77
 216  0036               L57:
 217                     ; 87     nCount--;
 219  0036 1e01          	ldw	x,(OFST+1,sp)
 220  0038 1d0001        	subw	x,#1
 221  003b 1f01          	ldw	(OFST+1,sp),x
 222  003d               L77:
 223                     ; 85   while (nCount != 0)
 225  003d 1e01          	ldw	x,(OFST+1,sp)
 226  003f 26f5          	jrne	L57
 227                     ; 89 }
 230  0041 85            	popw	x
 231  0042 81            	ret
 260                     ; 91 void init()
 260                     ; 92 {
 261                     	switch	.text
 262  0043               _init:
 266                     ; 93   clock_setup();
 268  0043 ad10          	call	_clock_setup
 270                     ; 94   GPIO_setup();
 272  0045 ad72          	call	_GPIO_setup
 274                     ; 95 	ADC_setup();
 276  0047 cd0102        	call	_ADC_setup
 278                     ; 96 	I2C_setup(0x45);
 280  004a ae0045        	ldw	x,#69
 281  004d cd012d        	call	_I2C_setup
 283                     ; 97 	TIM2_setup();
 285  0050 cd0160        	call	_TIM2_setup
 287                     ; 100   enableInterrupts();
 290  0053 9a            rim
 292                     ; 101 }
 296  0054 81            	ret
 329                     ; 103 void clock_setup(void)
 329                     ; 104 {
 330                     	switch	.text
 331  0055               _clock_setup:
 335                     ; 105   CLK_DeInit();
 337  0055 cd0000        	call	_CLK_DeInit
 339                     ; 107   CLK_HSECmd(DISABLE);
 341  0058 4f            	clr	a
 342  0059 cd0000        	call	_CLK_HSECmd
 344                     ; 108   CLK_LSICmd(DISABLE);
 346  005c 4f            	clr	a
 347  005d cd0000        	call	_CLK_LSICmd
 349                     ; 109   CLK_HSICmd(ENABLE);
 351  0060 a601          	ld	a,#1
 352  0062 cd0000        	call	_CLK_HSICmd
 355  0065               L521:
 356                     ; 110   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 358  0065 ae0102        	ldw	x,#258
 359  0068 cd0000        	call	_CLK_GetFlagStatus
 361  006b 4d            	tnz	a
 362  006c 27f7          	jreq	L521
 363                     ; 112   CLK_ClockSwitchCmd(ENABLE);
 365  006e a601          	ld	a,#1
 366  0070 cd0000        	call	_CLK_ClockSwitchCmd
 368                     ; 113   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 370  0073 a608          	ld	a,#8
 371  0075 cd0000        	call	_CLK_HSIPrescalerConfig
 373                     ; 114   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 375  0078 a680          	ld	a,#128
 376  007a cd0000        	call	_CLK_SYSCLKConfig
 378                     ; 116   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 378                     ; 117 		DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 380  007d 4b01          	push	#1
 381  007f 4b00          	push	#0
 382  0081 ae01e1        	ldw	x,#481
 383  0084 cd0000        	call	_CLK_ClockSwitchConfig
 385  0087 85            	popw	x
 386                     ; 119   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
 388  0088 ae0001        	ldw	x,#1
 389  008b cd0000        	call	_CLK_PeripheralClockConfig
 391                     ; 120   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 393  008e ae0100        	ldw	x,#256
 394  0091 cd0000        	call	_CLK_PeripheralClockConfig
 396                     ; 121   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 398  0094 ae0300        	ldw	x,#768
 399  0097 cd0000        	call	_CLK_PeripheralClockConfig
 401                     ; 122   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 403  009a ae1200        	ldw	x,#4608
 404  009d cd0000        	call	_CLK_PeripheralClockConfig
 406                     ; 123   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 408  00a0 ae1301        	ldw	x,#4865
 409  00a3 cd0000        	call	_CLK_PeripheralClockConfig
 411                     ; 124   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 413  00a6 ae0700        	ldw	x,#1792
 414  00a9 cd0000        	call	_CLK_PeripheralClockConfig
 416                     ; 125   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 418  00ac ae0501        	ldw	x,#1281
 419  00af cd0000        	call	_CLK_PeripheralClockConfig
 421                     ; 126   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 423  00b2 ae0400        	ldw	x,#1024
 424  00b5 cd0000        	call	_CLK_PeripheralClockConfig
 426                     ; 127 }
 429  00b8 81            	ret
 454                     ; 129 void GPIO_setup()
 454                     ; 130 {
 455                     	switch	.text
 456  00b9               _GPIO_setup:
 460                     ; 132   GPIO_DeInit(LED_port);
 462  00b9 ae500f        	ldw	x,#20495
 463  00bc cd0000        	call	_GPIO_DeInit
 465                     ; 133   GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_LOW_FAST);
 467  00bf 4be0          	push	#224
 468  00c1 4b08          	push	#8
 469  00c3 ae500f        	ldw	x,#20495
 470  00c6 cd0000        	call	_GPIO_Init
 472  00c9 85            	popw	x
 473                     ; 136 	GPIO_Init(ADDR_port, ADDR_pin_1, GPIO_MODE_IN_PU_NO_IT);
 475  00ca 4b40          	push	#64
 476  00cc 4b10          	push	#16
 477  00ce ae500f        	ldw	x,#20495
 478  00d1 cd0000        	call	_GPIO_Init
 480  00d4 85            	popw	x
 481                     ; 137 	GPIO_Init(ADDR_port, ADDR_pin_2, GPIO_MODE_IN_PU_NO_IT);
 483  00d5 4b40          	push	#64
 484  00d7 4b20          	push	#32
 485  00d9 ae500f        	ldw	x,#20495
 486  00dc cd0000        	call	_GPIO_Init
 488  00df 85            	popw	x
 489                     ; 140 	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
 491  00e0 4b00          	push	#0
 492  00e2 4b40          	push	#64
 493  00e4 ae500f        	ldw	x,#20495
 494  00e7 cd0000        	call	_GPIO_Init
 496  00ea 85            	popw	x
 497                     ; 143 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
 499  00eb 4bb0          	push	#176
 500  00ed 4b10          	push	#16
 501  00ef ae5005        	ldw	x,#20485
 502  00f2 cd0000        	call	_GPIO_Init
 504  00f5 85            	popw	x
 505                     ; 144 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
 507  00f6 4bb0          	push	#176
 508  00f8 4b20          	push	#32
 509  00fa ae5005        	ldw	x,#20485
 510  00fd cd0000        	call	_GPIO_Init
 512  0100 85            	popw	x
 513                     ; 146 }
 516  0101 81            	ret
 544                     ; 148 void ADC_setup()
 544                     ; 149 {
 545                     	switch	.text
 546  0102               _ADC_setup:
 550                     ; 150 	ADC1_DeInit();
 552  0102 cd0000        	call	_ADC1_DeInit
 554                     ; 152 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 554                     ; 153              ADC1_CHANNEL_6,
 554                     ; 154              ADC1_PRESSEL_FCPU_D8, 
 554                     ; 155              ADC1_EXTTRIG_GPIO, 
 554                     ; 156              DISABLE, 
 554                     ; 157              ADC1_ALIGN_RIGHT, 
 554                     ; 158              ADC1_SCHMITTTRIG_CHANNEL6, 
 554                     ; 159              DISABLE);
 556  0105 4b00          	push	#0
 557  0107 4b06          	push	#6
 558  0109 4b08          	push	#8
 559  010b 4b00          	push	#0
 560  010d 4b10          	push	#16
 561  010f 4b40          	push	#64
 562  0111 ae0106        	ldw	x,#262
 563  0114 cd0000        	call	_ADC1_Init
 565  0117 5b06          	addw	sp,#6
 566                     ; 160 	ADC1_DataBufferCmd(ENABLE);
 568  0119 a601          	ld	a,#1
 569  011b cd0000        	call	_ADC1_DataBufferCmd
 571                     ; 161 	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
 573  011e 4b01          	push	#1
 574  0120 ae0020        	ldw	x,#32
 575  0123 cd0000        	call	_ADC1_ITConfig
 577  0126 84            	pop	a
 578                     ; 162 	ADC1_Cmd(ENABLE);
 580  0127 a601          	ld	a,#1
 581  0129 cd0000        	call	_ADC1_Cmd
 583                     ; 163 }
 586  012c 81            	ret
 625                     .const:	section	.text
 626  0000               L42:
 627  0000 000f4240      	dc.l	1000000
 628                     ; 165 void I2C_setup(uint16_t address)
 628                     ; 166 {
 629                     	switch	.text
 630  012d               _I2C_setup:
 632  012d 89            	pushw	x
 633       00000000      OFST:	set	0
 636                     ; 169 	I2C_DeInit();
 638  012e cd0000        	call	_I2C_DeInit
 640                     ; 170 	I2C_Init(100000, 
 640                     ; 171 					 address, 
 640                     ; 172 					 I2C_DUTYCYCLE_2, 
 640                     ; 173 					 I2C_ACK_CURR, 
 640                     ; 174 					 I2C_ADDMODE_7BIT, 
 640                     ; 175 					 (CLK_GetClockFreq() / 1000000));
 642  0131 cd0000        	call	_CLK_GetClockFreq
 644  0134 ae0000        	ldw	x,#L42
 645  0137 cd0000        	call	c_ludv
 647  013a b603          	ld	a,c_lreg+3
 648  013c 88            	push	a
 649  013d 4b00          	push	#0
 650  013f 4b01          	push	#1
 651  0141 4b00          	push	#0
 652  0143 1e05          	ldw	x,(OFST+5,sp)
 653  0145 89            	pushw	x
 654  0146 ae86a0        	ldw	x,#34464
 655  0149 89            	pushw	x
 656  014a ae0001        	ldw	x,#1
 657  014d 89            	pushw	x
 658  014e cd0000        	call	_I2C_Init
 660  0151 5b0a          	addw	sp,#10
 661                     ; 178   I2C_ITConfig((I2C_IT_TypeDef)(I2C_IT_ERR | I2C_IT_EVT | I2C_IT_BUF), ENABLE);
 663  0153 ae0701        	ldw	x,#1793
 664  0156 cd0000        	call	_I2C_ITConfig
 666                     ; 180 	I2C_Cmd(ENABLE);
 668  0159 a601          	ld	a,#1
 669  015b cd0000        	call	_I2C_Cmd
 671                     ; 181 }
 674  015e 85            	popw	x
 675  015f 81            	ret
 702                     ; 183 void TIM2_setup(void)
 702                     ; 184 {
 703                     	switch	.text
 704  0160               _TIM2_setup:
 708                     ; 185     TIM2_DeInit();
 710  0160 cd0000        	call	_TIM2_DeInit
 712                     ; 186     TIM2_TimeBaseInit(TIM2_PRESCALER_16, 32000);
 714  0163 ae7d00        	ldw	x,#32000
 715  0166 89            	pushw	x
 716  0167 a604          	ld	a,#4
 717  0169 cd0000        	call	_TIM2_TimeBaseInit
 719  016c 85            	popw	x
 720                     ; 187 		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 722  016d ae0101        	ldw	x,#257
 723  0170 cd0000        	call	_TIM2_ITConfig
 725                     ; 188     TIM2_Cmd(ENABLE);
 727  0173 a601          	ld	a,#1
 728  0175 cd0000        	call	_TIM2_Cmd
 730                     ; 189 }
 733  0178 81            	ret
 773                     ; 191 void HandleADC()
 773                     ; 192 {
 774                     	switch	.text
 775  0179               _HandleADC:
 777  0179 88            	push	a
 778       00000001      OFST:	set	1
 781                     ; 193 	uint8_t x = 0;
 783                     ; 196 	adcValues[idxBuffer] = 0;
 785  017a b601          	ld	a,_idxBuffer
 786  017c 5f            	clrw	x
 787  017d 97            	ld	xl,a
 788  017e 58            	sllw	x
 789  017f 905f          	clrw	y
 790  0181 ef00          	ldw	(_adcValues,x),y
 791                     ; 197 	for(x = 0; x < 8; x++)
 793  0183 0f01          	clr	(OFST+0,sp)
 795  0185               L512:
 796                     ; 199 		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 2);
 798  0185 7b01          	ld	a,(OFST+0,sp)
 799  0187 cd0000        	call	_ADC1_GetBufferValue
 801  018a 58            	sllw	x
 802  018b 58            	sllw	x
 803  018c b601          	ld	a,_idxBuffer
 804  018e 905f          	clrw	y
 805  0190 9097          	ld	yl,a
 806  0192 9058          	sllw	y
 807  0194 01            	rrwa	x,a
 808  0195 90eb01        	add	a,(_adcValues+1,y)
 809  0198 01            	rrwa	x,a
 810  0199 90e900        	adc	a,(_adcValues,y)
 811  019c 01            	rrwa	x,a
 812  019d 90ef00        	ldw	(_adcValues,y),x
 813                     ; 197 	for(x = 0; x < 8; x++)
 815  01a0 0c01          	inc	(OFST+0,sp)
 819  01a2 7b01          	ld	a,(OFST+0,sp)
 820  01a4 a108          	cp	a,#8
 821  01a6 25dd          	jrult	L512
 822                     ; 204 	if(bufferEmpty)
 824                     	btst	_bufferEmpty
 825  01ad 241a          	jruge	L322
 826                     ; 206 		bufferEmpty = false;
 828  01af 72110000      	bres	_bufferEmpty
 829                     ; 207 		for(x = 1; x < BUFFER_SIZE; x++)
 831  01b3 a601          	ld	a,#1
 832  01b5 6b01          	ld	(OFST+0,sp),a
 834  01b7               L522:
 835                     ; 209 			adcValues[x] = adcValues[0];
 837  01b7 7b01          	ld	a,(OFST+0,sp)
 838  01b9 5f            	clrw	x
 839  01ba 97            	ld	xl,a
 840  01bb 58            	sllw	x
 841  01bc 90be00        	ldw	y,_adcValues
 842  01bf ef00          	ldw	(_adcValues,x),y
 843                     ; 207 		for(x = 1; x < BUFFER_SIZE; x++)
 845  01c1 0c01          	inc	(OFST+0,sp)
 849  01c3 7b01          	ld	a,(OFST+0,sp)
 850  01c5 a120          	cp	a,#32
 851  01c7 25ee          	jrult	L522
 852  01c9               L322:
 853                     ; 214 	averagedValue = 0;
 855  01c9 ae0000        	ldw	x,#0
 856  01cc bf04          	ldw	_averagedValue+2,x
 857  01ce ae0000        	ldw	x,#0
 858  01d1 bf02          	ldw	_averagedValue,x
 859                     ; 215 	for(x = 0; x < BUFFER_SIZE; x++)
 861  01d3 0f01          	clr	(OFST+0,sp)
 863  01d5               L332:
 864                     ; 217 		averagedValue += adcValues[x];
 866  01d5 7b01          	ld	a,(OFST+0,sp)
 867  01d7 5f            	clrw	x
 868  01d8 97            	ld	xl,a
 869  01d9 58            	sllw	x
 870  01da ee00          	ldw	x,(_adcValues,x)
 871  01dc cd0000        	call	c_uitolx
 873  01df ae0002        	ldw	x,#_averagedValue
 874  01e2 cd0000        	call	c_lgadd
 876                     ; 215 	for(x = 0; x < BUFFER_SIZE; x++)
 878  01e5 0c01          	inc	(OFST+0,sp)
 882  01e7 7b01          	ld	a,(OFST+0,sp)
 883  01e9 a120          	cp	a,#32
 884  01eb 25e8          	jrult	L332
 885                     ; 219 	averagedValue = averagedValue / (BUFFER_SIZE * 8);
 887  01ed ae0002        	ldw	x,#_averagedValue
 888  01f0 a608          	ld	a,#8
 889  01f2 cd0000        	call	c_lgursh
 891                     ; 222 	idxBuffer++;
 893  01f5 3c01          	inc	_idxBuffer
 894                     ; 223 	if (idxBuffer > 31)
 896  01f7 b601          	ld	a,_idxBuffer
 897  01f9 a120          	cp	a,#32
 898  01fb 2502          	jrult	L142
 899                     ; 225 		idxBuffer = 0;
 901  01fd 3f01          	clr	_idxBuffer
 902  01ff               L142:
 903                     ; 228 	state &= ~(STATE_ADC_READY);
 905  01ff 72110000      	bres	_state,#0
 906                     ; 229 }
 909  0203 84            	pop	a
 910  0204 81            	ret
 937                     ; 231 void HandleTimerTick()
 937                     ; 232 {
 938                     	switch	.text
 939  0205               _HandleTimerTick:
 943                     ; 233 	if (led.pattern & (1 << led.ctr))
 945  0205 ae0001        	ldw	x,#1
 946  0208 b640          	ld	a,_led
 947  020a 4d            	tnz	a
 948  020b 2704          	jreq	L43
 949  020d               L63:
 950  020d 58            	sllw	x
 951  020e 4a            	dec	a
 952  020f 26fc          	jrne	L63
 953  0211               L43:
 954  0211 01            	rrwa	x,a
 955  0212 b442          	and	a,_led+2
 956  0214 01            	rrwa	x,a
 957  0215 b441          	and	a,_led+1
 958  0217 01            	rrwa	x,a
 959  0218 a30000        	cpw	x,#0
 960  021b 270b          	jreq	L352
 961                     ; 235 		GPIO_WriteLow(LED_port, LED_pin);
 963  021d 4b08          	push	#8
 964  021f ae500f        	ldw	x,#20495
 965  0222 cd0000        	call	_GPIO_WriteLow
 967  0225 84            	pop	a
 969  0226 2009          	jra	L552
 970  0228               L352:
 971                     ; 239 		GPIO_WriteHigh(LED_port, LED_pin);					
 973  0228 4b08          	push	#8
 974  022a ae500f        	ldw	x,#20495
 975  022d cd0000        	call	_GPIO_WriteHigh
 977  0230 84            	pop	a
 978  0231               L552:
 979                     ; 242 	led.ctr++;
 981  0231 3c40          	inc	_led
 982                     ; 243 	if(led.ctr >=14)
 984  0233 b640          	ld	a,_led
 985  0235 a10e          	cp	a,#14
 986  0237 251d          	jrult	L752
 987                     ; 245 		if (led.pattern & (1 << led.ctr))
 989  0239 ae0001        	ldw	x,#1
 990  023c b640          	ld	a,_led
 991  023e 4d            	tnz	a
 992  023f 2704          	jreq	L04
 993  0241               L24:
 994  0241 58            	sllw	x
 995  0242 4a            	dec	a
 996  0243 26fc          	jrne	L24
 997  0245               L04:
 998  0245 01            	rrwa	x,a
 999  0246 b442          	and	a,_led+2
1000  0248 01            	rrwa	x,a
1001  0249 b441          	and	a,_led+1
1002  024b 01            	rrwa	x,a
1003  024c a30000        	cpw	x,#0
1004  024f 2703          	jreq	L162
1005                     ; 247 			led.pattern = LED_OFF;
1007  0251 5f            	clrw	x
1008  0252 bf41          	ldw	_led+1,x
1009  0254               L162:
1010                     ; 249 		led.ctr = 0;					
1012  0254 3f40          	clr	_led
1013  0256               L752:
1014                     ; 252 	state &= ~(STATE_TMR_TICK);	
1016  0256 72150000      	bres	_state,#2
1017                     ; 253 }
1020  025a 81            	ret
1113                     	xdef	_main
1114                     	xdef	_averagedValue
1115                     	xdef	_bufferEmpty
1116                     	xdef	_idxBuffer
1117                     	switch	.ubsct
1118  0000               _adcValues:
1119  0000 000000000000  	ds.b	64
1120                     	xdef	_adcValues
1121  0040               _led:
1122  0040 000000        	ds.b	3
1123                     	xdef	_led
1124                     	xdef	_HandleTimerTick
1125                     	xdef	_HandleADC
1126                     	xdef	_Delay
1127                     	xdef	_TIM2_setup
1128                     	xdef	_I2C_setup
1129                     	xdef	_ADC_setup
1130                     	xdef	_GPIO_setup
1131                     	xdef	_clock_setup
1132                     	xdef	_init
1133                     	xdef	_state
1134                     	xdef	_assert_failed
1135                     	xref	_TIM2_ITConfig
1136                     	xref	_TIM2_Cmd
1137                     	xref	_TIM2_TimeBaseInit
1138                     	xref	_TIM2_DeInit
1139                     	xref	_I2C_ITConfig
1140                     	xref	_I2C_Cmd
1141                     	xref	_I2C_Init
1142                     	xref	_I2C_DeInit
1143                     	xref	_GPIO_WriteLow
1144                     	xref	_GPIO_WriteHigh
1145                     	xref	_GPIO_Init
1146                     	xref	_GPIO_DeInit
1147                     	xref	_CLK_GetFlagStatus
1148                     	xref	_CLK_GetClockFreq
1149                     	xref	_CLK_SYSCLKConfig
1150                     	xref	_CLK_HSIPrescalerConfig
1151                     	xref	_CLK_ClockSwitchConfig
1152                     	xref	_CLK_PeripheralClockConfig
1153                     	xref	_CLK_ClockSwitchCmd
1154                     	xref	_CLK_LSICmd
1155                     	xref	_CLK_HSICmd
1156                     	xref	_CLK_HSECmd
1157                     	xref	_CLK_DeInit
1158                     	xref	_ADC1_GetBufferValue
1159                     	xref	_ADC1_ITConfig
1160                     	xref	_ADC1_DataBufferCmd
1161                     	xref	_ADC1_Cmd
1162                     	xref	_ADC1_Init
1163                     	xref	_ADC1_DeInit
1164                     	xref.b	c_lreg
1165                     	xref.b	c_x
1185                     	xref	c_lgursh
1186                     	xref	c_lgadd
1187                     	xref	c_uitolx
1188                     	xref	c_ludv
1189                     	end
