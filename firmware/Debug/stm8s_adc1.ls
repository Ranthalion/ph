   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     ; 52 void ADC1_DeInit(void)
  19                     ; 53 {
  20                     	scross	off
  21  0000               _ADC1_DeInit:
  23                     ; 54   ADC1->CSR  = ADC1_CSR_RESET_VALUE;
  24  0000 725f5400      	clr	21504
  25                     ; 55   ADC1->CR1  = ADC1_CR1_RESET_VALUE;
  26  0004 725f5401      	clr	21505
  27                     ; 56   ADC1->CR2  = ADC1_CR2_RESET_VALUE;
  28  0008 725f5402      	clr	21506
  29                     ; 57   ADC1->CR3  = ADC1_CR3_RESET_VALUE;
  30  000c 725f5403      	clr	21507
  31                     ; 58   ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
  32  0010 725f5406      	clr	21510
  33                     ; 59   ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
  34  0014 725f5407      	clr	21511
  35                     ; 60   ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
  36  0018 35ff5408      	mov	21512,#255
  37                     ; 61   ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
  38  001c 35035409      	mov	21513,#3
  39                     ; 62   ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
  40  0020 725f540a      	clr	21514
  41                     ; 63   ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
  42  0024 725f540b      	clr	21515
  43                     ; 64   ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
  44  0028 725f540e      	clr	21518
  45                     ; 65   ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
  46  002c 725f540f      	clr	21519
  47                     ; 66 }
  48  0030 81            	ret	
  50                     ; 88 void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_PresSel_TypeDef ADC1_PrescalerSelection, ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState ADC1_SchmittTriggerState)
  50                     ; 89 {
  51  0031               _ADC1_Init:
  52  0031 89            	pushw	x
  53       00000000      OFST:	set	0
  55                     ; 91   assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
  56  0032 9e            	ld	a,xh
  57  0033 4d            	tnz	a
  58  0034 270a          	jreq	L21
  59  0036 9e            	ld	a,xh
  60  0037 4a            	dec	a
  61  0038 2706          	jreq	L21
  62  003a ae005b        	ldw	x,#91
  63  003d cd012a        	call	LC001
  64  0040               L21:
  65                     ; 92   assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
  66  0040 7b02          	ld	a,(OFST+2,sp)
  67  0042 272e          	jreq	L22
  68  0044 a101          	cp	a,#1
  69  0046 272a          	jreq	L22
  70  0048 a102          	cp	a,#2
  71  004a 2726          	jreq	L22
  72  004c a103          	cp	a,#3
  73  004e 2722          	jreq	L22
  74  0050 a104          	cp	a,#4
  75  0052 271e          	jreq	L22
  76  0054 a105          	cp	a,#5
  77  0056 271a          	jreq	L22
  78  0058 a106          	cp	a,#6
  79  005a 2716          	jreq	L22
  80  005c a107          	cp	a,#7
  81  005e 2712          	jreq	L22
  82  0060 a108          	cp	a,#8
  83  0062 270e          	jreq	L22
  84  0064 a10c          	cp	a,#12
  85  0066 270a          	jreq	L22
  86  0068 a109          	cp	a,#9
  87  006a 2706          	jreq	L22
  88  006c ae005c        	ldw	x,#92
  89  006f cd012a        	call	LC001
  90  0072               L22:
  91                     ; 93   assert_param(IS_ADC1_PRESSEL_OK(ADC1_PrescalerSelection));
  92  0072 7b05          	ld	a,(OFST+5,sp)
  93  0074 2722          	jreq	L23
  94  0076 a110          	cp	a,#16
  95  0078 271e          	jreq	L23
  96  007a a120          	cp	a,#32
  97  007c 271a          	jreq	L23
  98  007e a130          	cp	a,#48
  99  0080 2716          	jreq	L23
 100  0082 a140          	cp	a,#64
 101  0084 2712          	jreq	L23
 102  0086 a150          	cp	a,#80
 103  0088 270e          	jreq	L23
 104  008a a160          	cp	a,#96
 105  008c 270a          	jreq	L23
 106  008e a170          	cp	a,#112
 107  0090 2706          	jreq	L23
 108  0092 ae005d        	ldw	x,#93
 109  0095 cd012a        	call	LC001
 110  0098               L23:
 111                     ; 94   assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
 112  0098 7b06          	ld	a,(OFST+6,sp)
 113  009a 270a          	jreq	L24
 114  009c a110          	cp	a,#16
 115  009e 2706          	jreq	L24
 116  00a0 ae005e        	ldw	x,#94
 117  00a3 cd012a        	call	LC001
 118  00a6               L24:
 119                     ; 95   assert_param(IS_FUNCTIONALSTATE_OK(((ADC1_ExtTriggerState))));
 120  00a6 7b07          	ld	a,(OFST+7,sp)
 121  00a8 2708          	jreq	L25
 122  00aa 4a            	dec	a
 123  00ab 2705          	jreq	L25
 124  00ad ae005f        	ldw	x,#95
 125  00b0 ad78          	call	LC001
 126  00b2               L25:
 127                     ; 96   assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 128  00b2 7b08          	ld	a,(OFST+8,sp)
 129  00b4 2709          	jreq	L26
 130  00b6 a108          	cp	a,#8
 131  00b8 2705          	jreq	L26
 132  00ba ae0060        	ldw	x,#96
 133  00bd ad6b          	call	LC001
 134  00bf               L26:
 135                     ; 97   assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 136  00bf 7b09          	ld	a,(OFST+9,sp)
 137  00c1 2731          	jreq	L27
 138  00c3 a101          	cp	a,#1
 139  00c5 272d          	jreq	L27
 140  00c7 a102          	cp	a,#2
 141  00c9 2729          	jreq	L27
 142  00cb a103          	cp	a,#3
 143  00cd 2725          	jreq	L27
 144  00cf a104          	cp	a,#4
 145  00d1 2721          	jreq	L27
 146  00d3 a105          	cp	a,#5
 147  00d5 271d          	jreq	L27
 148  00d7 a106          	cp	a,#6
 149  00d9 2719          	jreq	L27
 150  00db a107          	cp	a,#7
 151  00dd 2715          	jreq	L27
 152  00df a108          	cp	a,#8
 153  00e1 2711          	jreq	L27
 154  00e3 a10c          	cp	a,#12
 155  00e5 270d          	jreq	L27
 156  00e7 a1ff          	cp	a,#255
 157  00e9 2709          	jreq	L27
 158  00eb a109          	cp	a,#9
 159  00ed 2705          	jreq	L27
 160  00ef ae0061        	ldw	x,#97
 161  00f2 ad36          	call	LC001
 162  00f4               L27:
 163                     ; 98   assert_param(IS_FUNCTIONALSTATE_OK(ADC1_SchmittTriggerState));
 164  00f4 7b0a          	ld	a,(OFST+10,sp)
 165  00f6 2708          	jreq	L201
 166  00f8 4a            	dec	a
 167  00f9 2705          	jreq	L201
 168  00fb ae0062        	ldw	x,#98
 169  00fe ad2a          	call	LC001
 170  0100               L201:
 171                     ; 103   ADC1_ConversionConfig(ADC1_ConversionMode, ADC1_Channel, ADC1_Align);
 172  0100 7b08          	ld	a,(OFST+8,sp)
 173  0102 88            	push	a
 174  0103 7b03          	ld	a,(OFST+3,sp)
 175  0105 97            	ld	xl,a
 176  0106 7b02          	ld	a,(OFST+2,sp)
 177  0108 95            	ld	xh,a
 178  0109 cd02ee        	call	_ADC1_ConversionConfig
 180  010c 84            	pop	a
 181                     ; 105   ADC1_PrescalerConfig(ADC1_PrescalerSelection);
 182  010d 7b05          	ld	a,(OFST+5,sp)
 183  010f cd01e3        	call	_ADC1_PrescalerConfig
 185                     ; 110   ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);
 186  0112 7b07          	ld	a,(OFST+7,sp)
 187  0114 97            	ld	xl,a
 188  0115 7b06          	ld	a,(OFST+6,sp)
 189  0117 95            	ld	xh,a
 190  0118 cd0373        	call	_ADC1_ExternalTriggerConfig
 192                     ; 115   ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);
 193  011b 7b0a          	ld	a,(OFST+10,sp)
 194  011d 97            	ld	xl,a
 195  011e 7b09          	ld	a,(OFST+9,sp)
 196  0120 95            	ld	xh,a
 197  0121 cd0223        	call	_ADC1_SchmittTriggerConfig
 199                     ; 118   ADC1->CR1 |= ADC1_CR1_ADON;
 200  0124 72105401      	bset	21505,#0
 201                     ; 119 }
 202  0128 85            	popw	x
 203  0129 81            	ret	
 204  012a               LC001:
 205  012a 89            	pushw	x
 206  012b 5f            	clrw	x
 207  012c 89            	pushw	x
 208  012d ae0000        	ldw	x,#L3
 209  0130 cd0000        	call	_assert_failed
 211  0133 5b04          	addw	sp,#4
 212  0135 81            	ret	
 214                     ; 126 void ADC1_Cmd(FunctionalState NewState)
 214                     ; 127 {
 215  0136               _ADC1_Cmd:
 216  0136 88            	push	a
 217       00000000      OFST:	set	0
 219                     ; 129   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 220  0137 4d            	tnz	a
 221  0138 2711          	jreq	L421
 222  013a 4a            	dec	a
 223  013b 270e          	jreq	L421
 224  013d ae0081        	ldw	x,#129
 225  0140 89            	pushw	x
 226  0141 5f            	clrw	x
 227  0142 89            	pushw	x
 228  0143 ae0000        	ldw	x,#L3
 229  0146 cd0000        	call	_assert_failed
 231  0149 5b04          	addw	sp,#4
 232  014b               L421:
 233                     ; 131   if (NewState != DISABLE)
 234  014b 7b01          	ld	a,(OFST+1,sp)
 235  014d 2706          	jreq	L5
 236                     ; 133     ADC1->CR1 |= ADC1_CR1_ADON;
 237  014f 72105401      	bset	21505,#0
 239  0153 2004          	jra	L7
 240  0155               L5:
 241                     ; 137     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_ADON);
 242  0155 72115401      	bres	21505,#0
 243  0159               L7:
 244                     ; 139 }
 245  0159 84            	pop	a
 246  015a 81            	ret	
 248                     ; 146 void ADC1_ScanModeCmd(FunctionalState NewState)
 248                     ; 147 {
 249  015b               _ADC1_ScanModeCmd:
 250  015b 88            	push	a
 251       00000000      OFST:	set	0
 253                     ; 149   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 254  015c 4d            	tnz	a
 255  015d 2711          	jreq	L631
 256  015f 4a            	dec	a
 257  0160 270e          	jreq	L631
 258  0162 ae0095        	ldw	x,#149
 259  0165 89            	pushw	x
 260  0166 5f            	clrw	x
 261  0167 89            	pushw	x
 262  0168 ae0000        	ldw	x,#L3
 263  016b cd0000        	call	_assert_failed
 265  016e 5b04          	addw	sp,#4
 266  0170               L631:
 267                     ; 151   if (NewState != DISABLE)
 268  0170 7b01          	ld	a,(OFST+1,sp)
 269  0172 2706          	jreq	L11
 270                     ; 153     ADC1->CR2 |= ADC1_CR2_SCAN;
 271  0174 72125402      	bset	21506,#1
 273  0178 2004          	jra	L31
 274  017a               L11:
 275                     ; 157     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_SCAN);
 276  017a 72135402      	bres	21506,#1
 277  017e               L31:
 278                     ; 159 }
 279  017e 84            	pop	a
 280  017f 81            	ret	
 282                     ; 166 void ADC1_DataBufferCmd(FunctionalState NewState)
 282                     ; 167 {
 283  0180               _ADC1_DataBufferCmd:
 284  0180 88            	push	a
 285       00000000      OFST:	set	0
 287                     ; 169   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 288  0181 4d            	tnz	a
 289  0182 2711          	jreq	L051
 290  0184 4a            	dec	a
 291  0185 270e          	jreq	L051
 292  0187 ae00a9        	ldw	x,#169
 293  018a 89            	pushw	x
 294  018b 5f            	clrw	x
 295  018c 89            	pushw	x
 296  018d ae0000        	ldw	x,#L3
 297  0190 cd0000        	call	_assert_failed
 299  0193 5b04          	addw	sp,#4
 300  0195               L051:
 301                     ; 171   if (NewState != DISABLE)
 302  0195 7b01          	ld	a,(OFST+1,sp)
 303  0197 2706          	jreq	L51
 304                     ; 173     ADC1->CR3 |= ADC1_CR3_DBUF;
 305  0199 721e5403      	bset	21507,#7
 307  019d 2004          	jra	L71
 308  019f               L51:
 309                     ; 177     ADC1->CR3 &= (uint8_t)(~ADC1_CR3_DBUF);
 310  019f 721f5403      	bres	21507,#7
 311  01a3               L71:
 312                     ; 179 }
 313  01a3 84            	pop	a
 314  01a4 81            	ret	
 316                     ; 190 void ADC1_ITConfig(ADC1_IT_TypeDef ADC1_IT, FunctionalState NewState)
 316                     ; 191 {
 317  01a5               _ADC1_ITConfig:
 318  01a5 89            	pushw	x
 319       00000000      OFST:	set	0
 321                     ; 193   assert_param(IS_ADC1_IT_OK(ADC1_IT));
 322  01a6 a30020        	cpw	x,#32
 323  01a9 270a          	jreq	L261
 324  01ab a30010        	cpw	x,#16
 325  01ae 2705          	jreq	L261
 326  01b0 ae00c1        	ldw	x,#193
 327  01b3 ad22          	call	LC002
 328  01b5               L261:
 329                     ; 194   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 330  01b5 7b05          	ld	a,(OFST+5,sp)
 331  01b7 2708          	jreq	L271
 332  01b9 4a            	dec	a
 333  01ba 2705          	jreq	L271
 334  01bc ae00c2        	ldw	x,#194
 335  01bf ad16          	call	LC002
 336  01c1               L271:
 337                     ; 196   if (NewState != DISABLE)
 338  01c1 7b05          	ld	a,(OFST+5,sp)
 339  01c3 2707          	jreq	L12
 340                     ; 199     ADC1->CSR |= (uint8_t)ADC1_IT;
 341  01c5 c65400        	ld	a,21504
 342  01c8 1a02          	or	a,(OFST+2,sp)
 344  01ca 2006          	jra	L32
 345  01cc               L12:
 346                     ; 204     ADC1->CSR &= (uint8_t)((uint16_t)~(uint16_t)ADC1_IT);
 347  01cc 7b02          	ld	a,(OFST+2,sp)
 348  01ce 43            	cpl	a
 349  01cf c45400        	and	a,21504
 350  01d2               L32:
 351  01d2 c75400        	ld	21504,a
 352                     ; 206 }
 353  01d5 85            	popw	x
 354  01d6 81            	ret	
 355  01d7               LC002:
 356  01d7 89            	pushw	x
 357  01d8 5f            	clrw	x
 358  01d9 89            	pushw	x
 359  01da ae0000        	ldw	x,#L3
 360  01dd cd0000        	call	_assert_failed
 362  01e0 5b04          	addw	sp,#4
 363  01e2 81            	ret	
 365                     ; 214 void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
 365                     ; 215 {
 366  01e3               _ADC1_PrescalerConfig:
 367  01e3 88            	push	a
 368       00000000      OFST:	set	0
 370                     ; 217   assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));
 371  01e4 4d            	tnz	a
 372  01e5 272a          	jreq	L402
 373  01e7 a110          	cp	a,#16
 374  01e9 2726          	jreq	L402
 375  01eb a120          	cp	a,#32
 376  01ed 2722          	jreq	L402
 377  01ef a130          	cp	a,#48
 378  01f1 271e          	jreq	L402
 379  01f3 a140          	cp	a,#64
 380  01f5 271a          	jreq	L402
 381  01f7 a150          	cp	a,#80
 382  01f9 2716          	jreq	L402
 383  01fb a160          	cp	a,#96
 384  01fd 2712          	jreq	L402
 385  01ff a170          	cp	a,#112
 386  0201 270e          	jreq	L402
 387  0203 ae00d9        	ldw	x,#217
 388  0206 89            	pushw	x
 389  0207 5f            	clrw	x
 390  0208 89            	pushw	x
 391  0209 ae0000        	ldw	x,#L3
 392  020c cd0000        	call	_assert_failed
 394  020f 5b04          	addw	sp,#4
 395  0211               L402:
 396                     ; 220   ADC1->CR1 &= (uint8_t)(~ADC1_CR1_SPSEL);
 397  0211 c65401        	ld	a,21505
 398  0214 a48f          	and	a,#143
 399  0216 c75401        	ld	21505,a
 400                     ; 222   ADC1->CR1 |= (uint8_t)(ADC1_Prescaler);
 401  0219 c65401        	ld	a,21505
 402  021c 1a01          	or	a,(OFST+1,sp)
 403  021e c75401        	ld	21505,a
 404                     ; 223 }
 405  0221 84            	pop	a
 406  0222 81            	ret	
 408                     ; 233 void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
 408                     ; 234 {
 409  0223               _ADC1_SchmittTriggerConfig:
 410  0223 89            	pushw	x
 411       00000000      OFST:	set	0
 413                     ; 236   assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 414  0224 9e            	ld	a,xh
 415  0225 4d            	tnz	a
 416  0226 273b          	jreq	L612
 417  0228 9e            	ld	a,xh
 418  0229 4a            	dec	a
 419  022a 2737          	jreq	L612
 420  022c 9e            	ld	a,xh
 421  022d a102          	cp	a,#2
 422  022f 2732          	jreq	L612
 423  0231 9e            	ld	a,xh
 424  0232 a103          	cp	a,#3
 425  0234 272d          	jreq	L612
 426  0236 9e            	ld	a,xh
 427  0237 a104          	cp	a,#4
 428  0239 2728          	jreq	L612
 429  023b 9e            	ld	a,xh
 430  023c a105          	cp	a,#5
 431  023e 2723          	jreq	L612
 432  0240 9e            	ld	a,xh
 433  0241 a106          	cp	a,#6
 434  0243 271e          	jreq	L612
 435  0245 9e            	ld	a,xh
 436  0246 a107          	cp	a,#7
 437  0248 2719          	jreq	L612
 438  024a 9e            	ld	a,xh
 439  024b a108          	cp	a,#8
 440  024d 2714          	jreq	L612
 441  024f 9e            	ld	a,xh
 442  0250 a10c          	cp	a,#12
 443  0252 270f          	jreq	L612
 444  0254 9e            	ld	a,xh
 445  0255 4c            	inc	a
 446  0256 270b          	jreq	L612
 447  0258 9e            	ld	a,xh
 448  0259 a109          	cp	a,#9
 449  025b 2706          	jreq	L612
 450  025d ae00ec        	ldw	x,#236
 451  0260 cd02e2        	call	LC006
 452  0263               L612:
 453                     ; 237   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 454  0263 7b02          	ld	a,(OFST+2,sp)
 455  0265 2708          	jreq	L622
 456  0267 4a            	dec	a
 457  0268 2705          	jreq	L622
 458  026a ae00ed        	ldw	x,#237
 459  026d ad73          	call	LC006
 460  026f               L622:
 461                     ; 239   if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
 462  026f 7b01          	ld	a,(OFST+1,sp)
 463  0271 a1ff          	cp	a,#255
 464  0273 261d          	jrne	L52
 465                     ; 241     if (NewState != DISABLE)
 466  0275 7b02          	ld	a,(OFST+2,sp)
 467  0277 270a          	jreq	L72
 468                     ; 243       ADC1->TDRL &= (uint8_t)0x0;
 469  0279 725f5407      	clr	21511
 470                     ; 244       ADC1->TDRH &= (uint8_t)0x0;
 471  027d 725f5406      	clr	21510
 473  0281 2057          	jra	L33
 474  0283               L72:
 475                     ; 248       ADC1->TDRL |= (uint8_t)0xFF;
 476  0283 c65407        	ld	a,21511
 477  0286 aaff          	or	a,#255
 478  0288 c75407        	ld	21511,a
 479                     ; 249       ADC1->TDRH |= (uint8_t)0xFF;
 480  028b c65406        	ld	a,21510
 481  028e aaff          	or	a,#255
 482  0290 2045          	jp	LC003
 483  0292               L52:
 484                     ; 252   else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
 485  0292 a108          	cp	a,#8
 486  0294 0d02          	tnz	(OFST+2,sp)
 487  0296 2420          	jruge	L53
 488                     ; 254     if (NewState != DISABLE)
 489  0298 2711          	jreq	L73
 490                     ; 256       ADC1->TDRL &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel));
 491  029a ad40          	call	LC005
 492  029c 2704          	jreq	L232
 493  029e               L432:
 494  029e 48            	sll	a
 495  029f 5a            	decw	x
 496  02a0 26fc          	jrne	L432
 497  02a2               L232:
 498  02a2 43            	cpl	a
 499  02a3 c45407        	and	a,21511
 500  02a6               LC004:
 501  02a6 c75407        	ld	21511,a
 503  02a9 202f          	jra	L33
 504  02ab               L73:
 505                     ; 260       ADC1->TDRL |= (uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel);
 506  02ab ad2f          	call	LC005
 507  02ad 2704          	jreq	L632
 508  02af               L042:
 509  02af 48            	sll	a
 510  02b0 5a            	decw	x
 511  02b1 26fc          	jrne	L042
 512  02b3               L632:
 513  02b3 ca5407        	or	a,21511
 514  02b6 20ee          	jp	LC004
 515  02b8               L53:
 516                     ; 265     if (NewState != DISABLE)
 517  02b8 2710          	jreq	L54
 518                     ; 267       ADC1->TDRH &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8)));
 519  02ba a008          	sub	a,#8
 520  02bc ad1e          	call	LC005
 521  02be 2704          	jreq	L242
 522  02c0               L442:
 523  02c0 48            	sll	a
 524  02c1 5a            	decw	x
 525  02c2 26fc          	jrne	L442
 526  02c4               L242:
 527  02c4 43            	cpl	a
 528  02c5 c45406        	and	a,21510
 530  02c8 200d          	jp	LC003
 531  02ca               L54:
 532                     ; 271       ADC1->TDRH |= (uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8));
 533  02ca a008          	sub	a,#8
 534  02cc ad0e          	call	LC005
 535  02ce 2704          	jreq	L642
 536  02d0               L052:
 537  02d0 48            	sll	a
 538  02d1 5a            	decw	x
 539  02d2 26fc          	jrne	L052
 540  02d4               L642:
 541  02d4 ca5406        	or	a,21510
 542  02d7               LC003:
 543  02d7 c75406        	ld	21510,a
 544  02da               L33:
 545                     ; 274 }
 546  02da 85            	popw	x
 547  02db 81            	ret	
 548  02dc               LC005:
 549  02dc 5f            	clrw	x
 550  02dd 97            	ld	xl,a
 551  02de a601          	ld	a,#1
 552  02e0 5d            	tnzw	x
 553  02e1 81            	ret	
 554  02e2               LC006:
 555  02e2 89            	pushw	x
 556  02e3 5f            	clrw	x
 557  02e4 89            	pushw	x
 558  02e5 ae0000        	ldw	x,#L3
 559  02e8 cd0000        	call	_assert_failed
 561  02eb 5b04          	addw	sp,#4
 562  02ed 81            	ret	
 564                     ; 286 void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
 564                     ; 287 {
 565  02ee               _ADC1_ConversionConfig:
 566  02ee 89            	pushw	x
 567       00000000      OFST:	set	0
 569                     ; 289   assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
 570  02ef 9e            	ld	a,xh
 571  02f0 4d            	tnz	a
 572  02f1 2709          	jreq	L062
 573  02f3 9e            	ld	a,xh
 574  02f4 4a            	dec	a
 575  02f5 2705          	jreq	L062
 576  02f7 ae0121        	ldw	x,#289
 577  02fa ad6b          	call	LC007
 578  02fc               L062:
 579                     ; 290   assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
 580  02fc 7b02          	ld	a,(OFST+2,sp)
 581  02fe 272d          	jreq	L072
 582  0300 a101          	cp	a,#1
 583  0302 2729          	jreq	L072
 584  0304 a102          	cp	a,#2
 585  0306 2725          	jreq	L072
 586  0308 a103          	cp	a,#3
 587  030a 2721          	jreq	L072
 588  030c a104          	cp	a,#4
 589  030e 271d          	jreq	L072
 590  0310 a105          	cp	a,#5
 591  0312 2719          	jreq	L072
 592  0314 a106          	cp	a,#6
 593  0316 2715          	jreq	L072
 594  0318 a107          	cp	a,#7
 595  031a 2711          	jreq	L072
 596  031c a108          	cp	a,#8
 597  031e 270d          	jreq	L072
 598  0320 a10c          	cp	a,#12
 599  0322 2709          	jreq	L072
 600  0324 a109          	cp	a,#9
 601  0326 2705          	jreq	L072
 602  0328 ae0122        	ldw	x,#290
 603  032b ad3a          	call	LC007
 604  032d               L072:
 605                     ; 291   assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 606  032d 7b05          	ld	a,(OFST+5,sp)
 607  032f 2709          	jreq	L003
 608  0331 a108          	cp	a,#8
 609  0333 2705          	jreq	L003
 610  0335 ae0123        	ldw	x,#291
 611  0338 ad2d          	call	LC007
 612  033a               L003:
 613                     ; 294   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_ALIGN);
 614  033a 72175402      	bres	21506,#3
 615                     ; 296   ADC1->CR2 |= (uint8_t)(ADC1_Align);
 616  033e c65402        	ld	a,21506
 617  0341 1a05          	or	a,(OFST+5,sp)
 618  0343 c75402        	ld	21506,a
 619                     ; 298   if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
 620  0346 7b01          	ld	a,(OFST+1,sp)
 621  0348 4a            	dec	a
 622  0349 2606          	jrne	L15
 623                     ; 301     ADC1->CR1 |= ADC1_CR1_CONT;
 624  034b 72125401      	bset	21505,#1
 626  034f 2004          	jra	L35
 627  0351               L15:
 628                     ; 306     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_CONT);
 629  0351 72135401      	bres	21505,#1
 630  0355               L35:
 631                     ; 310   ADC1->CSR &= (uint8_t)(~ADC1_CSR_CH);
 632  0355 c65400        	ld	a,21504
 633  0358 a4f0          	and	a,#240
 634  035a c75400        	ld	21504,a
 635                     ; 312   ADC1->CSR |= (uint8_t)(ADC1_Channel);
 636  035d c65400        	ld	a,21504
 637  0360 1a02          	or	a,(OFST+2,sp)
 638  0362 c75400        	ld	21504,a
 639                     ; 313 }
 640  0365 85            	popw	x
 641  0366 81            	ret	
 642  0367               LC007:
 643  0367 89            	pushw	x
 644  0368 5f            	clrw	x
 645  0369 89            	pushw	x
 646  036a ae0000        	ldw	x,#L3
 647  036d cd0000        	call	_assert_failed
 649  0370 5b04          	addw	sp,#4
 650  0372 81            	ret	
 652                     ; 325 void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
 652                     ; 326 {
 653  0373               _ADC1_ExternalTriggerConfig:
 654  0373 89            	pushw	x
 655       00000000      OFST:	set	0
 657                     ; 328   assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
 658  0374 9e            	ld	a,xh
 659  0375 4d            	tnz	a
 660  0376 270a          	jreq	L213
 661  0378 9e            	ld	a,xh
 662  0379 a110          	cp	a,#16
 663  037b 2705          	jreq	L213
 664  037d ae0148        	ldw	x,#328
 665  0380 ad2c          	call	LC008
 666  0382               L213:
 667                     ; 329   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 668  0382 7b02          	ld	a,(OFST+2,sp)
 669  0384 2708          	jreq	L223
 670  0386 4a            	dec	a
 671  0387 2705          	jreq	L223
 672  0389 ae0149        	ldw	x,#329
 673  038c ad20          	call	LC008
 674  038e               L223:
 675                     ; 332   ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTSEL);
 676  038e c65402        	ld	a,21506
 677  0391 a4cf          	and	a,#207
 678  0393 c75402        	ld	21506,a
 679                     ; 334   if (NewState != DISABLE)
 680  0396 7b02          	ld	a,(OFST+2,sp)
 681  0398 2706          	jreq	L55
 682                     ; 337     ADC1->CR2 |= (uint8_t)(ADC1_CR2_EXTTRIG);
 683  039a 721c5402      	bset	21506,#6
 685  039e 2004          	jra	L75
 686  03a0               L55:
 687                     ; 342     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTTRIG);
 688  03a0 721d5402      	bres	21506,#6
 689  03a4               L75:
 690                     ; 346   ADC1->CR2 |= (uint8_t)(ADC1_ExtTrigger);
 691  03a4 c65402        	ld	a,21506
 692  03a7 1a01          	or	a,(OFST+1,sp)
 693  03a9 c75402        	ld	21506,a
 694                     ; 347 }
 695  03ac 85            	popw	x
 696  03ad 81            	ret	
 697  03ae               LC008:
 698  03ae 89            	pushw	x
 699  03af 5f            	clrw	x
 700  03b0 89            	pushw	x
 701  03b1 ae0000        	ldw	x,#L3
 702  03b4 cd0000        	call	_assert_failed
 704  03b7 5b04          	addw	sp,#4
 705  03b9 81            	ret	
 707                     ; 358 void ADC1_StartConversion(void)
 707                     ; 359 {
 708  03ba               _ADC1_StartConversion:
 710                     ; 360   ADC1->CR1 |= ADC1_CR1_ADON;
 711  03ba 72105401      	bset	21505,#0
 712                     ; 361 }
 713  03be 81            	ret	
 715                     ; 370 uint16_t ADC1_GetConversionValue(void)
 715                     ; 371 {
 716  03bf               _ADC1_GetConversionValue:
 717  03bf 5205          	subw	sp,#5
 718       00000005      OFST:	set	5
 720                     ; 372   uint16_t temph = 0;
 721                     ; 373   uint8_t templ = 0;
 722                     ; 375   if ((ADC1->CR2 & ADC1_CR2_ALIGN) != 0) /* Right alignment */
 723  03c1 720754020e    	btjf	21506,#3,L16
 724                     ; 378     templ = ADC1->DRL;
 725  03c6 c65405        	ld	a,21509
 726  03c9 6b03          	ld	(OFST-2,sp),a
 727                     ; 380     temph = ADC1->DRH;
 728  03cb c65404        	ld	a,21508
 729  03ce 97            	ld	xl,a
 730                     ; 382     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
 731  03cf 7b03          	ld	a,(OFST-2,sp)
 732  03d1 02            	rlwa	x,a
 734  03d2 201a          	jra	L36
 735  03d4               L16:
 736                     ; 387     temph = ADC1->DRH;
 737  03d4 c65404        	ld	a,21508
 738  03d7 97            	ld	xl,a
 739                     ; 389     templ = ADC1->DRL;
 740  03d8 c65405        	ld	a,21509
 741  03db 6b03          	ld	(OFST-2,sp),a
 742                     ; 391     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)((uint16_t)temph << 8));
 743  03dd 4f            	clr	a
 744  03de 02            	rlwa	x,a
 745  03df 1f01          	ldw	(OFST-4,sp),x
 746  03e1 7b03          	ld	a,(OFST-2,sp)
 747  03e3 97            	ld	xl,a
 748  03e4 a640          	ld	a,#64
 749  03e6 42            	mul	x,a
 750  03e7 01            	rrwa	x,a
 751  03e8 1a02          	or	a,(OFST-3,sp)
 752  03ea 01            	rrwa	x,a
 753  03eb 1a01          	or	a,(OFST-4,sp)
 754  03ed 01            	rrwa	x,a
 755  03ee               L36:
 756                     ; 394   return ((uint16_t)temph);
 758  03ee 5b05          	addw	sp,#5
 759  03f0 81            	ret	
 761                     ; 405 void ADC1_AWDChannelConfig(ADC1_Channel_TypeDef Channel, FunctionalState NewState)
 761                     ; 406 {
 762  03f1               _ADC1_AWDChannelConfig:
 763  03f1 89            	pushw	x
 764       00000000      OFST:	set	0
 766                     ; 408   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 767  03f2 9f            	ld	a,xl
 768  03f3 4d            	tnz	a
 769  03f4 270a          	jreq	L043
 770  03f6 9f            	ld	a,xl
 771  03f7 4a            	dec	a
 772  03f8 2706          	jreq	L043
 773  03fa ae0198        	ldw	x,#408
 774  03fd cd0483        	call	LC012
 775  0400               L043:
 776                     ; 409   assert_param(IS_ADC1_CHANNEL_OK(Channel));
 777  0400 7b01          	ld	a,(OFST+1,sp)
 778  0402 272f          	jreq	L053
 779  0404 a101          	cp	a,#1
 780  0406 272b          	jreq	L053
 781  0408 a102          	cp	a,#2
 782  040a 2727          	jreq	L053
 783  040c a103          	cp	a,#3
 784  040e 2723          	jreq	L053
 785  0410 a104          	cp	a,#4
 786  0412 271f          	jreq	L053
 787  0414 a105          	cp	a,#5
 788  0416 271b          	jreq	L053
 789  0418 a106          	cp	a,#6
 790  041a 2717          	jreq	L053
 791  041c a107          	cp	a,#7
 792  041e 2713          	jreq	L053
 793  0420 a108          	cp	a,#8
 794  0422 270f          	jreq	L053
 795  0424 a10c          	cp	a,#12
 796  0426 270b          	jreq	L053
 797  0428 a109          	cp	a,#9
 798  042a 2707          	jreq	L053
 799  042c ae0199        	ldw	x,#409
 800  042f ad52          	call	LC012
 801  0431 7b01          	ld	a,(OFST+1,sp)
 802  0433               L053:
 803                     ; 411   if (Channel < (uint8_t)8)
 804  0433 a108          	cp	a,#8
 805  0435 0d02          	tnz	(OFST+2,sp)
 806  0437 2420          	jruge	L56
 807                     ; 413     if (NewState != DISABLE)
 808  0439 270d          	jreq	L76
 809                     ; 415       ADC1->AWCRL |= (uint8_t)((uint8_t)1 << Channel);
 810  043b ad40          	call	LC011
 811  043d 2704          	jreq	L453
 812  043f               L653:
 813  043f 48            	sll	a
 814  0440 5a            	decw	x
 815  0441 26fc          	jrne	L653
 816  0443               L453:
 817  0443 ca540f        	or	a,21519
 819  0446 200c          	jp	LC010
 820  0448               L76:
 821                     ; 419       ADC1->AWCRL &= (uint8_t)~(uint8_t)((uint8_t)1 << Channel);
 822  0448 ad33          	call	LC011
 823  044a 2704          	jreq	L063
 824  044c               L263:
 825  044c 48            	sll	a
 826  044d 5a            	decw	x
 827  044e 26fc          	jrne	L263
 828  0450               L063:
 829  0450 43            	cpl	a
 830  0451 c4540f        	and	a,21519
 831  0454               LC010:
 832  0454 c7540f        	ld	21519,a
 833  0457 2022          	jra	L37
 834  0459               L56:
 835                     ; 424     if (NewState != DISABLE)
 836  0459 270f          	jreq	L57
 837                     ; 426       ADC1->AWCRH |= (uint8_t)((uint8_t)1 << (Channel - (uint8_t)8));
 838  045b a008          	sub	a,#8
 839  045d ad1e          	call	LC011
 840  045f 2704          	jreq	L463
 841  0461               L663:
 842  0461 48            	sll	a
 843  0462 5a            	decw	x
 844  0463 26fc          	jrne	L663
 845  0465               L463:
 846  0465 ca540e        	or	a,21518
 848  0468 200e          	jp	LC009
 849  046a               L57:
 850                     ; 430       ADC1->AWCRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (uint8_t)(Channel - (uint8_t)8));
 851  046a a008          	sub	a,#8
 852  046c ad0f          	call	LC011
 853  046e 2704          	jreq	L073
 854  0470               L273:
 855  0470 48            	sll	a
 856  0471 5a            	decw	x
 857  0472 26fc          	jrne	L273
 858  0474               L073:
 859  0474 43            	cpl	a
 860  0475 c4540e        	and	a,21518
 861  0478               LC009:
 862  0478 c7540e        	ld	21518,a
 863  047b               L37:
 864                     ; 433 }
 865  047b 85            	popw	x
 866  047c 81            	ret	
 867  047d               LC011:
 868  047d 5f            	clrw	x
 869  047e 97            	ld	xl,a
 870  047f a601          	ld	a,#1
 871  0481 5d            	tnzw	x
 872  0482 81            	ret	
 873  0483               LC012:
 874  0483 89            	pushw	x
 875  0484 5f            	clrw	x
 876  0485 89            	pushw	x
 877  0486 ae0000        	ldw	x,#L3
 878  0489 cd0000        	call	_assert_failed
 880  048c 5b04          	addw	sp,#4
 881  048e 81            	ret	
 883                     ; 441 void ADC1_SetHighThreshold(uint16_t Threshold)
 883                     ; 442 {
 884  048f               _ADC1_SetHighThreshold:
 885  048f 89            	pushw	x
 886       00000000      OFST:	set	0
 888                     ; 443   ADC1->HTRH = (uint8_t)(Threshold >> (uint8_t)2);
 889  0490 54            	srlw	x
 890  0491 54            	srlw	x
 891  0492 9f            	ld	a,xl
 892  0493 c75408        	ld	21512,a
 893                     ; 444   ADC1->HTRL = (uint8_t)Threshold;
 894  0496 7b02          	ld	a,(OFST+2,sp)
 895  0498 c75409        	ld	21513,a
 896                     ; 445 }
 897  049b 85            	popw	x
 898  049c 81            	ret	
 900                     ; 453 void ADC1_SetLowThreshold(uint16_t Threshold)
 900                     ; 454 {
 901  049d               _ADC1_SetLowThreshold:
 903                     ; 455   ADC1->LTRL = (uint8_t)Threshold;
 904  049d 9f            	ld	a,xl
 905  049e c7540b        	ld	21515,a
 906                     ; 456   ADC1->LTRH = (uint8_t)(Threshold >> (uint8_t)2);
 907  04a1 54            	srlw	x
 908  04a2 54            	srlw	x
 909  04a3 9f            	ld	a,xl
 910  04a4 c7540a        	ld	21514,a
 911                     ; 457 }
 912  04a7 81            	ret	
 914                     ; 466 uint16_t ADC1_GetBufferValue(uint8_t Buffer)
 914                     ; 467 {
 915  04a8               _ADC1_GetBufferValue:
 916  04a8 88            	push	a
 917  04a9 5205          	subw	sp,#5
 918       00000005      OFST:	set	5
 920                     ; 468   uint16_t temph = 0;
 921                     ; 469   uint8_t templ = 0;
 922                     ; 472   assert_param(IS_ADC1_BUFFER_OK(Buffer));
 923  04ab a10a          	cp	a,#10
 924  04ad 250e          	jrult	L404
 925  04af ae01d8        	ldw	x,#472
 926  04b2 89            	pushw	x
 927  04b3 5f            	clrw	x
 928  04b4 89            	pushw	x
 929  04b5 ae0000        	ldw	x,#L3
 930  04b8 cd0000        	call	_assert_failed
 932  04bb 5b04          	addw	sp,#4
 933  04bd               L404:
 934                     ; 474   if ((ADC1->CR2 & ADC1_CR2_ALIGN) != 0) /* Right alignment */
 935  04bd 7b06          	ld	a,(OFST+1,sp)
 936  04bf 48            	sll	a
 937  04c0 5f            	clrw	x
 938  04c1 97            	ld	xl,a
 939  04c2 7207540213    	btjf	21506,#3,L101
 940                     ; 477     templ = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1) + 1);
 941  04c7 d653e1        	ld	a,(21473,x)
 942  04ca 6b03          	ld	(OFST-2,sp),a
 943                     ; 479     temph = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1));
 944  04cc 7b06          	ld	a,(OFST+1,sp)
 945  04ce 48            	sll	a
 946  04cf 5f            	clrw	x
 947  04d0 97            	ld	xl,a
 948  04d1 d653e0        	ld	a,(21472,x)
 949  04d4 97            	ld	xl,a
 950                     ; 481     temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
 951  04d5 7b03          	ld	a,(OFST-2,sp)
 952  04d7 02            	rlwa	x,a
 954  04d8 2024          	jra	L301
 955  04da               L101:
 956                     ; 486     temph = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1));
 957  04da d653e0        	ld	a,(21472,x)
 958  04dd 5f            	clrw	x
 959  04de 97            	ld	xl,a
 960  04df 1f04          	ldw	(OFST-1,sp),x
 961                     ; 488     templ = *(uint8_t*)(uint16_t)((uint16_t)ADC1_BaseAddress + (uint8_t)(Buffer << 1) + 1);
 962  04e1 7b06          	ld	a,(OFST+1,sp)
 963  04e3 48            	sll	a
 964  04e4 5f            	clrw	x
 965  04e5 97            	ld	xl,a
 966  04e6 d653e1        	ld	a,(21473,x)
 967  04e9 6b03          	ld	(OFST-2,sp),a
 968                     ; 490     temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)(temph << 8));
 969  04eb 4f            	clr	a
 970  04ec 1e04          	ldw	x,(OFST-1,sp)
 971  04ee 02            	rlwa	x,a
 972  04ef 1f01          	ldw	(OFST-4,sp),x
 973  04f1 7b03          	ld	a,(OFST-2,sp)
 974  04f3 97            	ld	xl,a
 975  04f4 a640          	ld	a,#64
 976  04f6 42            	mul	x,a
 977  04f7 01            	rrwa	x,a
 978  04f8 1a02          	or	a,(OFST-3,sp)
 979  04fa 01            	rrwa	x,a
 980  04fb 1a01          	or	a,(OFST-4,sp)
 981  04fd 01            	rrwa	x,a
 982  04fe               L301:
 983                     ; 493   return ((uint16_t)temph);
 985  04fe 5b06          	addw	sp,#6
 986  0500 81            	ret	
 988                     ; 502 FlagStatus ADC1_GetAWDChannelStatus(ADC1_Channel_TypeDef Channel)
 988                     ; 503 {
 989  0501               _ADC1_GetAWDChannelStatus:
 990  0501 88            	push	a
 991  0502 88            	push	a
 992       00000001      OFST:	set	1
 994                     ; 504   uint8_t status = 0;
 995                     ; 507   assert_param(IS_ADC1_CHANNEL_OK(Channel));
 996  0503 4d            	tnz	a
 997  0504 2736          	jreq	L614
 998  0506 a101          	cp	a,#1
 999  0508 2732          	jreq	L614
1000  050a a102          	cp	a,#2
1001  050c 272e          	jreq	L614
1002  050e a103          	cp	a,#3
1003  0510 272a          	jreq	L614
1004  0512 a104          	cp	a,#4
1005  0514 2726          	jreq	L614
1006  0516 a105          	cp	a,#5
1007  0518 2722          	jreq	L614
1008  051a a106          	cp	a,#6
1009  051c 271e          	jreq	L614
1010  051e a107          	cp	a,#7
1011  0520 271a          	jreq	L614
1012  0522 a108          	cp	a,#8
1013  0524 2716          	jreq	L614
1014  0526 a10c          	cp	a,#12
1015  0528 2712          	jreq	L614
1016  052a a109          	cp	a,#9
1017  052c 270e          	jreq	L614
1018  052e ae01fb        	ldw	x,#507
1019  0531 89            	pushw	x
1020  0532 5f            	clrw	x
1021  0533 89            	pushw	x
1022  0534 ae0000        	ldw	x,#L3
1023  0537 cd0000        	call	_assert_failed
1025  053a 5b04          	addw	sp,#4
1026  053c               L614:
1027                     ; 509   if (Channel < (uint8_t)8)
1028  053c 7b02          	ld	a,(OFST+1,sp)
1029  053e a108          	cp	a,#8
1030  0540 2410          	jruge	L501
1031                     ; 511     status = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << Channel));
1032  0542 5f            	clrw	x
1033  0543 97            	ld	xl,a
1034  0544 a601          	ld	a,#1
1035  0546 5d            	tnzw	x
1036  0547 2704          	jreq	L224
1037  0549               L424:
1038  0549 48            	sll	a
1039  054a 5a            	decw	x
1040  054b 26fc          	jrne	L424
1041  054d               L224:
1042  054d c4540d        	and	a,21517
1044  0550 2010          	jra	L701
1045  0552               L501:
1046                     ; 515     status = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (Channel - (uint8_t)8)));
1047  0552 a008          	sub	a,#8
1048  0554 5f            	clrw	x
1049  0555 97            	ld	xl,a
1050  0556 a601          	ld	a,#1
1051  0558 5d            	tnzw	x
1052  0559 2704          	jreq	L624
1053  055b               L034:
1054  055b 48            	sll	a
1055  055c 5a            	decw	x
1056  055d 26fc          	jrne	L034
1057  055f               L624:
1058  055f c4540c        	and	a,21516
1059  0562               L701:
1060                     ; 518   return ((FlagStatus)status);
1062  0562 85            	popw	x
1063  0563 81            	ret	
1065                     ; 527 FlagStatus ADC1_GetFlagStatus(ADC1_Flag_TypeDef Flag)
1065                     ; 528 {
1066  0564               _ADC1_GetFlagStatus:
1067  0564 88            	push	a
1068  0565 88            	push	a
1069       00000001      OFST:	set	1
1071                     ; 529   uint8_t flagstatus = 0;
1072                     ; 530   uint8_t temp = 0;
1073                     ; 533   assert_param(IS_ADC1_FLAG_OK(Flag));
1074  0566 a180          	cp	a,#128
1075  0568 273e          	jreq	L044
1076  056a a141          	cp	a,#65
1077  056c 273a          	jreq	L044
1078  056e a140          	cp	a,#64
1079  0570 2736          	jreq	L044
1080  0572 a110          	cp	a,#16
1081  0574 2732          	jreq	L044
1082  0576 a111          	cp	a,#17
1083  0578 272e          	jreq	L044
1084  057a a112          	cp	a,#18
1085  057c 272a          	jreq	L044
1086  057e a113          	cp	a,#19
1087  0580 2726          	jreq	L044
1088  0582 a114          	cp	a,#20
1089  0584 2722          	jreq	L044
1090  0586 a115          	cp	a,#21
1091  0588 271e          	jreq	L044
1092  058a a116          	cp	a,#22
1093  058c 271a          	jreq	L044
1094  058e a117          	cp	a,#23
1095  0590 2716          	jreq	L044
1096  0592 a118          	cp	a,#24
1097  0594 2712          	jreq	L044
1098  0596 a119          	cp	a,#25
1099  0598 270e          	jreq	L044
1100  059a ae0215        	ldw	x,#533
1101  059d 89            	pushw	x
1102  059e 5f            	clrw	x
1103  059f 89            	pushw	x
1104  05a0 ae0000        	ldw	x,#L3
1105  05a3 cd0000        	call	_assert_failed
1107  05a6 5b04          	addw	sp,#4
1108  05a8               L044:
1109                     ; 535   if ((Flag & 0x0F) == 0x01)
1110  05a8 7b02          	ld	a,(OFST+1,sp)
1111  05aa a40f          	and	a,#15
1112  05ac 4a            	dec	a
1113  05ad 2607          	jrne	L111
1114                     ; 538     flagstatus = (uint8_t)(ADC1->CR3 & ADC1_CR3_OVR);
1115  05af c65403        	ld	a,21507
1116  05b2 a440          	and	a,#64
1118  05b4 2039          	jra	L311
1119  05b6               L111:
1120                     ; 540   else if ((Flag & 0xF0) == 0x10)
1121  05b6 7b02          	ld	a,(OFST+1,sp)
1122  05b8 a4f0          	and	a,#240
1123  05ba a110          	cp	a,#16
1124  05bc 262c          	jrne	L511
1125                     ; 543     temp = (uint8_t)(Flag & (uint8_t)0x0F);
1126  05be 7b02          	ld	a,(OFST+1,sp)
1127  05c0 a40f          	and	a,#15
1128  05c2 6b01          	ld	(OFST+0,sp),a
1129                     ; 544     if (temp < 8)
1130  05c4 a108          	cp	a,#8
1131  05c6 2410          	jruge	L711
1132                     ; 546       flagstatus = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
1133  05c8 5f            	clrw	x
1134  05c9 97            	ld	xl,a
1135  05ca a601          	ld	a,#1
1136  05cc 5d            	tnzw	x
1137  05cd 2704          	jreq	L444
1138  05cf               L644:
1139  05cf 48            	sll	a
1140  05d0 5a            	decw	x
1141  05d1 26fc          	jrne	L644
1142  05d3               L444:
1143  05d3 c4540d        	and	a,21517
1145  05d6 2017          	jra	L311
1146  05d8               L711:
1147                     ; 550       flagstatus = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
1148  05d8 a008          	sub	a,#8
1149  05da 5f            	clrw	x
1150  05db 97            	ld	xl,a
1151  05dc a601          	ld	a,#1
1152  05de 5d            	tnzw	x
1153  05df 2704          	jreq	L054
1154  05e1               L254:
1155  05e1 48            	sll	a
1156  05e2 5a            	decw	x
1157  05e3 26fc          	jrne	L254
1158  05e5               L054:
1159  05e5 c4540c        	and	a,21516
1160  05e8 2005          	jra	L311
1161  05ea               L511:
1162                     ; 555     flagstatus = (uint8_t)(ADC1->CSR & Flag);
1163  05ea c65400        	ld	a,21504
1164  05ed 1402          	and	a,(OFST+1,sp)
1165  05ef               L311:
1166                     ; 557   return ((FlagStatus)flagstatus);
1168  05ef 85            	popw	x
1169  05f0 81            	ret	
1171                     ; 567 void ADC1_ClearFlag(ADC1_Flag_TypeDef Flag)
1171                     ; 568 {
1172  05f1               _ADC1_ClearFlag:
1173  05f1 88            	push	a
1174  05f2 88            	push	a
1175       00000001      OFST:	set	1
1177                     ; 569   uint8_t temp = 0;
1178                     ; 572   assert_param(IS_ADC1_FLAG_OK(Flag));
1179  05f3 a180          	cp	a,#128
1180  05f5 273e          	jreq	L264
1181  05f7 a141          	cp	a,#65
1182  05f9 273a          	jreq	L264
1183  05fb a140          	cp	a,#64
1184  05fd 2736          	jreq	L264
1185  05ff a110          	cp	a,#16
1186  0601 2732          	jreq	L264
1187  0603 a111          	cp	a,#17
1188  0605 272e          	jreq	L264
1189  0607 a112          	cp	a,#18
1190  0609 272a          	jreq	L264
1191  060b a113          	cp	a,#19
1192  060d 2726          	jreq	L264
1193  060f a114          	cp	a,#20
1194  0611 2722          	jreq	L264
1195  0613 a115          	cp	a,#21
1196  0615 271e          	jreq	L264
1197  0617 a116          	cp	a,#22
1198  0619 271a          	jreq	L264
1199  061b a117          	cp	a,#23
1200  061d 2716          	jreq	L264
1201  061f a118          	cp	a,#24
1202  0621 2712          	jreq	L264
1203  0623 a119          	cp	a,#25
1204  0625 270e          	jreq	L264
1205  0627 ae023c        	ldw	x,#572
1206  062a 89            	pushw	x
1207  062b 5f            	clrw	x
1208  062c 89            	pushw	x
1209  062d ae0000        	ldw	x,#L3
1210  0630 cd0000        	call	_assert_failed
1212  0633 5b04          	addw	sp,#4
1213  0635               L264:
1214                     ; 574   if ((Flag & 0x0F) == 0x01)
1215  0635 7b02          	ld	a,(OFST+1,sp)
1216  0637 a40f          	and	a,#15
1217  0639 4a            	dec	a
1218  063a 2606          	jrne	L521
1219                     ; 577     ADC1->CR3 &= (uint8_t)(~ADC1_CR3_OVR);
1220  063c 721d5403      	bres	21507,#6
1222  0640 2045          	jra	L721
1223  0642               L521:
1224                     ; 579   else if ((Flag & 0xF0) == 0x10)
1225  0642 7b02          	ld	a,(OFST+1,sp)
1226  0644 a4f0          	and	a,#240
1227  0646 a110          	cp	a,#16
1228  0648 2634          	jrne	L131
1229                     ; 582     temp = (uint8_t)(Flag & (uint8_t)0x0F);
1230  064a 7b02          	ld	a,(OFST+1,sp)
1231  064c a40f          	and	a,#15
1232  064e 6b01          	ld	(OFST+0,sp),a
1233                     ; 583     if (temp < 8)
1234  0650 a108          	cp	a,#8
1235  0652 2414          	jruge	L331
1236                     ; 585       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
1237  0654 5f            	clrw	x
1238  0655 97            	ld	xl,a
1239  0656 a601          	ld	a,#1
1240  0658 5d            	tnzw	x
1241  0659 2704          	jreq	L664
1242  065b               L074:
1243  065b 48            	sll	a
1244  065c 5a            	decw	x
1245  065d 26fc          	jrne	L074
1246  065f               L664:
1247  065f 43            	cpl	a
1248  0660 c4540d        	and	a,21517
1249  0663 c7540d        	ld	21517,a
1251  0666 201f          	jra	L721
1252  0668               L331:
1253                     ; 589       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
1254  0668 a008          	sub	a,#8
1255  066a 5f            	clrw	x
1256  066b 97            	ld	xl,a
1257  066c a601          	ld	a,#1
1258  066e 5d            	tnzw	x
1259  066f 2704          	jreq	L274
1260  0671               L474:
1261  0671 48            	sll	a
1262  0672 5a            	decw	x
1263  0673 26fc          	jrne	L474
1264  0675               L274:
1265  0675 43            	cpl	a
1266  0676 c4540c        	and	a,21516
1267  0679 c7540c        	ld	21516,a
1268  067c 2009          	jra	L721
1269  067e               L131:
1270                     ; 594     ADC1->CSR &= (uint8_t) (~Flag);
1271  067e 7b02          	ld	a,(OFST+1,sp)
1272  0680 43            	cpl	a
1273  0681 c45400        	and	a,21504
1274  0684 c75400        	ld	21504,a
1275  0687               L721:
1276                     ; 596 }
1277  0687 85            	popw	x
1278  0688 81            	ret	
1280                     ; 616 ITStatus ADC1_GetITStatus(ADC1_IT_TypeDef ITPendingBit)
1280                     ; 617 {
1281  0689               _ADC1_GetITStatus:
1282  0689 89            	pushw	x
1283  068a 88            	push	a
1284       00000001      OFST:	set	1
1286                     ; 618   ITStatus itstatus = RESET;
1287                     ; 619   uint8_t temp = 0;
1288                     ; 622   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
1289  068b a30080        	cpw	x,#128
1290  068e 274a          	jreq	L405
1291  0690 a30140        	cpw	x,#320
1292  0693 2745          	jreq	L405
1293  0695 a30110        	cpw	x,#272
1294  0698 2740          	jreq	L405
1295  069a a30111        	cpw	x,#273
1296  069d 273b          	jreq	L405
1297  069f a30112        	cpw	x,#274
1298  06a2 2736          	jreq	L405
1299  06a4 a30113        	cpw	x,#275
1300  06a7 2731          	jreq	L405
1301  06a9 a30114        	cpw	x,#276
1302  06ac 272c          	jreq	L405
1303  06ae a30115        	cpw	x,#277
1304  06b1 2727          	jreq	L405
1305  06b3 a30116        	cpw	x,#278
1306  06b6 2722          	jreq	L405
1307  06b8 a30117        	cpw	x,#279
1308  06bb 271d          	jreq	L405
1309  06bd a30118        	cpw	x,#280
1310  06c0 2718          	jreq	L405
1311  06c2 a3011c        	cpw	x,#284
1312  06c5 2713          	jreq	L405
1313  06c7 a30119        	cpw	x,#281
1314  06ca 270e          	jreq	L405
1315  06cc ae026e        	ldw	x,#622
1316  06cf 89            	pushw	x
1317  06d0 5f            	clrw	x
1318  06d1 89            	pushw	x
1319  06d2 ae0000        	ldw	x,#L3
1320  06d5 cd0000        	call	_assert_failed
1322  06d8 5b04          	addw	sp,#4
1323  06da               L405:
1324                     ; 624   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
1325  06da 7b03          	ld	a,(OFST+2,sp)
1326  06dc a4f0          	and	a,#240
1327  06de 5f            	clrw	x
1328  06df 02            	rlwa	x,a
1329  06e0 a30010        	cpw	x,#16
1330  06e3 262c          	jrne	L141
1331                     ; 627     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
1332  06e5 7b03          	ld	a,(OFST+2,sp)
1333  06e7 a40f          	and	a,#15
1334  06e9 6b01          	ld	(OFST+0,sp),a
1335                     ; 628     if (temp < 8)
1336  06eb a108          	cp	a,#8
1337  06ed 2410          	jruge	L341
1338                     ; 630       itstatus = (ITStatus)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
1339  06ef 5f            	clrw	x
1340  06f0 97            	ld	xl,a
1341  06f1 a601          	ld	a,#1
1342  06f3 5d            	tnzw	x
1343  06f4 2704          	jreq	L015
1344  06f6               L215:
1345  06f6 48            	sll	a
1346  06f7 5a            	decw	x
1347  06f8 26fc          	jrne	L215
1348  06fa               L015:
1349  06fa c4540d        	and	a,21517
1351  06fd 2017          	jra	L741
1352  06ff               L341:
1353                     ; 634       itstatus = (ITStatus)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
1354  06ff a008          	sub	a,#8
1355  0701 5f            	clrw	x
1356  0702 97            	ld	xl,a
1357  0703 a601          	ld	a,#1
1358  0705 5d            	tnzw	x
1359  0706 2704          	jreq	L415
1360  0708               L615:
1361  0708 48            	sll	a
1362  0709 5a            	decw	x
1363  070a 26fc          	jrne	L615
1364  070c               L415:
1365  070c c4540c        	and	a,21516
1366  070f 2005          	jra	L741
1367  0711               L141:
1368                     ; 639     itstatus = (ITStatus)(ADC1->CSR & (uint8_t)ITPendingBit);
1369  0711 c65400        	ld	a,21504
1370  0714 1403          	and	a,(OFST+2,sp)
1371  0716               L741:
1372                     ; 641   return ((ITStatus)itstatus);
1374  0716 5b03          	addw	sp,#3
1375  0718 81            	ret	
1377                     ; 662 void ADC1_ClearITPendingBit(ADC1_IT_TypeDef ITPendingBit)
1377                     ; 663 {
1378  0719               _ADC1_ClearITPendingBit:
1379  0719 89            	pushw	x
1380  071a 88            	push	a
1381       00000001      OFST:	set	1
1383                     ; 664   uint8_t temp = 0;
1384                     ; 667   assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
1385  071b a30080        	cpw	x,#128
1386  071e 274a          	jreq	L625
1387  0720 a30140        	cpw	x,#320
1388  0723 2745          	jreq	L625
1389  0725 a30110        	cpw	x,#272
1390  0728 2740          	jreq	L625
1391  072a a30111        	cpw	x,#273
1392  072d 273b          	jreq	L625
1393  072f a30112        	cpw	x,#274
1394  0732 2736          	jreq	L625
1395  0734 a30113        	cpw	x,#275
1396  0737 2731          	jreq	L625
1397  0739 a30114        	cpw	x,#276
1398  073c 272c          	jreq	L625
1399  073e a30115        	cpw	x,#277
1400  0741 2727          	jreq	L625
1401  0743 a30116        	cpw	x,#278
1402  0746 2722          	jreq	L625
1403  0748 a30117        	cpw	x,#279
1404  074b 271d          	jreq	L625
1405  074d a30118        	cpw	x,#280
1406  0750 2718          	jreq	L625
1407  0752 a3011c        	cpw	x,#284
1408  0755 2713          	jreq	L625
1409  0757 a30119        	cpw	x,#281
1410  075a 270e          	jreq	L625
1411  075c ae029b        	ldw	x,#667
1412  075f 89            	pushw	x
1413  0760 5f            	clrw	x
1414  0761 89            	pushw	x
1415  0762 ae0000        	ldw	x,#L3
1416  0765 cd0000        	call	_assert_failed
1418  0768 5b04          	addw	sp,#4
1419  076a               L625:
1420                     ; 669   if (((uint16_t)ITPendingBit & 0xF0) == 0x10)
1421  076a 7b03          	ld	a,(OFST+2,sp)
1422  076c a4f0          	and	a,#240
1423  076e 5f            	clrw	x
1424  076f 02            	rlwa	x,a
1425  0770 a30010        	cpw	x,#16
1426  0773 2634          	jrne	L151
1427                     ; 672     temp = (uint8_t)((uint16_t)ITPendingBit & 0x0F);
1428  0775 7b03          	ld	a,(OFST+2,sp)
1429  0777 a40f          	and	a,#15
1430  0779 6b01          	ld	(OFST+0,sp),a
1431                     ; 673     if (temp < 8)
1432  077b a108          	cp	a,#8
1433  077d 2414          	jruge	L351
1434                     ; 675       ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
1435  077f 5f            	clrw	x
1436  0780 97            	ld	xl,a
1437  0781 a601          	ld	a,#1
1438  0783 5d            	tnzw	x
1439  0784 2704          	jreq	L235
1440  0786               L435:
1441  0786 48            	sll	a
1442  0787 5a            	decw	x
1443  0788 26fc          	jrne	L435
1444  078a               L235:
1445  078a 43            	cpl	a
1446  078b c4540d        	and	a,21517
1447  078e c7540d        	ld	21517,a
1449  0791 201f          	jra	L751
1450  0793               L351:
1451                     ; 679       ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
1452  0793 a008          	sub	a,#8
1453  0795 5f            	clrw	x
1454  0796 97            	ld	xl,a
1455  0797 a601          	ld	a,#1
1456  0799 5d            	tnzw	x
1457  079a 2704          	jreq	L635
1458  079c               L045:
1459  079c 48            	sll	a
1460  079d 5a            	decw	x
1461  079e 26fc          	jrne	L045
1462  07a0               L635:
1463  07a0 43            	cpl	a
1464  07a1 c4540c        	and	a,21516
1465  07a4 c7540c        	ld	21516,a
1466  07a7 2009          	jra	L751
1467  07a9               L151:
1468                     ; 684     ADC1->CSR &= (uint8_t)((uint16_t)~(uint16_t)ITPendingBit);
1469  07a9 7b03          	ld	a,(OFST+2,sp)
1470  07ab 43            	cpl	a
1471  07ac c45400        	and	a,21504
1472  07af c75400        	ld	21504,a
1473  07b2               L751:
1474                     ; 686 }
1475  07b2 5b03          	addw	sp,#3
1476  07b4 81            	ret	
1478                     	xdef	_ADC1_ClearITPendingBit
1479                     	xdef	_ADC1_GetITStatus
1480                     	xdef	_ADC1_ClearFlag
1481                     	xdef	_ADC1_GetFlagStatus
1482                     	xdef	_ADC1_GetAWDChannelStatus
1483                     	xdef	_ADC1_GetBufferValue
1484                     	xdef	_ADC1_SetLowThreshold
1485                     	xdef	_ADC1_SetHighThreshold
1486                     	xdef	_ADC1_GetConversionValue
1487                     	xdef	_ADC1_StartConversion
1488                     	xdef	_ADC1_AWDChannelConfig
1489                     	xdef	_ADC1_ExternalTriggerConfig
1490                     	xdef	_ADC1_ConversionConfig
1491                     	xdef	_ADC1_SchmittTriggerConfig
1492                     	xdef	_ADC1_PrescalerConfig
1493                     	xdef	_ADC1_ITConfig
1494                     	xdef	_ADC1_DataBufferCmd
1495                     	xdef	_ADC1_ScanModeCmd
1496                     	xdef	_ADC1_Cmd
1497                     	xdef	_ADC1_Init
1498                     	xdef	_ADC1_DeInit
1499                     	xref	_assert_failed
1500                     .const:	section	.text
1501  0000               L3:
1502  0000 7372635c7374  	dc.b	"src\stm8s_adc1.c",0
1503                     	end
