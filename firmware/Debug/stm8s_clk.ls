   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     .const:	section	.text
  20  0000               _HSIDivFactor:
  21  0000 01            	dc.b	1
  22  0001 02            	dc.b	2
  23  0002 04            	dc.b	4
  24  0003 08            	dc.b	8
  25  0004               _CLKPrescTable:
  26  0004 01            	dc.b	1
  27  0005 02            	dc.b	2
  28  0006 04            	dc.b	4
  29  0007 08            	dc.b	8
  30  0008 0a            	dc.b	10
  31  0009 10            	dc.b	16
  32  000a 14            	dc.b	20
  33  000b 28            	dc.b	40
  34                     ; 72 void CLK_DeInit(void)
  34                     ; 73 {
  35                     	scross	off
  36                     	switch	.text
  37  0000               _CLK_DeInit:
  39                     ; 74   CLK->ICKR = CLK_ICKR_RESET_VALUE;
  40  0000 350150c0      	mov	20672,#1
  41                     ; 75   CLK->ECKR = CLK_ECKR_RESET_VALUE;
  42  0004 725f50c1      	clr	20673
  43                     ; 76   CLK->SWR  = CLK_SWR_RESET_VALUE;
  44  0008 35e150c4      	mov	20676,#225
  45                     ; 77   CLK->SWCR = CLK_SWCR_RESET_VALUE;
  46  000c 725f50c5      	clr	20677
  47                     ; 78   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  48  0010 351850c6      	mov	20678,#24
  49                     ; 79   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  50  0014 35ff50c7      	mov	20679,#255
  51                     ; 80   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  52  0018 35ff50ca      	mov	20682,#255
  53                     ; 81   CLK->CSSR = CLK_CSSR_RESET_VALUE;
  54  001c 725f50c8      	clr	20680
  55                     ; 82   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  56  0020 725f50c9      	clr	20681
  58  0024               L7:
  59                     ; 83   while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  60  0024 720050c9fb    	btjt	20681,#0,L7
  61                     ; 85   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  62  0029 725f50c9      	clr	20681
  63                     ; 86   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
  64  002d 725f50cc      	clr	20684
  65                     ; 87   CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
  66  0031 725f50cd      	clr	20685
  67                     ; 88 }
  68  0035 81            	ret	
  70                     ; 99 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
  70                     ; 100 {
  71  0036               _CLK_FastHaltWakeUpCmd:
  72  0036 88            	push	a
  73       00000000      OFST:	set	0
  75                     ; 102   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
  76  0037 4d            	tnz	a
  77  0038 2711          	jreq	L21
  78  003a 4a            	dec	a
  79  003b 270e          	jreq	L21
  80  003d ae0066        	ldw	x,#102
  81  0040 89            	pushw	x
  82  0041 5f            	clrw	x
  83  0042 89            	pushw	x
  84  0043 ae000c        	ldw	x,#L31
  85  0046 cd0000        	call	_assert_failed
  87  0049 5b04          	addw	sp,#4
  88  004b               L21:
  89                     ; 104   if (NewState != DISABLE)
  90  004b 7b01          	ld	a,(OFST+1,sp)
  91  004d 2706          	jreq	L51
  92                     ; 107     CLK->ICKR |= CLK_ICKR_FHWU;
  93  004f 721450c0      	bset	20672,#2
  95  0053 2004          	jra	L71
  96  0055               L51:
  97                     ; 112     CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
  98  0055 721550c0      	bres	20672,#2
  99  0059               L71:
 100                     ; 114 }
 101  0059 84            	pop	a
 102  005a 81            	ret	
 104                     ; 121 void CLK_HSECmd(FunctionalState NewState)
 104                     ; 122 {
 105  005b               _CLK_HSECmd:
 106  005b 88            	push	a
 107       00000000      OFST:	set	0
 109                     ; 124   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 110  005c 4d            	tnz	a
 111  005d 2711          	jreq	L42
 112  005f 4a            	dec	a
 113  0060 270e          	jreq	L42
 114  0062 ae007c        	ldw	x,#124
 115  0065 89            	pushw	x
 116  0066 5f            	clrw	x
 117  0067 89            	pushw	x
 118  0068 ae000c        	ldw	x,#L31
 119  006b cd0000        	call	_assert_failed
 121  006e 5b04          	addw	sp,#4
 122  0070               L42:
 123                     ; 126   if (NewState != DISABLE)
 124  0070 7b01          	ld	a,(OFST+1,sp)
 125  0072 2706          	jreq	L12
 126                     ; 129     CLK->ECKR |= CLK_ECKR_HSEEN;
 127  0074 721050c1      	bset	20673,#0
 129  0078 2004          	jra	L32
 130  007a               L12:
 131                     ; 134     CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 132  007a 721150c1      	bres	20673,#0
 133  007e               L32:
 134                     ; 136 }
 135  007e 84            	pop	a
 136  007f 81            	ret	
 138                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 138                     ; 144 {
 139  0080               _CLK_HSICmd:
 140  0080 88            	push	a
 141       00000000      OFST:	set	0
 143                     ; 146   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 144  0081 4d            	tnz	a
 145  0082 2711          	jreq	L63
 146  0084 4a            	dec	a
 147  0085 270e          	jreq	L63
 148  0087 ae0092        	ldw	x,#146
 149  008a 89            	pushw	x
 150  008b 5f            	clrw	x
 151  008c 89            	pushw	x
 152  008d ae000c        	ldw	x,#L31
 153  0090 cd0000        	call	_assert_failed
 155  0093 5b04          	addw	sp,#4
 156  0095               L63:
 157                     ; 148   if (NewState != DISABLE)
 158  0095 7b01          	ld	a,(OFST+1,sp)
 159  0097 2706          	jreq	L52
 160                     ; 151     CLK->ICKR |= CLK_ICKR_HSIEN;
 161  0099 721050c0      	bset	20672,#0
 163  009d 2004          	jra	L72
 164  009f               L52:
 165                     ; 156     CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 166  009f 721150c0      	bres	20672,#0
 167  00a3               L72:
 168                     ; 158 }
 169  00a3 84            	pop	a
 170  00a4 81            	ret	
 172                     ; 166 void CLK_LSICmd(FunctionalState NewState)
 172                     ; 167 {
 173  00a5               _CLK_LSICmd:
 174  00a5 88            	push	a
 175       00000000      OFST:	set	0
 177                     ; 169   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 178  00a6 4d            	tnz	a
 179  00a7 2711          	jreq	L05
 180  00a9 4a            	dec	a
 181  00aa 270e          	jreq	L05
 182  00ac ae00a9        	ldw	x,#169
 183  00af 89            	pushw	x
 184  00b0 5f            	clrw	x
 185  00b1 89            	pushw	x
 186  00b2 ae000c        	ldw	x,#L31
 187  00b5 cd0000        	call	_assert_failed
 189  00b8 5b04          	addw	sp,#4
 190  00ba               L05:
 191                     ; 171   if (NewState != DISABLE)
 192  00ba 7b01          	ld	a,(OFST+1,sp)
 193  00bc 2706          	jreq	L13
 194                     ; 174     CLK->ICKR |= CLK_ICKR_LSIEN;
 195  00be 721650c0      	bset	20672,#3
 197  00c2 2004          	jra	L33
 198  00c4               L13:
 199                     ; 179     CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 200  00c4 721750c0      	bres	20672,#3
 201  00c8               L33:
 202                     ; 181 }
 203  00c8 84            	pop	a
 204  00c9 81            	ret	
 206                     ; 189 void CLK_CCOCmd(FunctionalState NewState)
 206                     ; 190 {
 207  00ca               _CLK_CCOCmd:
 208  00ca 88            	push	a
 209       00000000      OFST:	set	0
 211                     ; 192   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 212  00cb 4d            	tnz	a
 213  00cc 2711          	jreq	L26
 214  00ce 4a            	dec	a
 215  00cf 270e          	jreq	L26
 216  00d1 ae00c0        	ldw	x,#192
 217  00d4 89            	pushw	x
 218  00d5 5f            	clrw	x
 219  00d6 89            	pushw	x
 220  00d7 ae000c        	ldw	x,#L31
 221  00da cd0000        	call	_assert_failed
 223  00dd 5b04          	addw	sp,#4
 224  00df               L26:
 225                     ; 194   if (NewState != DISABLE)
 226  00df 7b01          	ld	a,(OFST+1,sp)
 227  00e1 2706          	jreq	L53
 228                     ; 197     CLK->CCOR |= CLK_CCOR_CCOEN;
 229  00e3 721050c9      	bset	20681,#0
 231  00e7 2004          	jra	L73
 232  00e9               L53:
 233                     ; 202     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 234  00e9 721150c9      	bres	20681,#0
 235  00ed               L73:
 236                     ; 204 }
 237  00ed 84            	pop	a
 238  00ee 81            	ret	
 240                     ; 213 void CLK_ClockSwitchCmd(FunctionalState NewState)
 240                     ; 214 {
 241  00ef               _CLK_ClockSwitchCmd:
 242  00ef 88            	push	a
 243       00000000      OFST:	set	0
 245                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 246  00f0 4d            	tnz	a
 247  00f1 2711          	jreq	L47
 248  00f3 4a            	dec	a
 249  00f4 270e          	jreq	L47
 250  00f6 ae00d8        	ldw	x,#216
 251  00f9 89            	pushw	x
 252  00fa 5f            	clrw	x
 253  00fb 89            	pushw	x
 254  00fc ae000c        	ldw	x,#L31
 255  00ff cd0000        	call	_assert_failed
 257  0102 5b04          	addw	sp,#4
 258  0104               L47:
 259                     ; 218   if (NewState != DISABLE )
 260  0104 7b01          	ld	a,(OFST+1,sp)
 261  0106 2706          	jreq	L14
 262                     ; 221     CLK->SWCR |= CLK_SWCR_SWEN;
 263  0108 721250c5      	bset	20677,#1
 265  010c 2004          	jra	L34
 266  010e               L14:
 267                     ; 226     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 268  010e 721350c5      	bres	20677,#1
 269  0112               L34:
 270                     ; 228 }
 271  0112 84            	pop	a
 272  0113 81            	ret	
 274                     ; 238 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 274                     ; 239 {
 275  0114               _CLK_SlowActiveHaltWakeUpCmd:
 276  0114 88            	push	a
 277       00000000      OFST:	set	0
 279                     ; 241   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 280  0115 4d            	tnz	a
 281  0116 2711          	jreq	L601
 282  0118 4a            	dec	a
 283  0119 270e          	jreq	L601
 284  011b ae00f1        	ldw	x,#241
 285  011e 89            	pushw	x
 286  011f 5f            	clrw	x
 287  0120 89            	pushw	x
 288  0121 ae000c        	ldw	x,#L31
 289  0124 cd0000        	call	_assert_failed
 291  0127 5b04          	addw	sp,#4
 292  0129               L601:
 293                     ; 243   if (NewState != DISABLE)
 294  0129 7b01          	ld	a,(OFST+1,sp)
 295  012b 2706          	jreq	L54
 296                     ; 246     CLK->ICKR |= CLK_ICKR_SWUAH;
 297  012d 721a50c0      	bset	20672,#5
 299  0131 2004          	jra	L74
 300  0133               L54:
 301                     ; 251     CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 302  0133 721b50c0      	bres	20672,#5
 303  0137               L74:
 304                     ; 253 }
 305  0137 84            	pop	a
 306  0138 81            	ret	
 308                     ; 263 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 308                     ; 264 {
 309  0139               _CLK_PeripheralClockConfig:
 310  0139 89            	pushw	x
 311       00000000      OFST:	set	0
 313                     ; 266   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 314  013a 9f            	ld	a,xl
 315  013b 4d            	tnz	a
 316  013c 270a          	jreq	L021
 317  013e 9f            	ld	a,xl
 318  013f 4a            	dec	a
 319  0140 2706          	jreq	L021
 320  0142 ae010a        	ldw	x,#266
 321  0145 cd01cb        	call	LC004
 322  0148               L021:
 323                     ; 267   assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 324  0148 7b01          	ld	a,(OFST+1,sp)
 325  014a 272f          	jreq	L031
 326  014c a101          	cp	a,#1
 327  014e 272b          	jreq	L031
 328  0150 a103          	cp	a,#3
 329  0152 2727          	jreq	L031
 330  0154 a104          	cp	a,#4
 331  0156 2723          	jreq	L031
 332  0158 a105          	cp	a,#5
 333  015a 271f          	jreq	L031
 334  015c a104          	cp	a,#4
 335  015e 271b          	jreq	L031
 336  0160 a106          	cp	a,#6
 337  0162 2717          	jreq	L031
 338  0164 a107          	cp	a,#7
 339  0166 2713          	jreq	L031
 340  0168 a117          	cp	a,#23
 341  016a 270f          	jreq	L031
 342  016c a113          	cp	a,#19
 343  016e 270b          	jreq	L031
 344  0170 a112          	cp	a,#18
 345  0172 2707          	jreq	L031
 346  0174 ae010b        	ldw	x,#267
 347  0177 ad52          	call	LC004
 348  0179 7b01          	ld	a,(OFST+1,sp)
 349  017b               L031:
 350                     ; 269   if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 351  017b a510          	bcp	a,#16
 352  017d 2622          	jrne	L15
 353                     ; 271     if (NewState != DISABLE)
 354  017f 0d02          	tnz	(OFST+2,sp)
 355  0181 270d          	jreq	L35
 356                     ; 274       CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 357  0183 ad3e          	call	LC003
 358  0185 2704          	jreq	L431
 359  0187               L631:
 360  0187 48            	sll	a
 361  0188 5a            	decw	x
 362  0189 26fc          	jrne	L631
 363  018b               L431:
 364  018b ca50c7        	or	a,20679
 366  018e 200c          	jp	LC002
 367  0190               L35:
 368                     ; 279       CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 369  0190 ad31          	call	LC003
 370  0192 2704          	jreq	L041
 371  0194               L241:
 372  0194 48            	sll	a
 373  0195 5a            	decw	x
 374  0196 26fc          	jrne	L241
 375  0198               L041:
 376  0198 43            	cpl	a
 377  0199 c450c7        	and	a,20679
 378  019c               LC002:
 379  019c c750c7        	ld	20679,a
 380  019f 2020          	jra	L75
 381  01a1               L15:
 382                     ; 284     if (NewState != DISABLE)
 383  01a1 0d02          	tnz	(OFST+2,sp)
 384  01a3 270d          	jreq	L16
 385                     ; 287       CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 386  01a5 ad1c          	call	LC003
 387  01a7 2704          	jreq	L441
 388  01a9               L641:
 389  01a9 48            	sll	a
 390  01aa 5a            	decw	x
 391  01ab 26fc          	jrne	L641
 392  01ad               L441:
 393  01ad ca50ca        	or	a,20682
 395  01b0 200c          	jp	LC001
 396  01b2               L16:
 397                     ; 292       CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 398  01b2 ad0f          	call	LC003
 399  01b4 2704          	jreq	L051
 400  01b6               L251:
 401  01b6 48            	sll	a
 402  01b7 5a            	decw	x
 403  01b8 26fc          	jrne	L251
 404  01ba               L051:
 405  01ba 43            	cpl	a
 406  01bb c450ca        	and	a,20682
 407  01be               LC001:
 408  01be c750ca        	ld	20682,a
 409  01c1               L75:
 410                     ; 295 }
 411  01c1 85            	popw	x
 412  01c2 81            	ret	
 413  01c3               LC003:
 414  01c3 a40f          	and	a,#15
 415  01c5 5f            	clrw	x
 416  01c6 97            	ld	xl,a
 417  01c7 a601          	ld	a,#1
 418  01c9 5d            	tnzw	x
 419  01ca 81            	ret	
 420  01cb               LC004:
 421  01cb 89            	pushw	x
 422  01cc 5f            	clrw	x
 423  01cd 89            	pushw	x
 424  01ce ae000c        	ldw	x,#L31
 425  01d1 cd0000        	call	_assert_failed
 427  01d4 5b04          	addw	sp,#4
 428  01d6 81            	ret	
 430                     ; 309 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 430                     ; 310 {
 431  01d7               _CLK_ClockSwitchConfig:
 432  01d7 89            	pushw	x
 433  01d8 5204          	subw	sp,#4
 434       00000004      OFST:	set	4
 436                     ; 312   uint16_t DownCounter = CLK_TIMEOUT;
 437  01da aeffff        	ldw	x,#65535
 438  01dd 1f03          	ldw	(OFST-1,sp),x
 439                     ; 313   ErrorStatus Swif = ERROR;
 440                     ; 316   assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
 441  01df 7b06          	ld	a,(OFST+2,sp)
 442  01e1 a1e1          	cp	a,#225
 443  01e3 270e          	jreq	L261
 444  01e5 a1d2          	cp	a,#210
 445  01e7 270a          	jreq	L261
 446  01e9 a1b4          	cp	a,#180
 447  01eb 2706          	jreq	L261
 448  01ed ae013c        	ldw	x,#316
 449  01f0 cd02b3        	call	LC007
 450  01f3               L261:
 451                     ; 317   assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
 452  01f3 7b05          	ld	a,(OFST+1,sp)
 453  01f5 2709          	jreq	L271
 454  01f7 4a            	dec	a
 455  01f8 2706          	jreq	L271
 456  01fa ae013d        	ldw	x,#317
 457  01fd cd02b3        	call	LC007
 458  0200               L271:
 459                     ; 318   assert_param(IS_FUNCTIONALSTATE_OK(ITState));
 460  0200 7b09          	ld	a,(OFST+5,sp)
 461  0202 2709          	jreq	L202
 462  0204 4a            	dec	a
 463  0205 2706          	jreq	L202
 464  0207 ae013e        	ldw	x,#318
 465  020a cd02b3        	call	LC007
 466  020d               L202:
 467                     ; 319   assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
 468  020d 7b0a          	ld	a,(OFST+6,sp)
 469  020f 2709          	jreq	L212
 470  0211 4a            	dec	a
 471  0212 2706          	jreq	L212
 472  0214 ae013f        	ldw	x,#319
 473  0217 cd02b3        	call	LC007
 474  021a               L212:
 475                     ; 322   clock_master = (CLK_Source_TypeDef)CLK->CMSR;
 476  021a c650c3        	ld	a,20675
 477  021d 6b01          	ld	(OFST-3,sp),a
 478                     ; 325   if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
 479  021f 7b05          	ld	a,(OFST+1,sp)
 480  0221 4a            	dec	a
 481  0222 263d          	jrne	L56
 482                     ; 328     CLK->SWCR |= CLK_SWCR_SWEN;
 483  0224 721250c5      	bset	20677,#1
 484                     ; 331     if (ITState != DISABLE)
 485  0228 7b09          	ld	a,(OFST+5,sp)
 486  022a 2706          	jreq	L76
 487                     ; 333       CLK->SWCR |= CLK_SWCR_SWIEN;
 488  022c 721450c5      	bset	20677,#2
 490  0230 2004          	jra	L17
 491  0232               L76:
 492                     ; 337       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
 493  0232 721550c5      	bres	20677,#2
 494  0236               L17:
 495                     ; 341     CLK->SWR = (uint8_t)CLK_NewClock;
 496  0236 7b06          	ld	a,(OFST+2,sp)
 497  0238 c750c4        	ld	20676,a
 499  023b 2003          	jra	L77
 500  023d               L37:
 501                     ; 346       DownCounter--;
 502  023d 5a            	decw	x
 503  023e 1f03          	ldw	(OFST-1,sp),x
 504  0240               L77:
 505                     ; 344     while((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
 506  0240 720150c504    	btjf	20677,#0,L301
 508  0245 1e03          	ldw	x,(OFST-1,sp)
 509  0247 26f4          	jrne	L37
 510  0249               L301:
 511                     ; 349     if(DownCounter != 0)
 512  0249 1e03          	ldw	x,(OFST-1,sp)
 513                     ; 351       Swif = SUCCESS;
 515  024b 263d          	jrne	LC006
 516  024d               L501:
 517                     ; 355       Swif = ERROR;
 518  024d 0f02          	clr	(OFST-2,sp)
 519  024f               L111:
 520                     ; 390   if(Swif != ERROR)
 521  024f 275d          	jreq	L531
 522                     ; 393     if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
 523  0251 7b0a          	ld	a,(OFST+6,sp)
 524  0253 263b          	jrne	L731
 526  0255 7b01          	ld	a,(OFST-3,sp)
 527  0257 a1e1          	cp	a,#225
 528  0259 2635          	jrne	L731
 529                     ; 395       CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 530  025b 721150c0      	bres	20672,#0
 532  025f 204d          	jra	L531
 533  0261               L56:
 534                     ; 361     if (ITState != DISABLE)
 535  0261 7b09          	ld	a,(OFST+5,sp)
 536  0263 2706          	jreq	L311
 537                     ; 363       CLK->SWCR |= CLK_SWCR_SWIEN;
 538  0265 721450c5      	bset	20677,#2
 540  0269 2004          	jra	L511
 541  026b               L311:
 542                     ; 367       CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
 543  026b 721550c5      	bres	20677,#2
 544  026f               L511:
 545                     ; 371     CLK->SWR = (uint8_t)CLK_NewClock;
 546  026f 7b06          	ld	a,(OFST+2,sp)
 547  0271 c750c4        	ld	20676,a
 549  0274 2003          	jra	L321
 550  0276               L711:
 551                     ; 376       DownCounter--;
 552  0276 5a            	decw	x
 553  0277 1f03          	ldw	(OFST-1,sp),x
 554  0279               L321:
 555                     ; 374     while((((CLK->SWCR & CLK_SWCR_SWIF) != 0 ) && (DownCounter != 0)))
 556  0279 720750c504    	btjf	20677,#3,L721
 558  027e 1e03          	ldw	x,(OFST-1,sp)
 559  0280 26f4          	jrne	L711
 560  0282               L721:
 561                     ; 379     if(DownCounter != 0)
 562  0282 1e03          	ldw	x,(OFST-1,sp)
 563  0284 27c7          	jreq	L501
 564                     ; 382       CLK->SWCR |= CLK_SWCR_SWEN;
 565  0286 721250c5      	bset	20677,#1
 566                     ; 383       Swif = SUCCESS;
 567  028a               LC006:
 568  028a a601          	ld	a,#1
 569  028c 6b02          	ld	(OFST-2,sp),a
 571  028e 20bf          	jra	L111
 572                     ; 387       Swif = ERROR;
 573  0290               L731:
 574                     ; 397     else if((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
 575  0290 7b0a          	ld	a,(OFST+6,sp)
 576  0292 260c          	jrne	L341
 578  0294 7b01          	ld	a,(OFST-3,sp)
 579  0296 a1d2          	cp	a,#210
 580  0298 2606          	jrne	L341
 581                     ; 399       CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 582  029a 721750c0      	bres	20672,#3
 584  029e 200e          	jra	L531
 585  02a0               L341:
 586                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
 587  02a0 7b0a          	ld	a,(OFST+6,sp)
 588  02a2 260a          	jrne	L531
 590  02a4 7b01          	ld	a,(OFST-3,sp)
 591  02a6 a1b4          	cp	a,#180
 592  02a8 2604          	jrne	L531
 593                     ; 403       CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 594  02aa 721150c1      	bres	20673,#0
 595  02ae               L531:
 596                     ; 406   return(Swif);
 597  02ae 7b02          	ld	a,(OFST-2,sp)
 599  02b0 5b06          	addw	sp,#6
 600  02b2 81            	ret	
 601  02b3               LC007:
 602  02b3 89            	pushw	x
 603  02b4 5f            	clrw	x
 604  02b5 89            	pushw	x
 605  02b6 ae000c        	ldw	x,#L31
 606  02b9 cd0000        	call	_assert_failed
 608  02bc 5b04          	addw	sp,#4
 609  02be 81            	ret	
 611                     ; 415 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
 611                     ; 416 {
 612  02bf               _CLK_HSIPrescalerConfig:
 613  02bf 88            	push	a
 614       00000000      OFST:	set	0
 616                     ; 418   assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
 617  02c0 4d            	tnz	a
 618  02c1 271a          	jreq	L422
 619  02c3 a108          	cp	a,#8
 620  02c5 2716          	jreq	L422
 621  02c7 a110          	cp	a,#16
 622  02c9 2712          	jreq	L422
 623  02cb a118          	cp	a,#24
 624  02cd 270e          	jreq	L422
 625  02cf ae01a2        	ldw	x,#418
 626  02d2 89            	pushw	x
 627  02d3 5f            	clrw	x
 628  02d4 89            	pushw	x
 629  02d5 ae000c        	ldw	x,#L31
 630  02d8 cd0000        	call	_assert_failed
 632  02db 5b04          	addw	sp,#4
 633  02dd               L422:
 634                     ; 421   CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
 635  02dd c650c6        	ld	a,20678
 636  02e0 a4e7          	and	a,#231
 637  02e2 c750c6        	ld	20678,a
 638                     ; 424   CLK->CKDIVR |= (uint8_t)HSIPrescaler;
 639  02e5 c650c6        	ld	a,20678
 640  02e8 1a01          	or	a,(OFST+1,sp)
 641  02ea c750c6        	ld	20678,a
 642                     ; 425 }
 643  02ed 84            	pop	a
 644  02ee 81            	ret	
 646                     ; 436 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
 646                     ; 437 {
 647  02ef               _CLK_CCOConfig:
 648  02ef 88            	push	a
 649       00000000      OFST:	set	0
 651                     ; 439   assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
 652  02f0 4d            	tnz	a
 653  02f1 273e          	jreq	L632
 654  02f3 a104          	cp	a,#4
 655  02f5 273a          	jreq	L632
 656  02f7 a102          	cp	a,#2
 657  02f9 2736          	jreq	L632
 658  02fb a108          	cp	a,#8
 659  02fd 2732          	jreq	L632
 660  02ff a10a          	cp	a,#10
 661  0301 272e          	jreq	L632
 662  0303 a10c          	cp	a,#12
 663  0305 272a          	jreq	L632
 664  0307 a10e          	cp	a,#14
 665  0309 2726          	jreq	L632
 666  030b a110          	cp	a,#16
 667  030d 2722          	jreq	L632
 668  030f a112          	cp	a,#18
 669  0311 271e          	jreq	L632
 670  0313 a114          	cp	a,#20
 671  0315 271a          	jreq	L632
 672  0317 a116          	cp	a,#22
 673  0319 2716          	jreq	L632
 674  031b a118          	cp	a,#24
 675  031d 2712          	jreq	L632
 676  031f a11a          	cp	a,#26
 677  0321 270e          	jreq	L632
 678  0323 ae01b7        	ldw	x,#439
 679  0326 89            	pushw	x
 680  0327 5f            	clrw	x
 681  0328 89            	pushw	x
 682  0329 ae000c        	ldw	x,#L31
 683  032c cd0000        	call	_assert_failed
 685  032f 5b04          	addw	sp,#4
 686  0331               L632:
 687                     ; 442   CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
 688  0331 c650c9        	ld	a,20681
 689  0334 a4e1          	and	a,#225
 690  0336 c750c9        	ld	20681,a
 691                     ; 445   CLK->CCOR |= (uint8_t)CLK_CCO;
 692  0339 c650c9        	ld	a,20681
 693  033c 1a01          	or	a,(OFST+1,sp)
 694  033e c750c9        	ld	20681,a
 695                     ; 448   CLK->CCOR |= CLK_CCOR_CCOEN;
 696  0341 721050c9      	bset	20681,#0
 697                     ; 449 }
 698  0345 84            	pop	a
 699  0346 81            	ret	
 701                     ; 459 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
 701                     ; 460 {
 702  0347               _CLK_ITConfig:
 703  0347 89            	pushw	x
 704       00000000      OFST:	set	0
 706                     ; 462   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 707  0348 9f            	ld	a,xl
 708  0349 4d            	tnz	a
 709  034a 2709          	jreq	L052
 710  034c 9f            	ld	a,xl
 711  034d 4a            	dec	a
 712  034e 2705          	jreq	L052
 713  0350 ae01ce        	ldw	x,#462
 714  0353 ad3f          	call	LC008
 715  0355               L052:
 716                     ; 463   assert_param(IS_CLK_IT_OK(CLK_IT));
 717  0355 7b01          	ld	a,(OFST+1,sp)
 718  0357 a10c          	cp	a,#12
 719  0359 2709          	jreq	L062
 720  035b a11c          	cp	a,#28
 721  035d 2705          	jreq	L062
 722  035f ae01cf        	ldw	x,#463
 723  0362 ad30          	call	LC008
 724  0364               L062:
 725                     ; 465   if (NewState != DISABLE)
 726  0364 7b02          	ld	a,(OFST+2,sp)
 727  0366 2716          	jreq	L561
 728                     ; 467     switch (CLK_IT)
 729  0368 7b01          	ld	a,(OFST+1,sp)
 731                     ; 475     default:
 731                     ; 476       break;
 732  036a a00c          	sub	a,#12
 733  036c 270a          	jreq	L351
 734  036e a010          	sub	a,#16
 735  0370 2620          	jrne	L371
 736                     ; 469     case CLK_IT_SWIF: /* Enable the clock switch interrupt */
 736                     ; 470       CLK->SWCR |= CLK_SWCR_SWIEN;
 737  0372 721450c5      	bset	20677,#2
 738                     ; 471       break;
 739  0376 201a          	jra	L371
 740  0378               L351:
 741                     ; 472     case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
 741                     ; 473       CLK->CSSR |= CLK_CSSR_CSSDIE;
 742  0378 721450c8      	bset	20680,#2
 743                     ; 474       break;
 744  037c 2014          	jra	L371
 745                     ; 475     default:
 745                     ; 476       break;
 747  037e               L561:
 748                     ; 481     switch (CLK_IT)
 749  037e 7b01          	ld	a,(OFST+1,sp)
 751                     ; 489     default:
 751                     ; 490       break;
 752  0380 a00c          	sub	a,#12
 753  0382 270a          	jreq	L161
 754  0384 a010          	sub	a,#16
 755  0386 260a          	jrne	L371
 756                     ; 483     case CLK_IT_SWIF: /* Disable the clock switch interrupt */
 756                     ; 484       CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
 757  0388 721550c5      	bres	20677,#2
 758                     ; 485       break;
 759  038c 2004          	jra	L371
 760  038e               L161:
 761                     ; 486     case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
 761                     ; 487       CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
 762  038e 721550c8      	bres	20680,#2
 763                     ; 488       break;
 764  0392               L371:
 765                     ; 493 }
 766  0392 85            	popw	x
 767  0393 81            	ret	
 768                     ; 489     default:
 768                     ; 490       break;
 769  0394               LC008:
 770  0394 89            	pushw	x
 771  0395 5f            	clrw	x
 772  0396 89            	pushw	x
 773  0397 ae000c        	ldw	x,#L31
 774  039a cd0000        	call	_assert_failed
 776  039d 5b04          	addw	sp,#4
 777  039f 81            	ret	
 779                     ; 500 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
 779                     ; 501 {
 780  03a0               _CLK_SYSCLKConfig:
 781  03a0 88            	push	a
 782       00000000      OFST:	set	0
 784                     ; 503   assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
 785  03a1 4d            	tnz	a
 786  03a2 273a          	jreq	L272
 787  03a4 a108          	cp	a,#8
 788  03a6 2736          	jreq	L272
 789  03a8 a110          	cp	a,#16
 790  03aa 2732          	jreq	L272
 791  03ac a118          	cp	a,#24
 792  03ae 272e          	jreq	L272
 793  03b0 a180          	cp	a,#128
 794  03b2 272a          	jreq	L272
 795  03b4 a181          	cp	a,#129
 796  03b6 2726          	jreq	L272
 797  03b8 a182          	cp	a,#130
 798  03ba 2722          	jreq	L272
 799  03bc a183          	cp	a,#131
 800  03be 271e          	jreq	L272
 801  03c0 a184          	cp	a,#132
 802  03c2 271a          	jreq	L272
 803  03c4 a185          	cp	a,#133
 804  03c6 2716          	jreq	L272
 805  03c8 a186          	cp	a,#134
 806  03ca 2712          	jreq	L272
 807  03cc a187          	cp	a,#135
 808  03ce 270e          	jreq	L272
 809  03d0 ae01f7        	ldw	x,#503
 810  03d3 89            	pushw	x
 811  03d4 5f            	clrw	x
 812  03d5 89            	pushw	x
 813  03d6 ae000c        	ldw	x,#L31
 814  03d9 cd0000        	call	_assert_failed
 816  03dc 5b04          	addw	sp,#4
 817  03de               L272:
 818                     ; 505   if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
 819  03de 7b01          	ld	a,(OFST+1,sp)
 820  03e0 2b0e          	jrmi	L102
 821                     ; 507     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
 822  03e2 c650c6        	ld	a,20678
 823  03e5 a4e7          	and	a,#231
 824  03e7 c750c6        	ld	20678,a
 825                     ; 508     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
 826  03ea 7b01          	ld	a,(OFST+1,sp)
 827  03ec a418          	and	a,#24
 829  03ee 200c          	jra	L302
 830  03f0               L102:
 831                     ; 512     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
 832  03f0 c650c6        	ld	a,20678
 833  03f3 a4f8          	and	a,#248
 834  03f5 c750c6        	ld	20678,a
 835                     ; 513     CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
 836  03f8 7b01          	ld	a,(OFST+1,sp)
 837  03fa a407          	and	a,#7
 838  03fc               L302:
 839  03fc ca50c6        	or	a,20678
 840  03ff c750c6        	ld	20678,a
 841                     ; 515 }
 842  0402 84            	pop	a
 843  0403 81            	ret	
 845                     ; 523 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
 845                     ; 524 {
 846  0404               _CLK_SWIMConfig:
 847  0404 88            	push	a
 848       00000000      OFST:	set	0
 850                     ; 526   assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
 851  0405 4d            	tnz	a
 852  0406 2711          	jreq	L403
 853  0408 4a            	dec	a
 854  0409 270e          	jreq	L403
 855  040b ae020e        	ldw	x,#526
 856  040e 89            	pushw	x
 857  040f 5f            	clrw	x
 858  0410 89            	pushw	x
 859  0411 ae000c        	ldw	x,#L31
 860  0414 cd0000        	call	_assert_failed
 862  0417 5b04          	addw	sp,#4
 863  0419               L403:
 864                     ; 528   if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
 865  0419 7b01          	ld	a,(OFST+1,sp)
 866  041b 2706          	jreq	L502
 867                     ; 531     CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
 868  041d 721050cd      	bset	20685,#0
 870  0421 2004          	jra	L702
 871  0423               L502:
 872                     ; 536     CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
 873  0423 721150cd      	bres	20685,#0
 874  0427               L702:
 875                     ; 538 }
 876  0427 84            	pop	a
 877  0428 81            	ret	
 879                     ; 547 void CLK_ClockSecuritySystemEnable(void)
 879                     ; 548 {
 880  0429               _CLK_ClockSecuritySystemEnable:
 882                     ; 550   CLK->CSSR |= CLK_CSSR_CSSEN;
 883  0429 721050c8      	bset	20680,#0
 884                     ; 551 }
 885  042d 81            	ret	
 887                     ; 559 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
 887                     ; 560 {
 888  042e               _CLK_GetSYSCLKSource:
 890                     ; 561   return((CLK_Source_TypeDef)CLK->CMSR);
 891  042e c650c3        	ld	a,20675
 893  0431 81            	ret	
 895                     ; 569 uint32_t CLK_GetClockFreq(void)
 895                     ; 570 {
 896  0432               _CLK_GetClockFreq:
 897  0432 5209          	subw	sp,#9
 898       00000009      OFST:	set	9
 900                     ; 571   uint32_t clockfrequency = 0;
 901                     ; 572   CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
 902                     ; 573   uint8_t tmp = 0, presc = 0;
 904                     ; 576   clocksource = (CLK_Source_TypeDef)CLK->CMSR;
 905  0434 c650c3        	ld	a,20675
 906  0437 6b09          	ld	(OFST+0,sp),a
 907                     ; 578   if (clocksource == CLK_SOURCE_HSI)
 908  0439 a1e1          	cp	a,#225
 909  043b 2634          	jrne	L112
 910                     ; 580     tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
 911  043d c650c6        	ld	a,20678
 912  0440 a418          	and	a,#24
 913  0442 44            	srl	a
 914  0443 44            	srl	a
 915  0444 44            	srl	a
 916                     ; 581     tmp = (uint8_t)(tmp >> 3);
 917                     ; 582     presc = HSIDivFactor[tmp];
 918  0445 5f            	clrw	x
 919  0446 97            	ld	xl,a
 920  0447 d60000        	ld	a,(_HSIDivFactor,x)
 921  044a 6b09          	ld	(OFST+0,sp),a
 922                     ; 583     clockfrequency = HSI_VALUE / presc;
 923  044c b703          	ld	c_lreg+3,a
 924  044e 3f02          	clr	c_lreg+2
 925  0450 3f01          	clr	c_lreg+1
 926  0452 3f00          	clr	c_lreg
 927  0454 96            	ldw	x,sp
 928  0455 5c            	incw	x
 929  0456 cd0000        	call	c_rtol
 931  0459 ae2400        	ldw	x,#9216
 932  045c bf02          	ldw	c_lreg+2,x
 933  045e ae00f4        	ldw	x,#244
 934  0461 bf00          	ldw	c_lreg,x
 935  0463 96            	ldw	x,sp
 936  0464 5c            	incw	x
 937  0465 cd0000        	call	c_ludv
 939  0468 96            	ldw	x,sp
 940  0469 1c0005        	addw	x,#OFST-4
 941  046c cd0000        	call	c_rtol
 944  046f 2018          	jra	L312
 945  0471               L112:
 946                     ; 585   else if ( clocksource == CLK_SOURCE_LSI)
 947  0471 a1d2          	cp	a,#210
 948  0473 260a          	jrne	L512
 949                     ; 587     clockfrequency = LSI_VALUE;
 950  0475 aef400        	ldw	x,#62464
 951  0478 1f07          	ldw	(OFST-2,sp),x
 952  047a ae0001        	ldw	x,#1
 954  047d 2008          	jp	LC009
 955  047f               L512:
 956                     ; 591     clockfrequency = HSE_VALUE;
 957  047f ae2400        	ldw	x,#9216
 958  0482 1f07          	ldw	(OFST-2,sp),x
 959  0484 ae00f4        	ldw	x,#244
 960  0487               LC009:
 961  0487 1f05          	ldw	(OFST-4,sp),x
 962  0489               L312:
 963                     ; 594   return((uint32_t)clockfrequency);
 964  0489 96            	ldw	x,sp
 965  048a 1c0005        	addw	x,#OFST-4
 966  048d cd0000        	call	c_ltor
 969  0490 5b09          	addw	sp,#9
 970  0492 81            	ret	
 972                     ; 604 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
 972                     ; 605 {
 973  0493               _CLK_AdjustHSICalibrationValue:
 974  0493 88            	push	a
 975       00000000      OFST:	set	0
 977                     ; 607   assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
 978  0494 4d            	tnz	a
 979  0495 272a          	jreq	L423
 980  0497 a101          	cp	a,#1
 981  0499 2726          	jreq	L423
 982  049b a102          	cp	a,#2
 983  049d 2722          	jreq	L423
 984  049f a103          	cp	a,#3
 985  04a1 271e          	jreq	L423
 986  04a3 a104          	cp	a,#4
 987  04a5 271a          	jreq	L423
 988  04a7 a105          	cp	a,#5
 989  04a9 2716          	jreq	L423
 990  04ab a106          	cp	a,#6
 991  04ad 2712          	jreq	L423
 992  04af a107          	cp	a,#7
 993  04b1 270e          	jreq	L423
 994  04b3 ae025f        	ldw	x,#607
 995  04b6 89            	pushw	x
 996  04b7 5f            	clrw	x
 997  04b8 89            	pushw	x
 998  04b9 ae000c        	ldw	x,#L31
 999  04bc cd0000        	call	_assert_failed
1001  04bf 5b04          	addw	sp,#4
1002  04c1               L423:
1003                     ; 610   CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
1004  04c1 c650cc        	ld	a,20684
1005  04c4 a4f8          	and	a,#248
1006  04c6 1a01          	or	a,(OFST+1,sp)
1007  04c8 c750cc        	ld	20684,a
1008                     ; 611 }
1009  04cb 84            	pop	a
1010  04cc 81            	ret	
1012                     ; 622 void CLK_SYSCLKEmergencyClear(void)
1012                     ; 623 {
1013  04cd               _CLK_SYSCLKEmergencyClear:
1015                     ; 624   CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
1016  04cd 721150c5      	bres	20677,#0
1017                     ; 625 }
1018  04d1 81            	ret	
1020                     ; 634 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
1020                     ; 635 {
1021  04d2               _CLK_GetFlagStatus:
1022  04d2 89            	pushw	x
1023  04d3 5203          	subw	sp,#3
1024       00000003      OFST:	set	3
1026                     ; 636   uint16_t statusreg = 0;
1027                     ; 637   uint8_t tmpreg = 0;
1028                     ; 638   FlagStatus bitstatus = RESET;
1029                     ; 641   assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
1030  04d5 a30110        	cpw	x,#272
1031  04d8 2736          	jreq	L043
1032  04da a30102        	cpw	x,#258
1033  04dd 2731          	jreq	L043
1034  04df a30202        	cpw	x,#514
1035  04e2 272c          	jreq	L043
1036  04e4 a30308        	cpw	x,#776
1037  04e7 2727          	jreq	L043
1038  04e9 a30301        	cpw	x,#769
1039  04ec 2722          	jreq	L043
1040  04ee a30408        	cpw	x,#1032
1041  04f1 271d          	jreq	L043
1042  04f3 a30402        	cpw	x,#1026
1043  04f6 2718          	jreq	L043
1044  04f8 a30504        	cpw	x,#1284
1045  04fb 2713          	jreq	L043
1046  04fd a30502        	cpw	x,#1282
1047  0500 270e          	jreq	L043
1048  0502 ae0281        	ldw	x,#641
1049  0505 89            	pushw	x
1050  0506 5f            	clrw	x
1051  0507 89            	pushw	x
1052  0508 ae000c        	ldw	x,#L31
1053  050b cd0000        	call	_assert_failed
1055  050e 5b04          	addw	sp,#4
1056  0510               L043:
1057                     ; 644   statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
1058  0510 7b04          	ld	a,(OFST+1,sp)
1059  0512 97            	ld	xl,a
1060  0513 4f            	clr	a
1061  0514 02            	rlwa	x,a
1062  0515 1f01          	ldw	(OFST-2,sp),x
1063                     ; 647   if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
1064  0517 a30100        	cpw	x,#256
1065  051a 2605          	jrne	L122
1066                     ; 649     tmpreg = CLK->ICKR;
1067  051c c650c0        	ld	a,20672
1069  051f 2021          	jra	L322
1070  0521               L122:
1071                     ; 651   else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
1072  0521 a30200        	cpw	x,#512
1073  0524 2605          	jrne	L522
1074                     ; 653     tmpreg = CLK->ECKR;
1075  0526 c650c1        	ld	a,20673
1077  0529 2017          	jra	L322
1078  052b               L522:
1079                     ; 655   else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
1080  052b a30300        	cpw	x,#768
1081  052e 2605          	jrne	L132
1082                     ; 657     tmpreg = CLK->SWCR;
1083  0530 c650c5        	ld	a,20677
1085  0533 200d          	jra	L322
1086  0535               L132:
1087                     ; 659   else if (statusreg == 0x0400) /* The flag to check is in CSS register */
1088  0535 a30400        	cpw	x,#1024
1089  0538 2605          	jrne	L532
1090                     ; 661     tmpreg = CLK->CSSR;
1091  053a c650c8        	ld	a,20680
1093  053d 2003          	jra	L322
1094  053f               L532:
1095                     ; 665     tmpreg = CLK->CCOR;
1096  053f c650c9        	ld	a,20681
1097  0542               L322:
1098  0542 6b03          	ld	(OFST+0,sp),a
1099                     ; 668   if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
1100  0544 7b05          	ld	a,(OFST+2,sp)
1101  0546 1503          	bcp	a,(OFST+0,sp)
1102  0548 2704          	jreq	L142
1103                     ; 670     bitstatus = SET;
1104  054a a601          	ld	a,#1
1106  054c 2001          	jra	L342
1107  054e               L142:
1108                     ; 674     bitstatus = RESET;
1109  054e 4f            	clr	a
1110  054f               L342:
1111                     ; 678   return((FlagStatus)bitstatus);
1113  054f 5b05          	addw	sp,#5
1114  0551 81            	ret	
1116                     ; 687 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
1116                     ; 688 {
1117  0552               _CLK_GetITStatus:
1118  0552 88            	push	a
1119  0553 88            	push	a
1120       00000001      OFST:	set	1
1122                     ; 689   ITStatus bitstatus = RESET;
1123                     ; 692   assert_param(IS_CLK_IT_OK(CLK_IT));
1124  0554 a10c          	cp	a,#12
1125  0556 2712          	jreq	L253
1126  0558 a11c          	cp	a,#28
1127  055a 270e          	jreq	L253
1128  055c ae02b4        	ldw	x,#692
1129  055f 89            	pushw	x
1130  0560 5f            	clrw	x
1131  0561 89            	pushw	x
1132  0562 ae000c        	ldw	x,#L31
1133  0565 cd0000        	call	_assert_failed
1135  0568 5b04          	addw	sp,#4
1136  056a               L253:
1137                     ; 694   if (CLK_IT == CLK_IT_SWIF)
1138  056a 7b02          	ld	a,(OFST+1,sp)
1139  056c a11c          	cp	a,#28
1140  056e 260b          	jrne	L542
1141                     ; 697     if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
1142  0570 c650c5        	ld	a,20677
1143  0573 1402          	and	a,(OFST+1,sp)
1144  0575 a10c          	cp	a,#12
1145  0577 260f          	jrne	L552
1146                     ; 699       bitstatus = SET;
1148  0579 2009          	jp	LC011
1149                     ; 703       bitstatus = RESET;
1150  057b               L542:
1151                     ; 709     if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
1152  057b c650c8        	ld	a,20680
1153  057e 1402          	and	a,(OFST+1,sp)
1154  0580 a10c          	cp	a,#12
1155  0582 2604          	jrne	L552
1156                     ; 711       bitstatus = SET;
1157  0584               LC011:
1158  0584 a601          	ld	a,#1
1160  0586 2001          	jra	L352
1161  0588               L552:
1162                     ; 715       bitstatus = RESET;
1163  0588 4f            	clr	a
1164  0589               L352:
1165                     ; 720   return bitstatus;
1167  0589 85            	popw	x
1168  058a 81            	ret	
1170                     ; 729 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
1170                     ; 730 {
1171  058b               _CLK_ClearITPendingBit:
1172  058b 88            	push	a
1173       00000000      OFST:	set	0
1175                     ; 732   assert_param(IS_CLK_IT_OK(CLK_IT));
1176  058c a10c          	cp	a,#12
1177  058e 2712          	jreq	L463
1178  0590 a11c          	cp	a,#28
1179  0592 270e          	jreq	L463
1180  0594 ae02dc        	ldw	x,#732
1181  0597 89            	pushw	x
1182  0598 5f            	clrw	x
1183  0599 89            	pushw	x
1184  059a ae000c        	ldw	x,#L31
1185  059d cd0000        	call	_assert_failed
1187  05a0 5b04          	addw	sp,#4
1188  05a2               L463:
1189                     ; 734   if (CLK_IT == (uint8_t)CLK_IT_CSSD)
1190  05a2 7b01          	ld	a,(OFST+1,sp)
1191  05a4 a10c          	cp	a,#12
1192  05a6 2606          	jrne	L162
1193                     ; 737     CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
1194  05a8 721750c8      	bres	20680,#3
1196  05ac 2004          	jra	L362
1197  05ae               L162:
1198                     ; 742     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
1199  05ae 721750c5      	bres	20677,#3
1200  05b2               L362:
1201                     ; 745 }
1202  05b2 84            	pop	a
1203  05b3 81            	ret	
1205                     	xdef	_CLKPrescTable
1206                     	xdef	_HSIDivFactor
1207                     	xdef	_CLK_ClearITPendingBit
1208                     	xdef	_CLK_GetITStatus
1209                     	xdef	_CLK_GetFlagStatus
1210                     	xdef	_CLK_GetSYSCLKSource
1211                     	xdef	_CLK_GetClockFreq
1212                     	xdef	_CLK_AdjustHSICalibrationValue
1213                     	xdef	_CLK_SYSCLKEmergencyClear
1214                     	xdef	_CLK_ClockSecuritySystemEnable
1215                     	xdef	_CLK_SWIMConfig
1216                     	xdef	_CLK_SYSCLKConfig
1217                     	xdef	_CLK_ITConfig
1218                     	xdef	_CLK_CCOConfig
1219                     	xdef	_CLK_HSIPrescalerConfig
1220                     	xdef	_CLK_ClockSwitchConfig
1221                     	xdef	_CLK_PeripheralClockConfig
1222                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
1223                     	xdef	_CLK_FastHaltWakeUpCmd
1224                     	xdef	_CLK_ClockSwitchCmd
1225                     	xdef	_CLK_CCOCmd
1226                     	xdef	_CLK_LSICmd
1227                     	xdef	_CLK_HSICmd
1228                     	xdef	_CLK_HSECmd
1229                     	xdef	_CLK_DeInit
1230                     	xref	_assert_failed
1231                     	switch	.const
1232  000c               L31:
1233  000c 7372635c7374  	dc.b	"src\stm8s_clk.c",0
1234                     	xref.b	c_lreg
1235                     	xref.b	c_x
1236                     	xref	c_ltor
1237                     	xref	c_ludv
1238                     	xref	c_rtol
1239                     	end
