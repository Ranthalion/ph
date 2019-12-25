   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  43                     ; 52 void TIM2_DeInit(void)
  43                     ; 53 {
  45                     	switch	.text
  46  0000               _TIM2_DeInit:
  50                     ; 54   TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  52  0000 725f5300      	clr	21248
  53                     ; 55   TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  55  0004 725f5303      	clr	21251
  56                     ; 56   TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  58  0008 725f5305      	clr	21253
  59                     ; 59   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  61  000c 725f530a      	clr	21258
  62                     ; 60   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  64  0010 725f530b      	clr	21259
  65                     ; 64   TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  67  0014 725f530a      	clr	21258
  68                     ; 65   TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  70  0018 725f530b      	clr	21259
  71                     ; 66   TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  73  001c 725f5307      	clr	21255
  74                     ; 67   TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  76  0020 725f5308      	clr	21256
  77                     ; 68   TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  79  0024 725f5309      	clr	21257
  80                     ; 69   TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  82  0028 725f530c      	clr	21260
  83                     ; 70   TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  85  002c 725f530d      	clr	21261
  86                     ; 71   TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  88  0030 725f530e      	clr	21262
  89                     ; 72   TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  91  0034 35ff530f      	mov	21263,#255
  92                     ; 73   TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
  94  0038 35ff5310      	mov	21264,#255
  95                     ; 74   TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
  97  003c 725f5311      	clr	21265
  98                     ; 75   TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 100  0040 725f5312      	clr	21266
 101                     ; 76   TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 103  0044 725f5313      	clr	21267
 104                     ; 77   TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 106  0048 725f5314      	clr	21268
 107                     ; 78   TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 109  004c 725f5315      	clr	21269
 110                     ; 79   TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 112  0050 725f5316      	clr	21270
 113                     ; 80   TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 115  0054 725f5304      	clr	21252
 116                     ; 81 }
 119  0058 81            	ret
 287                     ; 89 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 287                     ; 90                         uint16_t TIM2_Period)
 287                     ; 91 {
 288                     	switch	.text
 289  0059               _TIM2_TimeBaseInit:
 291  0059 88            	push	a
 292       00000000      OFST:	set	0
 295                     ; 93   TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 297  005a c7530e        	ld	21262,a
 298                     ; 95   TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 300  005d 7b04          	ld	a,(OFST+4,sp)
 301  005f c7530f        	ld	21263,a
 302                     ; 96   TIM2->ARRL = (uint8_t)(TIM2_Period);
 304  0062 7b05          	ld	a,(OFST+5,sp)
 305  0064 c75310        	ld	21264,a
 306                     ; 97 }
 309  0067 84            	pop	a
 310  0068 81            	ret
 366                     ; 106 void TIM2_Cmd(FunctionalState NewState)
 366                     ; 107 {
 367                     	switch	.text
 368  0069               _TIM2_Cmd:
 370  0069 88            	push	a
 371       00000000      OFST:	set	0
 374                     ; 109   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 376  006a 4d            	tnz	a
 377  006b 2704          	jreq	L41
 378  006d a101          	cp	a,#1
 379  006f 2603          	jrne	L21
 380  0071               L41:
 381  0071 4f            	clr	a
 382  0072 2010          	jra	L61
 383  0074               L21:
 384  0074 ae006d        	ldw	x,#109
 385  0077 89            	pushw	x
 386  0078 ae0000        	ldw	x,#0
 387  007b 89            	pushw	x
 388  007c ae0000        	ldw	x,#L341
 389  007f cd0000        	call	_assert_failed
 391  0082 5b04          	addw	sp,#4
 392  0084               L61:
 393                     ; 112   if (NewState != DISABLE)
 395  0084 0d01          	tnz	(OFST+1,sp)
 396  0086 2706          	jreq	L541
 397                     ; 114     TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
 399  0088 72105300      	bset	21248,#0
 401  008c 2004          	jra	L741
 402  008e               L541:
 403                     ; 118     TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
 405  008e 72115300      	bres	21248,#0
 406  0092               L741:
 407                     ; 120 }
 410  0092 84            	pop	a
 411  0093 81            	ret
 491                     ; 135 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
 491                     ; 136 {
 492                     	switch	.text
 493  0094               _TIM2_ITConfig:
 495  0094 89            	pushw	x
 496       00000000      OFST:	set	0
 499                     ; 138   assert_param(IS_TIM2_IT_OK(TIM2_IT));
 501  0095 9e            	ld	a,xh
 502  0096 4d            	tnz	a
 503  0097 2708          	jreq	L22
 504  0099 9e            	ld	a,xh
 505  009a a110          	cp	a,#16
 506  009c 2403          	jruge	L22
 507  009e 4f            	clr	a
 508  009f 2010          	jra	L42
 509  00a1               L22:
 510  00a1 ae008a        	ldw	x,#138
 511  00a4 89            	pushw	x
 512  00a5 ae0000        	ldw	x,#0
 513  00a8 89            	pushw	x
 514  00a9 ae0000        	ldw	x,#L341
 515  00ac cd0000        	call	_assert_failed
 517  00af 5b04          	addw	sp,#4
 518  00b1               L42:
 519                     ; 139   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 521  00b1 0d02          	tnz	(OFST+2,sp)
 522  00b3 2706          	jreq	L03
 523  00b5 7b02          	ld	a,(OFST+2,sp)
 524  00b7 a101          	cp	a,#1
 525  00b9 2603          	jrne	L62
 526  00bb               L03:
 527  00bb 4f            	clr	a
 528  00bc 2010          	jra	L23
 529  00be               L62:
 530  00be ae008b        	ldw	x,#139
 531  00c1 89            	pushw	x
 532  00c2 ae0000        	ldw	x,#0
 533  00c5 89            	pushw	x
 534  00c6 ae0000        	ldw	x,#L341
 535  00c9 cd0000        	call	_assert_failed
 537  00cc 5b04          	addw	sp,#4
 538  00ce               L23:
 539                     ; 141   if (NewState != DISABLE)
 541  00ce 0d02          	tnz	(OFST+2,sp)
 542  00d0 270a          	jreq	L702
 543                     ; 144     TIM2->IER |= (uint8_t)TIM2_IT;
 545  00d2 c65303        	ld	a,21251
 546  00d5 1a01          	or	a,(OFST+1,sp)
 547  00d7 c75303        	ld	21251,a
 549  00da 2009          	jra	L112
 550  00dc               L702:
 551                     ; 149     TIM2->IER &= (uint8_t)(~TIM2_IT);
 553  00dc 7b01          	ld	a,(OFST+1,sp)
 554  00de 43            	cpl	a
 555  00df c45303        	and	a,21251
 556  00e2 c75303        	ld	21251,a
 557  00e5               L112:
 558                     ; 151 }
 561  00e5 85            	popw	x
 562  00e6 81            	ret
 631                     ; 181 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
 631                     ; 182                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
 631                     ; 183 {
 632                     	switch	.text
 633  00e7               _TIM2_PrescalerConfig:
 635  00e7 89            	pushw	x
 636       00000000      OFST:	set	0
 639                     ; 185   assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
 641  00e8 9f            	ld	a,xl
 642  00e9 4d            	tnz	a
 643  00ea 2705          	jreq	L04
 644  00ec 9f            	ld	a,xl
 645  00ed a101          	cp	a,#1
 646  00ef 2603          	jrne	L63
 647  00f1               L04:
 648  00f1 4f            	clr	a
 649  00f2 2010          	jra	L24
 650  00f4               L63:
 651  00f4 ae00b9        	ldw	x,#185
 652  00f7 89            	pushw	x
 653  00f8 ae0000        	ldw	x,#0
 654  00fb 89            	pushw	x
 655  00fc ae0000        	ldw	x,#L341
 656  00ff cd0000        	call	_assert_failed
 658  0102 5b04          	addw	sp,#4
 659  0104               L24:
 660                     ; 186   assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
 662  0104 0d01          	tnz	(OFST+1,sp)
 663  0106 275a          	jreq	L64
 664  0108 7b01          	ld	a,(OFST+1,sp)
 665  010a a101          	cp	a,#1
 666  010c 2754          	jreq	L64
 667  010e 7b01          	ld	a,(OFST+1,sp)
 668  0110 a102          	cp	a,#2
 669  0112 274e          	jreq	L64
 670  0114 7b01          	ld	a,(OFST+1,sp)
 671  0116 a103          	cp	a,#3
 672  0118 2748          	jreq	L64
 673  011a 7b01          	ld	a,(OFST+1,sp)
 674  011c a104          	cp	a,#4
 675  011e 2742          	jreq	L64
 676  0120 7b01          	ld	a,(OFST+1,sp)
 677  0122 a105          	cp	a,#5
 678  0124 273c          	jreq	L64
 679  0126 7b01          	ld	a,(OFST+1,sp)
 680  0128 a106          	cp	a,#6
 681  012a 2736          	jreq	L64
 682  012c 7b01          	ld	a,(OFST+1,sp)
 683  012e a107          	cp	a,#7
 684  0130 2730          	jreq	L64
 685  0132 7b01          	ld	a,(OFST+1,sp)
 686  0134 a108          	cp	a,#8
 687  0136 272a          	jreq	L64
 688  0138 7b01          	ld	a,(OFST+1,sp)
 689  013a a109          	cp	a,#9
 690  013c 2724          	jreq	L64
 691  013e 7b01          	ld	a,(OFST+1,sp)
 692  0140 a10a          	cp	a,#10
 693  0142 271e          	jreq	L64
 694  0144 7b01          	ld	a,(OFST+1,sp)
 695  0146 a10b          	cp	a,#11
 696  0148 2718          	jreq	L64
 697  014a 7b01          	ld	a,(OFST+1,sp)
 698  014c a10c          	cp	a,#12
 699  014e 2712          	jreq	L64
 700  0150 7b01          	ld	a,(OFST+1,sp)
 701  0152 a10d          	cp	a,#13
 702  0154 270c          	jreq	L64
 703  0156 7b01          	ld	a,(OFST+1,sp)
 704  0158 a10e          	cp	a,#14
 705  015a 2706          	jreq	L64
 706  015c 7b01          	ld	a,(OFST+1,sp)
 707  015e a10f          	cp	a,#15
 708  0160 2603          	jrne	L44
 709  0162               L64:
 710  0162 4f            	clr	a
 711  0163 2010          	jra	L05
 712  0165               L44:
 713  0165 ae00ba        	ldw	x,#186
 714  0168 89            	pushw	x
 715  0169 ae0000        	ldw	x,#0
 716  016c 89            	pushw	x
 717  016d ae0000        	ldw	x,#L341
 718  0170 cd0000        	call	_assert_failed
 720  0173 5b04          	addw	sp,#4
 721  0175               L05:
 722                     ; 189   TIM2->PSCR = (uint8_t)Prescaler;
 724  0175 7b01          	ld	a,(OFST+1,sp)
 725  0177 c7530e        	ld	21262,a
 726                     ; 192   TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
 728  017a 7b02          	ld	a,(OFST+2,sp)
 729  017c c75306        	ld	21254,a
 730                     ; 193 }
 733  017f 85            	popw	x
 734  0180 81            	ret
 808                     ; 205 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
 808                     ; 206 {
 809                     	switch	.text
 810  0181               _TIM2_GenerateEvent:
 812  0181 88            	push	a
 813       00000000      OFST:	set	0
 816                     ; 208   assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
 818  0182 4d            	tnz	a
 819  0183 2703          	jreq	L45
 820  0185 4f            	clr	a
 821  0186 2010          	jra	L65
 822  0188               L45:
 823  0188 ae00d0        	ldw	x,#208
 824  018b 89            	pushw	x
 825  018c ae0000        	ldw	x,#0
 826  018f 89            	pushw	x
 827  0190 ae0000        	ldw	x,#L341
 828  0193 cd0000        	call	_assert_failed
 830  0196 5b04          	addw	sp,#4
 831  0198               L65:
 832                     ; 211   TIM2->EGR = (uint8_t)TIM2_EventSource;
 834  0198 7b01          	ld	a,(OFST+1,sp)
 835  019a c75306        	ld	21254,a
 836                     ; 212 }
 839  019d 84            	pop	a
 840  019e 81            	ret
 980                     ; 227 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
 980                     ; 228 {
 981                     	switch	.text
 982  019f               _TIM2_GetFlagStatus:
 984  019f 89            	pushw	x
 985  01a0 89            	pushw	x
 986       00000002      OFST:	set	2
 989                     ; 229   FlagStatus bitstatus = RESET;
 991                     ; 230   uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
 995                     ; 233   assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
 997  01a1 a30001        	cpw	x,#1
 998  01a4 271e          	jreq	L46
 999  01a6 a30002        	cpw	x,#2
1000  01a9 2719          	jreq	L46
1001  01ab a30004        	cpw	x,#4
1002  01ae 2714          	jreq	L46
1003  01b0 a30008        	cpw	x,#8
1004  01b3 270f          	jreq	L46
1005  01b5 a30200        	cpw	x,#512
1006  01b8 270a          	jreq	L46
1007  01ba a30400        	cpw	x,#1024
1008  01bd 2705          	jreq	L46
1009  01bf a30800        	cpw	x,#2048
1010  01c2 2603          	jrne	L26
1011  01c4               L46:
1012  01c4 4f            	clr	a
1013  01c5 2010          	jra	L66
1014  01c7               L26:
1015  01c7 ae00e9        	ldw	x,#233
1016  01ca 89            	pushw	x
1017  01cb ae0000        	ldw	x,#0
1018  01ce 89            	pushw	x
1019  01cf ae0000        	ldw	x,#L341
1020  01d2 cd0000        	call	_assert_failed
1022  01d5 5b04          	addw	sp,#4
1023  01d7               L66:
1024                     ; 235   tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
1026  01d7 c65304        	ld	a,21252
1027  01da 1404          	and	a,(OFST+2,sp)
1028  01dc 6b01          	ld	(OFST-1,sp),a
1030                     ; 236   tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
1032  01de 7b03          	ld	a,(OFST+1,sp)
1033  01e0 6b02          	ld	(OFST+0,sp),a
1035                     ; 238   if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
1037  01e2 c65305        	ld	a,21253
1038  01e5 1402          	and	a,(OFST+0,sp)
1039  01e7 1a01          	or	a,(OFST-1,sp)
1040  01e9 2706          	jreq	L363
1041                     ; 240     bitstatus = SET;
1043  01eb a601          	ld	a,#1
1044  01ed 6b02          	ld	(OFST+0,sp),a
1047  01ef 2002          	jra	L563
1048  01f1               L363:
1049                     ; 244     bitstatus = RESET;
1051  01f1 0f02          	clr	(OFST+0,sp)
1053  01f3               L563:
1054                     ; 246   return (FlagStatus)bitstatus;
1056  01f3 7b02          	ld	a,(OFST+0,sp)
1059  01f5 5b04          	addw	sp,#4
1060  01f7 81            	ret
1096                     ; 262 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
1096                     ; 263 {
1097                     	switch	.text
1098  01f8               _TIM2_ClearFlag:
1100  01f8 89            	pushw	x
1101       00000000      OFST:	set	0
1104                     ; 265   assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
1106  01f9 01            	rrwa	x,a
1107  01fa a4f0          	and	a,#240
1108  01fc 01            	rrwa	x,a
1109  01fd a4f1          	and	a,#241
1110  01ff 01            	rrwa	x,a
1111  0200 a30000        	cpw	x,#0
1112  0203 2607          	jrne	L27
1113  0205 1e01          	ldw	x,(OFST+1,sp)
1114  0207 2703          	jreq	L27
1115  0209 4f            	clr	a
1116  020a 2010          	jra	L47
1117  020c               L27:
1118  020c ae0109        	ldw	x,#265
1119  020f 89            	pushw	x
1120  0210 ae0000        	ldw	x,#0
1121  0213 89            	pushw	x
1122  0214 ae0000        	ldw	x,#L341
1123  0217 cd0000        	call	_assert_failed
1125  021a 5b04          	addw	sp,#4
1126  021c               L47:
1127                     ; 268   TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
1129  021c 7b02          	ld	a,(OFST+2,sp)
1130  021e 43            	cpl	a
1131  021f c75304        	ld	21252,a
1132                     ; 269   TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
1134  0222 35ff5305      	mov	21253,#255
1135                     ; 270 }
1138  0226 85            	popw	x
1139  0227 81            	ret
1204                     ; 282 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
1204                     ; 283 {
1205                     	switch	.text
1206  0228               _TIM2_GetITStatus:
1208  0228 88            	push	a
1209  0229 89            	pushw	x
1210       00000002      OFST:	set	2
1213                     ; 284   ITStatus bitstatus = RESET;
1215                     ; 285   uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
1219                     ; 288   assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
1221  022a a101          	cp	a,#1
1222  022c 270c          	jreq	L201
1223  022e a102          	cp	a,#2
1224  0230 2708          	jreq	L201
1225  0232 a104          	cp	a,#4
1226  0234 2704          	jreq	L201
1227  0236 a108          	cp	a,#8
1228  0238 2603          	jrne	L001
1229  023a               L201:
1230  023a 4f            	clr	a
1231  023b 2010          	jra	L401
1232  023d               L001:
1233  023d ae0120        	ldw	x,#288
1234  0240 89            	pushw	x
1235  0241 ae0000        	ldw	x,#0
1236  0244 89            	pushw	x
1237  0245 ae0000        	ldw	x,#L341
1238  0248 cd0000        	call	_assert_failed
1240  024b 5b04          	addw	sp,#4
1241  024d               L401:
1242                     ; 290   TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
1244  024d c65304        	ld	a,21252
1245  0250 1403          	and	a,(OFST+1,sp)
1246  0252 6b01          	ld	(OFST-1,sp),a
1248                     ; 292   TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
1250  0254 c65303        	ld	a,21251
1251  0257 1403          	and	a,(OFST+1,sp)
1252  0259 6b02          	ld	(OFST+0,sp),a
1254                     ; 294   if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
1256  025b 0d01          	tnz	(OFST-1,sp)
1257  025d 270a          	jreq	L734
1259  025f 0d02          	tnz	(OFST+0,sp)
1260  0261 2706          	jreq	L734
1261                     ; 296     bitstatus = SET;
1263  0263 a601          	ld	a,#1
1264  0265 6b02          	ld	(OFST+0,sp),a
1267  0267 2002          	jra	L144
1268  0269               L734:
1269                     ; 300     bitstatus = RESET;
1271  0269 0f02          	clr	(OFST+0,sp)
1273  026b               L144:
1274                     ; 302   return (ITStatus)(bitstatus);
1276  026b 7b02          	ld	a,(OFST+0,sp)
1279  026d 5b03          	addw	sp,#3
1280  026f 81            	ret
1317                     ; 315 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
1317                     ; 316 {
1318                     	switch	.text
1319  0270               _TIM2_ClearITPendingBit:
1321  0270 88            	push	a
1322       00000000      OFST:	set	0
1325                     ; 318   assert_param(IS_TIM2_IT_OK(TIM2_IT));
1327  0271 4d            	tnz	a
1328  0272 2707          	jreq	L011
1329  0274 a110          	cp	a,#16
1330  0276 2403          	jruge	L011
1331  0278 4f            	clr	a
1332  0279 2010          	jra	L211
1333  027b               L011:
1334  027b ae013e        	ldw	x,#318
1335  027e 89            	pushw	x
1336  027f ae0000        	ldw	x,#0
1337  0282 89            	pushw	x
1338  0283 ae0000        	ldw	x,#L341
1339  0286 cd0000        	call	_assert_failed
1341  0289 5b04          	addw	sp,#4
1342  028b               L211:
1343                     ; 321   TIM2->SR1 = (uint8_t)(~TIM2_IT);
1345  028b 7b01          	ld	a,(OFST+1,sp)
1346  028d 43            	cpl	a
1347  028e c75304        	ld	21252,a
1348                     ; 322 }
1351  0291 84            	pop	a
1352  0292 81            	ret
1365                     	xdef	_TIM2_PrescalerConfig
1366                     	xdef	_TIM2_ClearITPendingBit
1367                     	xdef	_TIM2_GetITStatus
1368                     	xdef	_TIM2_ClearFlag
1369                     	xdef	_TIM2_GetFlagStatus
1370                     	xdef	_TIM2_GenerateEvent
1371                     	xdef	_TIM2_ITConfig
1372                     	xdef	_TIM2_Cmd
1373                     	xdef	_TIM2_TimeBaseInit
1374                     	xdef	_TIM2_DeInit
1375                     	xref	_assert_failed
1376                     .const:	section	.text
1377  0000               L341:
1378  0000 7372635c7374  	dc.b	"src\stm8s_tim2.c",0
1398                     	end
