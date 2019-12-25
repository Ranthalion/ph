   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  15                     	bsct
  16  0000               _phRaw:
  17  0000 0000          	dc.w	0
  18  0002               _state:
  19  0002 00            	dc.b	0
  77                     ; 59 main()
  77                     ; 60 {
  79                     	switch	.text
  80  0000               _main:
  82  0000 5205          	subw	sp,#5
  83       00000005      OFST:	set	5
  86                     ; 61 	init();
  88  0002 cd00e8        	call	_init
  90                     ; 63 	led.pattern = LED_PANIC | LED_ONCE;
  92  0005 aeeaaa        	ldw	x,#60074
  93  0008 bf41          	ldw	_led+1,x
  94                     ; 65 	wfi(); //wait for interrupts
  97  000a 8f            wfi
 100  000b acc800c8      	jpf	L14
 101  000f               L73:
 102                     ; 72 			if (state & STATE_ADC_READY)
 104  000f b602          	ld	a,_state
 105  0011 a501          	bcp	a,#1
 106  0013 2744          	jreq	L54
 107                     ; 74 				uint32_t averageValue = 0;
 109  0015 ae0000        	ldw	x,#0
 110  0018 1f03          	ldw	(OFST-2,sp),x
 111  001a ae0000        	ldw	x,#0
 112  001d 1f01          	ldw	(OFST-4,sp),x
 114                     ; 75 				uint8_t x = 0;
 116                     ; 76 				for(x = 0; x < 8; x++)
 118  001f 0f05          	clr	(OFST+0,sp)
 120  0021               L74:
 121                     ; 78 					adcValues[x] = ADC1_GetBufferValue(x) << 2;
 123  0021 7b05          	ld	a,(OFST+0,sp)
 124  0023 cd0000        	call	_ADC1_GetBufferValue
 126  0026 58            	sllw	x
 127  0027 58            	sllw	x
 128  0028 7b05          	ld	a,(OFST+0,sp)
 129  002a 905f          	clrw	y
 130  002c 9097          	ld	yl,a
 131  002e 9058          	sllw	y
 132  0030 90ef00        	ldw	(_adcValues,y),x
 133                     ; 79 					averageValue += adcValues[x];
 135  0033 7b05          	ld	a,(OFST+0,sp)
 136  0035 5f            	clrw	x
 137  0036 97            	ld	xl,a
 138  0037 58            	sllw	x
 139  0038 ee00          	ldw	x,(_adcValues,x)
 140  003a cd0000        	call	c_uitolx
 142  003d 96            	ldw	x,sp
 143  003e 1c0001        	addw	x,#OFST-4
 144  0041 cd0000        	call	c_lgadd
 147                     ; 76 				for(x = 0; x < 8; x++)
 149  0044 0c05          	inc	(OFST+0,sp)
 153  0046 7b05          	ld	a,(OFST+0,sp)
 154  0048 a108          	cp	a,#8
 155  004a 25d5          	jrult	L74
 156                     ; 82 				averageValue = averageValue >> 3;
 158  004c 96            	ldw	x,sp
 159  004d 1c0001        	addw	x,#OFST-4
 160  0050 a603          	ld	a,#3
 161  0052 cd0000        	call	c_lgursh
 164                     ; 84 				state &= ~(STATE_ADC_READY);
 166  0055 72110002      	bres	_state,#0
 167  0059               L54:
 168                     ; 88 			if (state & STATE_I2C_READY)
 170  0059 b602          	ld	a,_state
 171  005b a502          	bcp	a,#2
 172  005d 2704          	jreq	L55
 173                     ; 91 				state &= ~(STATE_I2C_READY);
 175  005f 72130002      	bres	_state,#1
 176  0063               L55:
 177                     ; 95 			if (state & STATE_TMR_TICK)
 179  0063 b602          	ld	a,_state
 180  0065 a504          	bcp	a,#4
 181  0067 2755          	jreq	L75
 182                     ; 98 				if (led.pattern & (1 << led.ctr))
 184  0069 ae0001        	ldw	x,#1
 185  006c b640          	ld	a,_led
 186  006e 4d            	tnz	a
 187  006f 2704          	jreq	L6
 188  0071               L01:
 189  0071 58            	sllw	x
 190  0072 4a            	dec	a
 191  0073 26fc          	jrne	L01
 192  0075               L6:
 193  0075 01            	rrwa	x,a
 194  0076 b442          	and	a,_led+2
 195  0078 01            	rrwa	x,a
 196  0079 b441          	and	a,_led+1
 197  007b 01            	rrwa	x,a
 198  007c a30000        	cpw	x,#0
 199  007f 270b          	jreq	L16
 200                     ; 100 					GPIO_WriteLow(LED_port, LED_pin);
 202  0081 4b08          	push	#8
 203  0083 ae500f        	ldw	x,#20495
 204  0086 cd0000        	call	_GPIO_WriteLow
 206  0089 84            	pop	a
 208  008a 2009          	jra	L36
 209  008c               L16:
 210                     ; 104 					GPIO_WriteHigh(LED_port, LED_pin);					
 212  008c 4b08          	push	#8
 213  008e ae500f        	ldw	x,#20495
 214  0091 cd0000        	call	_GPIO_WriteHigh
 216  0094 84            	pop	a
 217  0095               L36:
 218                     ; 107 				led.ctr++;
 220  0095 3c40          	inc	_led
 221                     ; 108 				if(led.ctr >=14)
 223  0097 b640          	ld	a,_led
 224  0099 a10e          	cp	a,#14
 225  009b 251d          	jrult	L56
 226                     ; 110 					if (led.pattern & (1 << led.ctr))
 228  009d ae0001        	ldw	x,#1
 229  00a0 b640          	ld	a,_led
 230  00a2 4d            	tnz	a
 231  00a3 2704          	jreq	L21
 232  00a5               L41:
 233  00a5 58            	sllw	x
 234  00a6 4a            	dec	a
 235  00a7 26fc          	jrne	L41
 236  00a9               L21:
 237  00a9 01            	rrwa	x,a
 238  00aa b442          	and	a,_led+2
 239  00ac 01            	rrwa	x,a
 240  00ad b441          	and	a,_led+1
 241  00af 01            	rrwa	x,a
 242  00b0 a30000        	cpw	x,#0
 243  00b3 2703          	jreq	L76
 244                     ; 112 						led.pattern = LED_OFF;
 246  00b5 5f            	clrw	x
 247  00b6 bf41          	ldw	_led+1,x
 248  00b8               L76:
 249                     ; 114 					led.ctr = 0;					
 251  00b8 3f40          	clr	_led
 252  00ba               L56:
 253                     ; 117 				state &= ~(STATE_TMR_TICK);
 255  00ba 72150002      	bres	_state,#2
 256  00be               L75:
 257                     ; 121 			if (state & STATE_LED_TICK)
 259  00be b602          	ld	a,_state
 260  00c0 a508          	bcp	a,#8
 261  00c2 2704          	jreq	L14
 262                     ; 124 				state &= ~(STATE_LED_TICK);
 264  00c4 72170002      	bres	_state,#3
 265  00c8               L14:
 266                     ; 69 		while (state > 0)
 268  00c8 3d02          	tnz	_state
 269  00ca 2703          	jreq	L61
 270  00cc cc000f        	jp	L73
 271  00cf               L61:
 272                     ; 127 		wfi();
 275  00cf 8f            wfi
 279  00d0 20f6          	jra	L14
 315                     ; 142 void assert_failed(u8* file, u32 line)
 315                     ; 143 {
 316                     	switch	.text
 317  00d2               _assert_failed:
 321                     ; 146   led.pattern = LED_PANIC;
 323  00d2 ae2aaa        	ldw	x,#10922
 324  00d5 bf41          	ldw	_led+1,x
 325                     ; 147 }
 328  00d7 81            	ret
 362                     ; 149 void Delay(uint16_t nCount)
 362                     ; 150 {
 363                     	switch	.text
 364  00d8               _Delay:
 366  00d8 89            	pushw	x
 367       00000000      OFST:	set	0
 370  00d9 2007          	jra	L131
 371  00db               L721:
 372                     ; 154     nCount--;
 374  00db 1e01          	ldw	x,(OFST+1,sp)
 375  00dd 1d0001        	subw	x,#1
 376  00e0 1f01          	ldw	(OFST+1,sp),x
 377  00e2               L131:
 378                     ; 152   while (nCount != 0)
 380  00e2 1e01          	ldw	x,(OFST+1,sp)
 381  00e4 26f5          	jrne	L721
 382                     ; 156 }
 385  00e6 85            	popw	x
 386  00e7 81            	ret
 415                     ; 158 void init()
 415                     ; 159 {
 416                     	switch	.text
 417  00e8               _init:
 421                     ; 160   clock_setup();
 423  00e8 ad10          	call	_clock_setup
 425                     ; 161   GPIO_setup();
 427  00ea ad72          	call	_GPIO_setup
 429                     ; 162 	ADC_setup();
 431  00ec cd01a7        	call	_ADC_setup
 433                     ; 163 	I2C_setup(0x45);
 435  00ef ae0045        	ldw	x,#69
 436  00f2 cd01d2        	call	_I2C_setup
 438                     ; 164 	TIM2_setup();
 440  00f5 cd0205        	call	_TIM2_setup
 442                     ; 167   enableInterrupts();
 445  00f8 9a            rim
 447                     ; 168 }
 451  00f9 81            	ret
 484                     ; 170 void clock_setup(void)
 484                     ; 171 {
 485                     	switch	.text
 486  00fa               _clock_setup:
 490                     ; 172   CLK_DeInit();
 492  00fa cd0000        	call	_CLK_DeInit
 494                     ; 174   CLK_HSECmd(DISABLE);
 496  00fd 4f            	clr	a
 497  00fe cd0000        	call	_CLK_HSECmd
 499                     ; 175   CLK_LSICmd(DISABLE);
 501  0101 4f            	clr	a
 502  0102 cd0000        	call	_CLK_LSICmd
 504                     ; 176   CLK_HSICmd(ENABLE);
 506  0105 a601          	ld	a,#1
 507  0107 cd0000        	call	_CLK_HSICmd
 510  010a               L751:
 511                     ; 177   while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 513  010a ae0102        	ldw	x,#258
 514  010d cd0000        	call	_CLK_GetFlagStatus
 516  0110 4d            	tnz	a
 517  0111 27f7          	jreq	L751
 518                     ; 179   CLK_ClockSwitchCmd(ENABLE);
 520  0113 a601          	ld	a,#1
 521  0115 cd0000        	call	_CLK_ClockSwitchCmd
 523                     ; 180   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
 525  0118 a608          	ld	a,#8
 526  011a cd0000        	call	_CLK_HSIPrescalerConfig
 528                     ; 181   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 530  011d a680          	ld	a,#128
 531  011f cd0000        	call	_CLK_SYSCLKConfig
 533                     ; 183   CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 533                     ; 184 		DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 535  0122 4b01          	push	#1
 536  0124 4b00          	push	#0
 537  0126 ae01e1        	ldw	x,#481
 538  0129 cd0000        	call	_CLK_ClockSwitchConfig
 540  012c 85            	popw	x
 541                     ; 186   CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
 543  012d ae0001        	ldw	x,#1
 544  0130 cd0000        	call	_CLK_PeripheralClockConfig
 546                     ; 187   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 548  0133 ae0100        	ldw	x,#256
 549  0136 cd0000        	call	_CLK_PeripheralClockConfig
 551                     ; 188   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 553  0139 ae0300        	ldw	x,#768
 554  013c cd0000        	call	_CLK_PeripheralClockConfig
 556                     ; 189   CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 558  013f ae1200        	ldw	x,#4608
 559  0142 cd0000        	call	_CLK_PeripheralClockConfig
 561                     ; 190   CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 563  0145 ae1301        	ldw	x,#4865
 564  0148 cd0000        	call	_CLK_PeripheralClockConfig
 566                     ; 191   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 568  014b ae0700        	ldw	x,#1792
 569  014e cd0000        	call	_CLK_PeripheralClockConfig
 571                     ; 192   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 573  0151 ae0501        	ldw	x,#1281
 574  0154 cd0000        	call	_CLK_PeripheralClockConfig
 576                     ; 193   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 578  0157 ae0400        	ldw	x,#1024
 579  015a cd0000        	call	_CLK_PeripheralClockConfig
 581                     ; 194 }
 584  015d 81            	ret
 609                     ; 196 void GPIO_setup()
 609                     ; 197 {
 610                     	switch	.text
 611  015e               _GPIO_setup:
 615                     ; 199   GPIO_DeInit(LED_port);
 617  015e ae500f        	ldw	x,#20495
 618  0161 cd0000        	call	_GPIO_DeInit
 620                     ; 200   GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_LOW_FAST);
 622  0164 4be0          	push	#224
 623  0166 4b08          	push	#8
 624  0168 ae500f        	ldw	x,#20495
 625  016b cd0000        	call	_GPIO_Init
 627  016e 85            	popw	x
 628                     ; 203 	GPIO_Init(ADDR_port, ADDR_pin_1, GPIO_MODE_IN_PU_NO_IT);
 630  016f 4b40          	push	#64
 631  0171 4b10          	push	#16
 632  0173 ae500f        	ldw	x,#20495
 633  0176 cd0000        	call	_GPIO_Init
 635  0179 85            	popw	x
 636                     ; 204 	GPIO_Init(ADDR_port, ADDR_pin_2, GPIO_MODE_IN_PU_NO_IT);
 638  017a 4b40          	push	#64
 639  017c 4b20          	push	#32
 640  017e ae500f        	ldw	x,#20495
 641  0181 cd0000        	call	_GPIO_Init
 643  0184 85            	popw	x
 644                     ; 207 	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
 646  0185 4b00          	push	#0
 647  0187 4b40          	push	#64
 648  0189 ae500f        	ldw	x,#20495
 649  018c cd0000        	call	_GPIO_Init
 651  018f 85            	popw	x
 652                     ; 210 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
 654  0190 4bb0          	push	#176
 655  0192 4b10          	push	#16
 656  0194 ae5005        	ldw	x,#20485
 657  0197 cd0000        	call	_GPIO_Init
 659  019a 85            	popw	x
 660                     ; 211 	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
 662  019b 4bb0          	push	#176
 663  019d 4b20          	push	#32
 664  019f ae5005        	ldw	x,#20485
 665  01a2 cd0000        	call	_GPIO_Init
 667  01a5 85            	popw	x
 668                     ; 213 }
 671  01a6 81            	ret
 699                     ; 215 void ADC_setup()
 699                     ; 216 {
 700                     	switch	.text
 701  01a7               _ADC_setup:
 705                     ; 217 	ADC1_DeInit();
 707  01a7 cd0000        	call	_ADC1_DeInit
 709                     ; 219 	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
 709                     ; 220              ADC1_CHANNEL_6,
 709                     ; 221              ADC1_PRESSEL_FCPU_D8, 
 709                     ; 222              ADC1_EXTTRIG_GPIO, 
 709                     ; 223              DISABLE, 
 709                     ; 224              ADC1_ALIGN_RIGHT, 
 709                     ; 225              ADC1_SCHMITTTRIG_CHANNEL6, 
 709                     ; 226              DISABLE);
 711  01aa 4b00          	push	#0
 712  01ac 4b06          	push	#6
 713  01ae 4b08          	push	#8
 714  01b0 4b00          	push	#0
 715  01b2 4b10          	push	#16
 716  01b4 4b40          	push	#64
 717  01b6 ae0106        	ldw	x,#262
 718  01b9 cd0000        	call	_ADC1_Init
 720  01bc 5b06          	addw	sp,#6
 721                     ; 227 	ADC1_DataBufferCmd(ENABLE);
 723  01be a601          	ld	a,#1
 724  01c0 cd0000        	call	_ADC1_DataBufferCmd
 726                     ; 228 	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
 728  01c3 4b01          	push	#1
 729  01c5 ae0020        	ldw	x,#32
 730  01c8 cd0000        	call	_ADC1_ITConfig
 732  01cb 84            	pop	a
 733                     ; 230 	ADC1_Cmd(ENABLE);
 735  01cc a601          	ld	a,#1
 736  01ce cd0000        	call	_ADC1_Cmd
 738                     ; 231 }
 741  01d1 81            	ret
 780                     .const:	section	.text
 781  0000               L63:
 782  0000 000f4240      	dc.l	1000000
 783                     ; 233 void I2C_setup(uint16_t address)
 783                     ; 234 {
 784                     	switch	.text
 785  01d2               _I2C_setup:
 787  01d2 89            	pushw	x
 788       00000000      OFST:	set	0
 791                     ; 237 	I2C_DeInit();
 793  01d3 cd0000        	call	_I2C_DeInit
 795                     ; 238 	I2C_Init(100000, 
 795                     ; 239 					 address, 
 795                     ; 240 					 I2C_DUTYCYCLE_2, 
 795                     ; 241 					 I2C_ACK_CURR, 
 795                     ; 242 					 I2C_ADDMODE_7BIT, 
 795                     ; 243 					 (CLK_GetClockFreq() / 1000000));
 797  01d6 cd0000        	call	_CLK_GetClockFreq
 799  01d9 ae0000        	ldw	x,#L63
 800  01dc cd0000        	call	c_ludv
 802  01df b603          	ld	a,c_lreg+3
 803  01e1 88            	push	a
 804  01e2 4b00          	push	#0
 805  01e4 4b01          	push	#1
 806  01e6 4b00          	push	#0
 807  01e8 1e05          	ldw	x,(OFST+5,sp)
 808  01ea 89            	pushw	x
 809  01eb ae86a0        	ldw	x,#34464
 810  01ee 89            	pushw	x
 811  01ef ae0001        	ldw	x,#1
 812  01f2 89            	pushw	x
 813  01f3 cd0000        	call	_I2C_Init
 815  01f6 5b0a          	addw	sp,#10
 816                     ; 246   I2C_ITConfig((I2C_IT_TypeDef)(I2C_IT_ERR | I2C_IT_EVT | I2C_IT_BUF), ENABLE);
 818  01f8 ae0701        	ldw	x,#1793
 819  01fb cd0000        	call	_I2C_ITConfig
 821                     ; 248 	I2C_Cmd(ENABLE);
 823  01fe a601          	ld	a,#1
 824  0200 cd0000        	call	_I2C_Cmd
 826                     ; 249 }
 829  0203 85            	popw	x
 830  0204 81            	ret
 857                     ; 251 void TIM2_setup(void)
 857                     ; 252 {
 858                     	switch	.text
 859  0205               _TIM2_setup:
 863                     ; 253     TIM2_DeInit();
 865  0205 cd0000        	call	_TIM2_DeInit
 867                     ; 254     TIM2_TimeBaseInit(TIM2_PRESCALER_16, 32000);
 869  0208 ae7d00        	ldw	x,#32000
 870  020b 89            	pushw	x
 871  020c a604          	ld	a,#4
 872  020e cd0000        	call	_TIM2_TimeBaseInit
 874  0211 85            	popw	x
 875                     ; 255 		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 877  0212 ae0101        	ldw	x,#257
 878  0215 cd0000        	call	_TIM2_ITConfig
 880                     ; 256     TIM2_Cmd(ENABLE);
 882  0218 a601          	ld	a,#1
 883  021a cd0000        	call	_TIM2_Cmd
 885                     ; 257 }
 888  021d 81            	ret
 962                     	xdef	_main
 963                     	switch	.ubsct
 964  0000               _adcValues:
 965  0000 000000000000  	ds.b	64
 966                     	xdef	_adcValues
 967  0040               _led:
 968  0040 000000        	ds.b	3
 969                     	xdef	_led
 970                     	xdef	_phRaw
 971                     	xdef	_Delay
 972                     	xdef	_TIM2_setup
 973                     	xdef	_I2C_setup
 974                     	xdef	_ADC_setup
 975                     	xdef	_GPIO_setup
 976                     	xdef	_clock_setup
 977                     	xdef	_init
 978                     	xdef	_state
 979                     	xdef	_assert_failed
 980                     	xref	_TIM2_ITConfig
 981                     	xref	_TIM2_Cmd
 982                     	xref	_TIM2_TimeBaseInit
 983                     	xref	_TIM2_DeInit
 984                     	xref	_I2C_ITConfig
 985                     	xref	_I2C_Cmd
 986                     	xref	_I2C_Init
 987                     	xref	_I2C_DeInit
 988                     	xref	_GPIO_WriteLow
 989                     	xref	_GPIO_WriteHigh
 990                     	xref	_GPIO_Init
 991                     	xref	_GPIO_DeInit
 992                     	xref	_CLK_GetFlagStatus
 993                     	xref	_CLK_GetClockFreq
 994                     	xref	_CLK_SYSCLKConfig
 995                     	xref	_CLK_HSIPrescalerConfig
 996                     	xref	_CLK_ClockSwitchConfig
 997                     	xref	_CLK_PeripheralClockConfig
 998                     	xref	_CLK_ClockSwitchCmd
 999                     	xref	_CLK_LSICmd
1000                     	xref	_CLK_HSICmd
1001                     	xref	_CLK_HSECmd
1002                     	xref	_CLK_DeInit
1003                     	xref	_ADC1_GetBufferValue
1004                     	xref	_ADC1_ITConfig
1005                     	xref	_ADC1_DataBufferCmd
1006                     	xref	_ADC1_Cmd
1007                     	xref	_ADC1_Init
1008                     	xref	_ADC1_DeInit
1009                     	xref.b	c_lreg
1010                     	xref.b	c_x
1030                     	xref	c_ludv
1031                     	xref	c_lgursh
1032                     	xref	c_lgadd
1033                     	xref	c_uitolx
1034                     	end
