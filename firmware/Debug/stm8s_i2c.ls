   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     ; 67 void I2C_DeInit(void)
  19                     ; 68 {
  20                     	scross	off
  21  0000               _I2C_DeInit:
  23                     ; 69   I2C->CR1 = I2C_CR1_RESET_VALUE;
  24  0000 725f5210      	clr	21008
  25                     ; 70   I2C->CR2 = I2C_CR2_RESET_VALUE;
  26  0004 725f5211      	clr	21009
  27                     ; 71   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  28  0008 725f5212      	clr	21010
  29                     ; 72   I2C->OARL = I2C_OARL_RESET_VALUE;
  30  000c 725f5213      	clr	21011
  31                     ; 73   I2C->OARH = I2C_OARH_RESET_VALUE;
  32  0010 725f5214      	clr	21012
  33                     ; 74   I2C->ITR = I2C_ITR_RESET_VALUE;
  34  0014 725f521a      	clr	21018
  35                     ; 75   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  36  0018 725f521b      	clr	21019
  37                     ; 76   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  38  001c 725f521c      	clr	21020
  39                     ; 77   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  40  0020 3502521d      	mov	21021,#2
  41                     ; 78 }
  42  0024 81            	ret	
  44                     .const:	section	.text
  45  0000               L45:
  46  0000 00061a81      	dc.l	400001
  47  0004               L26:
  48  0004 000186a1      	dc.l	100001
  49  0008               L46:
  50  0008 000f4240      	dc.l	1000000
  51                     ; 96 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
  51                     ; 97               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
  51                     ; 98               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
  51                     ; 99 {
  52                     	switch	.text
  53  0025               _I2C_Init:
  54  0025 5209          	subw	sp,#9
  55       00000009      OFST:	set	9
  57                     ; 100   uint16_t result = 0x0004;
  58                     ; 101   uint16_t tmpval = 0;
  59                     ; 102   uint8_t tmpccrh = 0;
  60  0027 0f07          	clr	(OFST-2,sp)
  61                     ; 105   assert_param(IS_I2C_ACK_OK(Ack));
  62  0029 7b13          	ld	a,(OFST+10,sp)
  63  002b 270e          	jreq	L21
  64  002d a101          	cp	a,#1
  65  002f 270a          	jreq	L21
  66  0031 a102          	cp	a,#2
  67  0033 2706          	jreq	L21
  68  0035 ae0069        	ldw	x,#105
  69  0038 cd017d        	call	LC001
  70  003b               L21:
  71                     ; 106   assert_param(IS_I2C_ADDMODE_OK(AddMode));
  72  003b 7b14          	ld	a,(OFST+11,sp)
  73  003d 270a          	jreq	L22
  74  003f a180          	cp	a,#128
  75  0041 2706          	jreq	L22
  76  0043 ae006a        	ldw	x,#106
  77  0046 cd017d        	call	LC001
  78  0049               L22:
  79                     ; 107   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
  80  0049 1e10          	ldw	x,(OFST+7,sp)
  81  004b a30400        	cpw	x,#1024
  82  004e 2506          	jrult	L03
  83  0050 ae006b        	ldw	x,#107
  84  0053 cd017d        	call	LC001
  85  0056               L03:
  86                     ; 108   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
  87  0056 7b12          	ld	a,(OFST+9,sp)
  88  0058 270a          	jreq	L04
  89  005a a140          	cp	a,#64
  90  005c 2706          	jreq	L04
  91  005e ae006c        	ldw	x,#108
  92  0061 cd017d        	call	LC001
  93  0064               L04:
  94                     ; 109   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
  95  0064 7b15          	ld	a,(OFST+12,sp)
  96  0066 2704          	jreq	L44
  97  0068 a111          	cp	a,#17
  98  006a 2506          	jrult	L64
  99  006c               L44:
 100  006c ae006d        	ldw	x,#109
 101  006f cd017d        	call	LC001
 102  0072               L64:
 103                     ; 110   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 104  0072 96            	ldw	x,sp
 105  0073 1c000c        	addw	x,#OFST+3
 106  0076 cd0000        	call	c_lzmp
 108  0079 270f          	jreq	L25
 109  007b 96            	ldw	x,sp
 110  007c 1c000c        	addw	x,#OFST+3
 111  007f cd0000        	call	c_ltor
 113  0082 ae0000        	ldw	x,#L45
 114  0085 cd0000        	call	c_lcmp
 116  0088 2506          	jrult	L65
 117  008a               L25:
 118  008a ae006e        	ldw	x,#110
 119  008d cd017d        	call	LC001
 120  0090               L65:
 121                     ; 115   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 122  0090 c65212        	ld	a,21010
 123  0093 a4c0          	and	a,#192
 124  0095 c75212        	ld	21010,a
 125                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 126  0098 c65212        	ld	a,21010
 127  009b 1a15          	or	a,(OFST+12,sp)
 128  009d c75212        	ld	21010,a
 129                     ; 121   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 130  00a0 72115210      	bres	21008,#0
 131                     ; 124   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 132  00a4 c6521c        	ld	a,21020
 133  00a7 a430          	and	a,#48
 134  00a9 c7521c        	ld	21020,a
 135                     ; 125   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 136  00ac 725f521b      	clr	21019
 137                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 138  00b0 96            	ldw	x,sp
 139  00b1 1c000c        	addw	x,#OFST+3
 140  00b4 cd0000        	call	c_ltor
 142  00b7 ae0004        	ldw	x,#L26
 143  00ba cd0000        	call	c_lcmp
 145  00bd 2560          	jrult	L5
 146                     ; 131     tmpccrh = I2C_CCRH_FS;
 147  00bf a680          	ld	a,#128
 148  00c1 6b07          	ld	(OFST-2,sp),a
 149                     ; 133     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 150  00c3 96            	ldw	x,sp
 151  00c4 0d12          	tnz	(OFST+9,sp)
 152  00c6 261d          	jrne	L7
 153                     ; 136       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 154  00c8 1c000c        	addw	x,#OFST+3
 155  00cb cd0000        	call	c_ltor
 157  00ce a603          	ld	a,#3
 158  00d0 cd0000        	call	c_smul
 160  00d3 96            	ldw	x,sp
 161  00d4 5c            	incw	x
 162  00d5 cd0000        	call	c_rtol
 164  00d8 7b15          	ld	a,(OFST+12,sp)
 165  00da cd0189        	call	LC002
 167  00dd 96            	ldw	x,sp
 168  00de cd0197        	call	LC003
 169  00e1 1f08          	ldw	(OFST-1,sp),x
 171  00e3 2021          	jra	L11
 172  00e5               L7:
 173                     ; 141       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 174  00e5 1c000c        	addw	x,#OFST+3
 175  00e8 cd0000        	call	c_ltor
 177  00eb a619          	ld	a,#25
 178  00ed cd0000        	call	c_smul
 180  00f0 96            	ldw	x,sp
 181  00f1 5c            	incw	x
 182  00f2 cd0000        	call	c_rtol
 184  00f5 7b15          	ld	a,(OFST+12,sp)
 185  00f7 cd0189        	call	LC002
 187  00fa 96            	ldw	x,sp
 188  00fb cd0197        	call	LC003
 189  00fe 1f08          	ldw	(OFST-1,sp),x
 190                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 191  0100 7b07          	ld	a,(OFST-2,sp)
 192  0102 aa40          	or	a,#64
 193  0104 6b07          	ld	(OFST-2,sp),a
 194  0106               L11:
 195                     ; 147     if (result < (uint16_t)0x01)
 196  0106 1e08          	ldw	x,(OFST-1,sp)
 197  0108 2603          	jrne	L31
 198                     ; 150       result = (uint16_t)0x0001;
 199  010a 5c            	incw	x
 200  010b 1f08          	ldw	(OFST-1,sp),x
 201  010d               L31:
 202                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 203  010d 7b15          	ld	a,(OFST+12,sp)
 204  010f 97            	ld	xl,a
 205  0110 a603          	ld	a,#3
 206  0112 42            	mul	x,a
 207  0113 a60a          	ld	a,#10
 208  0115 cd0000        	call	c_sdivx
 210  0118 5c            	incw	x
 211  0119 1f05          	ldw	(OFST-4,sp),x
 212                     ; 157     I2C->TRISER = (uint8_t)tmpval;
 213  011b 7b06          	ld	a,(OFST-3,sp)
 215  011d 2028          	jra	L51
 216  011f               L5:
 217                     ; 164     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 218  011f 96            	ldw	x,sp
 219  0120 1c000c        	addw	x,#OFST+3
 220  0123 cd0000        	call	c_ltor
 222  0126 3803          	sll	c_lreg+3
 223  0128 3902          	rlc	c_lreg+2
 224  012a 3901          	rlc	c_lreg+1
 225  012c 96            	ldw	x,sp
 226  012d 3900          	rlc	c_lreg
 227  012f 5c            	incw	x
 228  0130 cd0000        	call	c_rtol
 230  0133 7b15          	ld	a,(OFST+12,sp)
 231  0135 ad52          	call	LC002
 233  0137 96            	ldw	x,sp
 234  0138 ad5d          	call	LC003
 235                     ; 167     if (result < (uint16_t)0x0004)
 236  013a a30004        	cpw	x,#4
 237  013d 2403          	jruge	L71
 238                     ; 170       result = (uint16_t)0x0004;
 239  013f ae0004        	ldw	x,#4
 240  0142               L71:
 241  0142 1f08          	ldw	(OFST-1,sp),x
 242                     ; 176     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 243  0144 7b15          	ld	a,(OFST+12,sp)
 244  0146 4c            	inc	a
 245  0147               L51:
 246  0147 c7521d        	ld	21021,a
 247                     ; 181   I2C->CCRL = (uint8_t)result;
 248  014a 7b09          	ld	a,(OFST+0,sp)
 249  014c c7521b        	ld	21019,a
 250                     ; 182   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 251  014f 7b08          	ld	a,(OFST-1,sp)
 252  0151 a40f          	and	a,#15
 253  0153 1a07          	or	a,(OFST-2,sp)
 254  0155 c7521c        	ld	21020,a
 255                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 256  0158 72105210      	bset	21008,#0
 257                     ; 188   I2C_AcknowledgeConfig(Ack);
 258  015c 7b13          	ld	a,(OFST+10,sp)
 259  015e cd027c        	call	_I2C_AcknowledgeConfig
 261                     ; 191   I2C->OARL = (uint8_t)(OwnAddress);
 262  0161 7b11          	ld	a,(OFST+8,sp)
 263  0163 c75213        	ld	21011,a
 264                     ; 192   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 264                     ; 193                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 265  0166 1e10          	ldw	x,(OFST+7,sp)
 266  0168 4f            	clr	a
 267  0169 01            	rrwa	x,a
 268  016a 48            	sll	a
 269  016b 01            	rrwa	x,a
 270  016c 49            	rlc	a
 271  016d a406          	and	a,#6
 272  016f 6b04          	ld	(OFST-5,sp),a
 273  0171 7b14          	ld	a,(OFST+11,sp)
 274  0173 aa40          	or	a,#64
 275  0175 1a04          	or	a,(OFST-5,sp)
 276  0177 c75214        	ld	21012,a
 277                     ; 194 }
 278  017a 5b09          	addw	sp,#9
 279  017c 81            	ret	
 280  017d               LC001:
 281  017d 89            	pushw	x
 282  017e 5f            	clrw	x
 283  017f 89            	pushw	x
 284  0180 ae000c        	ldw	x,#L3
 285  0183 cd0000        	call	_assert_failed
 287  0186 5b04          	addw	sp,#4
 288  0188 81            	ret	
 289  0189               LC002:
 290  0189 b703          	ld	c_lreg+3,a
 291  018b 3f02          	clr	c_lreg+2
 292  018d 3f01          	clr	c_lreg+1
 293  018f 3f00          	clr	c_lreg
 294  0191 ae0008        	ldw	x,#L46
 295  0194 cc0000        	jp	c_lmul
 296  0197               LC003:
 297  0197 5c            	incw	x
 298  0198 cd0000        	call	c_ludv
 300  019b be02          	ldw	x,c_lreg+2
 301  019d 81            	ret	
 303                     ; 202 void I2C_Cmd(FunctionalState NewState)
 303                     ; 203 {
 304  019e               _I2C_Cmd:
 305  019e 88            	push	a
 306       00000000      OFST:	set	0
 308                     ; 205   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 309  019f 4d            	tnz	a
 310  01a0 2711          	jreq	L67
 311  01a2 4a            	dec	a
 312  01a3 270e          	jreq	L67
 313  01a5 ae00cd        	ldw	x,#205
 314  01a8 89            	pushw	x
 315  01a9 5f            	clrw	x
 316  01aa 89            	pushw	x
 317  01ab ae000c        	ldw	x,#L3
 318  01ae cd0000        	call	_assert_failed
 320  01b1 5b04          	addw	sp,#4
 321  01b3               L67:
 322                     ; 207   if (NewState != DISABLE)
 323  01b3 7b01          	ld	a,(OFST+1,sp)
 324  01b5 2706          	jreq	L12
 325                     ; 210     I2C->CR1 |= I2C_CR1_PE;
 326  01b7 72105210      	bset	21008,#0
 328  01bb 2004          	jra	L32
 329  01bd               L12:
 330                     ; 215     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 331  01bd 72115210      	bres	21008,#0
 332  01c1               L32:
 333                     ; 217 }
 334  01c1 84            	pop	a
 335  01c2 81            	ret	
 337                     ; 225 void I2C_GeneralCallCmd(FunctionalState NewState)
 337                     ; 226 {
 338  01c3               _I2C_GeneralCallCmd:
 339  01c3 88            	push	a
 340       00000000      OFST:	set	0
 342                     ; 228   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 343  01c4 4d            	tnz	a
 344  01c5 2711          	jreq	L011
 345  01c7 4a            	dec	a
 346  01c8 270e          	jreq	L011
 347  01ca ae00e4        	ldw	x,#228
 348  01cd 89            	pushw	x
 349  01ce 5f            	clrw	x
 350  01cf 89            	pushw	x
 351  01d0 ae000c        	ldw	x,#L3
 352  01d3 cd0000        	call	_assert_failed
 354  01d6 5b04          	addw	sp,#4
 355  01d8               L011:
 356                     ; 230   if (NewState != DISABLE)
 357  01d8 7b01          	ld	a,(OFST+1,sp)
 358  01da 2706          	jreq	L52
 359                     ; 233     I2C->CR1 |= I2C_CR1_ENGC;
 360  01dc 721c5210      	bset	21008,#6
 362  01e0 2004          	jra	L72
 363  01e2               L52:
 364                     ; 238     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 365  01e2 721d5210      	bres	21008,#6
 366  01e6               L72:
 367                     ; 240 }
 368  01e6 84            	pop	a
 369  01e7 81            	ret	
 371                     ; 250 void I2C_GenerateSTART(FunctionalState NewState)
 371                     ; 251 {
 372  01e8               _I2C_GenerateSTART:
 373  01e8 88            	push	a
 374       00000000      OFST:	set	0
 376                     ; 253   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 377  01e9 4d            	tnz	a
 378  01ea 2711          	jreq	L221
 379  01ec 4a            	dec	a
 380  01ed 270e          	jreq	L221
 381  01ef ae00fd        	ldw	x,#253
 382  01f2 89            	pushw	x
 383  01f3 5f            	clrw	x
 384  01f4 89            	pushw	x
 385  01f5 ae000c        	ldw	x,#L3
 386  01f8 cd0000        	call	_assert_failed
 388  01fb 5b04          	addw	sp,#4
 389  01fd               L221:
 390                     ; 255   if (NewState != DISABLE)
 391  01fd 7b01          	ld	a,(OFST+1,sp)
 392  01ff 2706          	jreq	L13
 393                     ; 258     I2C->CR2 |= I2C_CR2_START;
 394  0201 72105211      	bset	21009,#0
 396  0205 2004          	jra	L33
 397  0207               L13:
 398                     ; 263     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 399  0207 72115211      	bres	21009,#0
 400  020b               L33:
 401                     ; 265 }
 402  020b 84            	pop	a
 403  020c 81            	ret	
 405                     ; 273 void I2C_GenerateSTOP(FunctionalState NewState)
 405                     ; 274 {
 406  020d               _I2C_GenerateSTOP:
 407  020d 88            	push	a
 408       00000000      OFST:	set	0
 410                     ; 276   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 411  020e 4d            	tnz	a
 412  020f 2711          	jreq	L431
 413  0211 4a            	dec	a
 414  0212 270e          	jreq	L431
 415  0214 ae0114        	ldw	x,#276
 416  0217 89            	pushw	x
 417  0218 5f            	clrw	x
 418  0219 89            	pushw	x
 419  021a ae000c        	ldw	x,#L3
 420  021d cd0000        	call	_assert_failed
 422  0220 5b04          	addw	sp,#4
 423  0222               L431:
 424                     ; 278   if (NewState != DISABLE)
 425  0222 7b01          	ld	a,(OFST+1,sp)
 426  0224 2706          	jreq	L53
 427                     ; 281     I2C->CR2 |= I2C_CR2_STOP;
 428  0226 72125211      	bset	21009,#1
 430  022a 2004          	jra	L73
 431  022c               L53:
 432                     ; 286     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 433  022c 72135211      	bres	21009,#1
 434  0230               L73:
 435                     ; 288 }
 436  0230 84            	pop	a
 437  0231 81            	ret	
 439                     ; 296 void I2C_SoftwareResetCmd(FunctionalState NewState)
 439                     ; 297 {
 440  0232               _I2C_SoftwareResetCmd:
 441  0232 88            	push	a
 442       00000000      OFST:	set	0
 444                     ; 299   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 445  0233 4d            	tnz	a
 446  0234 2711          	jreq	L641
 447  0236 4a            	dec	a
 448  0237 270e          	jreq	L641
 449  0239 ae012b        	ldw	x,#299
 450  023c 89            	pushw	x
 451  023d 5f            	clrw	x
 452  023e 89            	pushw	x
 453  023f ae000c        	ldw	x,#L3
 454  0242 cd0000        	call	_assert_failed
 456  0245 5b04          	addw	sp,#4
 457  0247               L641:
 458                     ; 301   if (NewState != DISABLE)
 459  0247 7b01          	ld	a,(OFST+1,sp)
 460  0249 2706          	jreq	L14
 461                     ; 304     I2C->CR2 |= I2C_CR2_SWRST;
 462  024b 721e5211      	bset	21009,#7
 464  024f 2004          	jra	L34
 465  0251               L14:
 466                     ; 309     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
 467  0251 721f5211      	bres	21009,#7
 468  0255               L34:
 469                     ; 311 }
 470  0255 84            	pop	a
 471  0256 81            	ret	
 473                     ; 320 void I2C_StretchClockCmd(FunctionalState NewState)
 473                     ; 321 {
 474  0257               _I2C_StretchClockCmd:
 475  0257 88            	push	a
 476       00000000      OFST:	set	0
 478                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 479  0258 4d            	tnz	a
 480  0259 2711          	jreq	L061
 481  025b 4a            	dec	a
 482  025c 270e          	jreq	L061
 483  025e ae0143        	ldw	x,#323
 484  0261 89            	pushw	x
 485  0262 5f            	clrw	x
 486  0263 89            	pushw	x
 487  0264 ae000c        	ldw	x,#L3
 488  0267 cd0000        	call	_assert_failed
 490  026a 5b04          	addw	sp,#4
 491  026c               L061:
 492                     ; 325   if (NewState != DISABLE)
 493  026c 7b01          	ld	a,(OFST+1,sp)
 494  026e 2706          	jreq	L54
 495                     ; 328     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
 496  0270 721f5210      	bres	21008,#7
 498  0274 2004          	jra	L74
 499  0276               L54:
 500                     ; 334     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 501  0276 721e5210      	bset	21008,#7
 502  027a               L74:
 503                     ; 336 }
 504  027a 84            	pop	a
 505  027b 81            	ret	
 507                     ; 345 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 507                     ; 346 {
 508  027c               _I2C_AcknowledgeConfig:
 509  027c 88            	push	a
 510       00000000      OFST:	set	0
 512                     ; 348   assert_param(IS_I2C_ACK_OK(Ack));
 513  027d 4d            	tnz	a
 514  027e 2716          	jreq	L271
 515  0280 a101          	cp	a,#1
 516  0282 2712          	jreq	L271
 517  0284 a102          	cp	a,#2
 518  0286 270e          	jreq	L271
 519  0288 ae015c        	ldw	x,#348
 520  028b 89            	pushw	x
 521  028c 5f            	clrw	x
 522  028d 89            	pushw	x
 523  028e ae000c        	ldw	x,#L3
 524  0291 cd0000        	call	_assert_failed
 526  0294 5b04          	addw	sp,#4
 527  0296               L271:
 528                     ; 350   if (Ack == I2C_ACK_NONE)
 529  0296 7b01          	ld	a,(OFST+1,sp)
 530  0298 2606          	jrne	L15
 531                     ; 353     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
 532  029a 72155211      	bres	21009,#2
 534  029e 2011          	jra	L35
 535  02a0               L15:
 536                     ; 358     I2C->CR2 |= I2C_CR2_ACK;
 537  02a0 72145211      	bset	21009,#2
 538                     ; 360     if (Ack == I2C_ACK_CURR)
 539  02a4 4a            	dec	a
 540  02a5 2606          	jrne	L55
 541                     ; 363       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 542  02a7 72175211      	bres	21009,#3
 544  02ab 2004          	jra	L35
 545  02ad               L55:
 546                     ; 368       I2C->CR2 |= I2C_CR2_POS;
 547  02ad 72165211      	bset	21009,#3
 548  02b1               L35:
 549                     ; 371 }
 550  02b1 84            	pop	a
 551  02b2 81            	ret	
 553                     ; 381 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
 553                     ; 382 {
 554  02b3               _I2C_ITConfig:
 555  02b3 89            	pushw	x
 556       00000000      OFST:	set	0
 558                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
 559  02b4 9e            	ld	a,xh
 560  02b5 4a            	dec	a
 561  02b6 2723          	jreq	L402
 562  02b8 9e            	ld	a,xh
 563  02b9 a102          	cp	a,#2
 564  02bb 271e          	jreq	L402
 565  02bd 9e            	ld	a,xh
 566  02be a104          	cp	a,#4
 567  02c0 2719          	jreq	L402
 568  02c2 9e            	ld	a,xh
 569  02c3 a103          	cp	a,#3
 570  02c5 2714          	jreq	L402
 571  02c7 9e            	ld	a,xh
 572  02c8 a105          	cp	a,#5
 573  02ca 270f          	jreq	L402
 574  02cc 9e            	ld	a,xh
 575  02cd a106          	cp	a,#6
 576  02cf 270a          	jreq	L402
 577  02d1 9e            	ld	a,xh
 578  02d2 a107          	cp	a,#7
 579  02d4 2705          	jreq	L402
 580  02d6 ae0180        	ldw	x,#384
 581  02d9 ad22          	call	LC004
 582  02db               L402:
 583                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 584  02db 7b02          	ld	a,(OFST+2,sp)
 585  02dd 2708          	jreq	L412
 586  02df 4a            	dec	a
 587  02e0 2705          	jreq	L412
 588  02e2 ae0181        	ldw	x,#385
 589  02e5 ad16          	call	LC004
 590  02e7               L412:
 591                     ; 387   if (NewState != DISABLE)
 592  02e7 7b02          	ld	a,(OFST+2,sp)
 593  02e9 2707          	jreq	L16
 594                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
 595  02eb c6521a        	ld	a,21018
 596  02ee 1a01          	or	a,(OFST+1,sp)
 598  02f0 2006          	jra	L36
 599  02f2               L16:
 600                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
 601  02f2 7b01          	ld	a,(OFST+1,sp)
 602  02f4 43            	cpl	a
 603  02f5 c4521a        	and	a,21018
 604  02f8               L36:
 605  02f8 c7521a        	ld	21018,a
 606                     ; 397 }
 607  02fb 85            	popw	x
 608  02fc 81            	ret	
 609  02fd               LC004:
 610  02fd 89            	pushw	x
 611  02fe 5f            	clrw	x
 612  02ff 89            	pushw	x
 613  0300 ae000c        	ldw	x,#L3
 614  0303 cd0000        	call	_assert_failed
 616  0306 5b04          	addw	sp,#4
 617  0308 81            	ret	
 619                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
 619                     ; 406 {
 620  0309               _I2C_FastModeDutyCycleConfig:
 621  0309 88            	push	a
 622       00000000      OFST:	set	0
 624                     ; 408   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
 625  030a 4d            	tnz	a
 626  030b 2712          	jreq	L622
 627  030d a140          	cp	a,#64
 628  030f 270e          	jreq	L622
 629  0311 ae0198        	ldw	x,#408
 630  0314 89            	pushw	x
 631  0315 5f            	clrw	x
 632  0316 89            	pushw	x
 633  0317 ae000c        	ldw	x,#L3
 634  031a cd0000        	call	_assert_failed
 636  031d 5b04          	addw	sp,#4
 637  031f               L622:
 638                     ; 410   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
 639  031f 7b01          	ld	a,(OFST+1,sp)
 640  0321 a140          	cp	a,#64
 641  0323 2606          	jrne	L56
 642                     ; 413     I2C->CCRH |= I2C_CCRH_DUTY;
 643  0325 721c521c      	bset	21020,#6
 645  0329 2004          	jra	L76
 646  032b               L56:
 647                     ; 418     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
 648  032b 721d521c      	bres	21020,#6
 649  032f               L76:
 650                     ; 420 }
 651  032f 84            	pop	a
 652  0330 81            	ret	
 654                     ; 427 uint8_t I2C_ReceiveData(void)
 654                     ; 428 {
 655  0331               _I2C_ReceiveData:
 657                     ; 430   return ((uint8_t)I2C->DR);
 658  0331 c65216        	ld	a,21014
 660  0334 81            	ret	
 662                     ; 440 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
 662                     ; 441 {
 663  0335               _I2C_Send7bitAddress:
 664  0335 89            	pushw	x
 665       00000000      OFST:	set	0
 667                     ; 443   assert_param(IS_I2C_ADDRESS_OK(Address));
 668  0336 9e            	ld	a,xh
 669  0337 a501          	bcp	a,#1
 670  0339 2705          	jreq	L042
 671  033b ae01bb        	ldw	x,#443
 672  033e ad19          	call	LC005
 673  0340               L042:
 674                     ; 444   assert_param(IS_I2C_DIRECTION_OK(Direction));
 675  0340 7b02          	ld	a,(OFST+2,sp)
 676  0342 2708          	jreq	L052
 677  0344 4a            	dec	a
 678  0345 2705          	jreq	L052
 679  0347 ae01bc        	ldw	x,#444
 680  034a ad0d          	call	LC005
 681  034c               L052:
 682                     ; 447   Address &= (uint8_t)0xFE;
 683  034c 7b01          	ld	a,(OFST+1,sp)
 684  034e a4fe          	and	a,#254
 685  0350 6b01          	ld	(OFST+1,sp),a
 686                     ; 450   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
 687  0352 1a02          	or	a,(OFST+2,sp)
 688  0354 c75216        	ld	21014,a
 689                     ; 451 }
 690  0357 85            	popw	x
 691  0358 81            	ret	
 692  0359               LC005:
 693  0359 89            	pushw	x
 694  035a 5f            	clrw	x
 695  035b 89            	pushw	x
 696  035c ae000c        	ldw	x,#L3
 697  035f cd0000        	call	_assert_failed
 699  0362 5b04          	addw	sp,#4
 700  0364 81            	ret	
 702                     ; 458 void I2C_SendData(uint8_t Data)
 702                     ; 459 {
 703  0365               _I2C_SendData:
 705                     ; 461   I2C->DR = Data;
 706  0365 c75216        	ld	21014,a
 707                     ; 462 }
 708  0368 81            	ret	
 710                     ; 578 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
 710                     ; 579 {
 711  0369               _I2C_CheckEvent:
 712  0369 89            	pushw	x
 713  036a 5206          	subw	sp,#6
 714       00000006      OFST:	set	6
 716                     ; 580   __IO uint16_t lastevent = 0x00;
 717  036c 5f            	clrw	x
 718  036d 1f04          	ldw	(OFST-2,sp),x
 719                     ; 581   uint8_t flag1 = 0x00 ;
 720                     ; 582   uint8_t flag2 = 0x00;
 721                     ; 583   ErrorStatus status = ERROR;
 722                     ; 586   assert_param(IS_I2C_EVENT_OK(I2C_Event));
 723  036f 1e07          	ldw	x,(OFST+1,sp)
 724  0371 a30682        	cpw	x,#1666
 725  0374 275b          	jreq	L462
 726  0376 a30202        	cpw	x,#514
 727  0379 2756          	jreq	L462
 728  037b a31200        	cpw	x,#4608
 729  037e 2751          	jreq	L462
 730  0380 a30240        	cpw	x,#576
 731  0383 274c          	jreq	L462
 732  0385 a30350        	cpw	x,#848
 733  0388 2747          	jreq	L462
 734  038a a30684        	cpw	x,#1668
 735  038d 2742          	jreq	L462
 736  038f a30794        	cpw	x,#1940
 737  0392 273d          	jreq	L462
 738  0394 a30004        	cpw	x,#4
 739  0397 2738          	jreq	L462
 740  0399 a30010        	cpw	x,#16
 741  039c 2733          	jreq	L462
 742  039e a30301        	cpw	x,#769
 743  03a1 272e          	jreq	L462
 744  03a3 a30782        	cpw	x,#1922
 745  03a6 2729          	jreq	L462
 746  03a8 a30302        	cpw	x,#770
 747  03ab 2724          	jreq	L462
 748  03ad a30340        	cpw	x,#832
 749  03b0 271f          	jreq	L462
 750  03b2 a30784        	cpw	x,#1924
 751  03b5 271a          	jreq	L462
 752  03b7 a30780        	cpw	x,#1920
 753  03ba 2715          	jreq	L462
 754  03bc a30308        	cpw	x,#776
 755  03bf 2710          	jreq	L462
 756  03c1 ae024a        	ldw	x,#586
 757  03c4 89            	pushw	x
 758  03c5 5f            	clrw	x
 759  03c6 89            	pushw	x
 760  03c7 ae000c        	ldw	x,#L3
 761  03ca cd0000        	call	_assert_failed
 763  03cd 5b04          	addw	sp,#4
 764  03cf 1e07          	ldw	x,(OFST+1,sp)
 765  03d1               L462:
 766                     ; 588   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
 767  03d1 a30004        	cpw	x,#4
 768  03d4 2609          	jrne	L17
 769                     ; 590     lastevent = I2C->SR2 & I2C_SR2_AF;
 770  03d6 c65218        	ld	a,21016
 771  03d9 a404          	and	a,#4
 772  03db 5f            	clrw	x
 773  03dc 97            	ld	xl,a
 775  03dd 201a          	jra	L37
 776  03df               L17:
 777                     ; 594     flag1 = I2C->SR1;
 778  03df c65217        	ld	a,21015
 779  03e2 6b03          	ld	(OFST-3,sp),a
 780                     ; 595     flag2 = I2C->SR3;
 781  03e4 c65219        	ld	a,21017
 782  03e7 6b06          	ld	(OFST+0,sp),a
 783                     ; 596     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
 784  03e9 5f            	clrw	x
 785  03ea 7b03          	ld	a,(OFST-3,sp)
 786  03ec 97            	ld	xl,a
 787  03ed 1f01          	ldw	(OFST-5,sp),x
 788  03ef 5f            	clrw	x
 789  03f0 7b06          	ld	a,(OFST+0,sp)
 790  03f2 97            	ld	xl,a
 791  03f3 7b02          	ld	a,(OFST-4,sp)
 792  03f5 01            	rrwa	x,a
 793  03f6 1a01          	or	a,(OFST-5,sp)
 794  03f8 01            	rrwa	x,a
 795  03f9               L37:
 796  03f9 1f04          	ldw	(OFST-2,sp),x
 797                     ; 599   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
 798  03fb 1e04          	ldw	x,(OFST-2,sp)
 799  03fd 01            	rrwa	x,a
 800  03fe 1408          	and	a,(OFST+2,sp)
 801  0400 01            	rrwa	x,a
 802  0401 1407          	and	a,(OFST+1,sp)
 803  0403 01            	rrwa	x,a
 804  0404 1307          	cpw	x,(OFST+1,sp)
 805  0406 2604          	jrne	L57
 806                     ; 602     status = SUCCESS;
 807  0408 a601          	ld	a,#1
 809  040a 2001          	jra	L77
 810  040c               L57:
 811                     ; 607     status = ERROR;
 812  040c 4f            	clr	a
 813  040d               L77:
 814                     ; 611   return status;
 816  040d 5b08          	addw	sp,#8
 817  040f 81            	ret	
 819                     ; 628 I2C_Event_TypeDef I2C_GetLastEvent(void)
 819                     ; 629 {
 820  0410               _I2C_GetLastEvent:
 821  0410 5206          	subw	sp,#6
 822       00000006      OFST:	set	6
 824                     ; 630   __IO uint16_t lastevent = 0;
 825  0412 5f            	clrw	x
 826  0413 1f05          	ldw	(OFST-1,sp),x
 827                     ; 631   uint16_t flag1 = 0;
 828                     ; 632   uint16_t flag2 = 0;
 829                     ; 634   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
 830  0415 7205521805    	btjf	21016,#2,L101
 831                     ; 636     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
 832  041a ae0004        	ldw	x,#4
 834  041d 2013          	jra	L301
 835  041f               L101:
 836                     ; 641     flag1 = I2C->SR1;
 837  041f c65217        	ld	a,21015
 838  0422 97            	ld	xl,a
 839  0423 1f01          	ldw	(OFST-5,sp),x
 840                     ; 642     flag2 = I2C->SR3;
 841  0425 c65219        	ld	a,21017
 842  0428 5f            	clrw	x
 843  0429 97            	ld	xl,a
 844  042a 1f03          	ldw	(OFST-3,sp),x
 845                     ; 645     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
 846  042c 7b02          	ld	a,(OFST-4,sp)
 847  042e 01            	rrwa	x,a
 848  042f 1a01          	or	a,(OFST-5,sp)
 849  0431 01            	rrwa	x,a
 850  0432               L301:
 851  0432 1f05          	ldw	(OFST-1,sp),x
 852                     ; 648   return (I2C_Event_TypeDef)lastevent;
 853  0434 1e05          	ldw	x,(OFST-1,sp)
 855  0436 5b06          	addw	sp,#6
 856  0438 81            	ret	
 858                     ; 679 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
 858                     ; 680 {
 859  0439               _I2C_GetFlagStatus:
 860  0439 89            	pushw	x
 861  043a 89            	pushw	x
 862       00000002      OFST:	set	2
 864                     ; 681   uint8_t tempreg = 0;
 865  043b 0f02          	clr	(OFST+0,sp)
 866                     ; 682   uint8_t regindex = 0;
 867                     ; 683   FlagStatus bitstatus = RESET;
 868                     ; 686   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
 869  043d a30180        	cpw	x,#384
 870  0440 2759          	jreq	L003
 871  0442 a30140        	cpw	x,#320
 872  0445 2754          	jreq	L003
 873  0447 a30110        	cpw	x,#272
 874  044a 274f          	jreq	L003
 875  044c a30108        	cpw	x,#264
 876  044f 274a          	jreq	L003
 877  0451 a30104        	cpw	x,#260
 878  0454 2745          	jreq	L003
 879  0456 a30102        	cpw	x,#258
 880  0459 2740          	jreq	L003
 881  045b a30101        	cpw	x,#257
 882  045e 273b          	jreq	L003
 883  0460 a30220        	cpw	x,#544
 884  0463 2736          	jreq	L003
 885  0465 a30208        	cpw	x,#520
 886  0468 2731          	jreq	L003
 887  046a a30204        	cpw	x,#516
 888  046d 272c          	jreq	L003
 889  046f a30202        	cpw	x,#514
 890  0472 2727          	jreq	L003
 891  0474 a30201        	cpw	x,#513
 892  0477 2722          	jreq	L003
 893  0479 a30310        	cpw	x,#784
 894  047c 271d          	jreq	L003
 895  047e a30304        	cpw	x,#772
 896  0481 2718          	jreq	L003
 897  0483 a30302        	cpw	x,#770
 898  0486 2713          	jreq	L003
 899  0488 a30301        	cpw	x,#769
 900  048b 270e          	jreq	L003
 901  048d ae02ae        	ldw	x,#686
 902  0490 89            	pushw	x
 903  0491 5f            	clrw	x
 904  0492 89            	pushw	x
 905  0493 ae000c        	ldw	x,#L3
 906  0496 cd0000        	call	_assert_failed
 908  0499 5b04          	addw	sp,#4
 909  049b               L003:
 910                     ; 689   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
 911  049b 7b03          	ld	a,(OFST+1,sp)
 912  049d 6b01          	ld	(OFST-1,sp),a
 913                     ; 691   switch (regindex)
 915                     ; 708     default:
 915                     ; 709       break;
 916  049f 4a            	dec	a
 917  04a0 2708          	jreq	L501
 918  04a2 4a            	dec	a
 919  04a3 270a          	jreq	L701
 920  04a5 4a            	dec	a
 921  04a6 270c          	jreq	L111
 922  04a8 200f          	jra	L711
 923  04aa               L501:
 924                     ; 694     case 0x01:
 924                     ; 695       tempreg = (uint8_t)I2C->SR1;
 925  04aa c65217        	ld	a,21015
 926                     ; 696       break;
 927  04ad 2008          	jp	LC006
 928  04af               L701:
 929                     ; 699     case 0x02:
 929                     ; 700       tempreg = (uint8_t)I2C->SR2;
 930  04af c65218        	ld	a,21016
 931                     ; 701       break;
 932  04b2 2003          	jp	LC006
 933  04b4               L111:
 934                     ; 704     case 0x03:
 934                     ; 705       tempreg = (uint8_t)I2C->SR3;
 935  04b4 c65219        	ld	a,21017
 936  04b7               LC006:
 937  04b7 6b02          	ld	(OFST+0,sp),a
 938                     ; 706       break;
 939                     ; 708     default:
 939                     ; 709       break;
 940  04b9               L711:
 941                     ; 713   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
 942  04b9 7b04          	ld	a,(OFST+2,sp)
 943  04bb 1502          	bcp	a,(OFST+0,sp)
 944  04bd 2704          	jreq	L121
 945                     ; 716     bitstatus = SET;
 946  04bf a601          	ld	a,#1
 948  04c1 2001          	jra	L321
 949  04c3               L121:
 950                     ; 721     bitstatus = RESET;
 951  04c3 4f            	clr	a
 952  04c4               L321:
 953                     ; 724   return bitstatus;
 955  04c4 5b04          	addw	sp,#4
 956  04c6 81            	ret	
 958                     ; 759 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
 958                     ; 760 {
 959  04c7               _I2C_ClearFlag:
 960  04c7 89            	pushw	x
 961  04c8 89            	pushw	x
 962       00000002      OFST:	set	2
 964                     ; 761   uint16_t flagpos = 0;
 965                     ; 763   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
 966  04c9 01            	rrwa	x,a
 967  04ca 9f            	ld	a,xl
 968  04cb a4fd          	and	a,#253
 969  04cd 97            	ld	xl,a
 970  04ce 4f            	clr	a
 971  04cf 02            	rlwa	x,a
 972  04d0 5d            	tnzw	x
 973  04d1 2604          	jrne	L603
 974  04d3 1e03          	ldw	x,(OFST+1,sp)
 975  04d5 260e          	jrne	L013
 976  04d7               L603:
 977  04d7 ae02fb        	ldw	x,#763
 978  04da 89            	pushw	x
 979  04db 5f            	clrw	x
 980  04dc 89            	pushw	x
 981  04dd ae000c        	ldw	x,#L3
 982  04e0 cd0000        	call	_assert_failed
 984  04e3 5b04          	addw	sp,#4
 985  04e5               L013:
 986                     ; 766   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
 987  04e5 7b04          	ld	a,(OFST+2,sp)
 988  04e7 5f            	clrw	x
 989  04e8 02            	rlwa	x,a
 990  04e9 1f01          	ldw	(OFST-1,sp),x
 991                     ; 768   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
 992  04eb 7b02          	ld	a,(OFST+0,sp)
 993  04ed 43            	cpl	a
 994  04ee c75218        	ld	21016,a
 995                     ; 769 }
 996  04f1 5b04          	addw	sp,#4
 997  04f3 81            	ret	
 999                     ; 791 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
 999                     ; 792 {
1000  04f4               _I2C_GetITStatus:
1001  04f4 89            	pushw	x
1002  04f5 5204          	subw	sp,#4
1003       00000004      OFST:	set	4
1005                     ; 793   ITStatus bitstatus = RESET;
1006                     ; 794   __IO uint8_t enablestatus = 0;
1007  04f7 0f03          	clr	(OFST-1,sp)
1008                     ; 795   uint16_t tempregister = 0;
1009                     ; 798     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
1010  04f9 a31680        	cpw	x,#5760
1011  04fc 2745          	jreq	L223
1012  04fe a31640        	cpw	x,#5696
1013  0501 2740          	jreq	L223
1014  0503 a31210        	cpw	x,#4624
1015  0506 273b          	jreq	L223
1016  0508 a31208        	cpw	x,#4616
1017  050b 2736          	jreq	L223
1018  050d a31204        	cpw	x,#4612
1019  0510 2731          	jreq	L223
1020  0512 a31202        	cpw	x,#4610
1021  0515 272c          	jreq	L223
1022  0517 a31201        	cpw	x,#4609
1023  051a 2727          	jreq	L223
1024  051c a32220        	cpw	x,#8736
1025  051f 2722          	jreq	L223
1026  0521 a32108        	cpw	x,#8456
1027  0524 271d          	jreq	L223
1028  0526 a32104        	cpw	x,#8452
1029  0529 2718          	jreq	L223
1030  052b a32102        	cpw	x,#8450
1031  052e 2713          	jreq	L223
1032  0530 a32101        	cpw	x,#8449
1033  0533 270e          	jreq	L223
1034  0535 ae031e        	ldw	x,#798
1035  0538 89            	pushw	x
1036  0539 5f            	clrw	x
1037  053a 89            	pushw	x
1038  053b ae000c        	ldw	x,#L3
1039  053e cd0000        	call	_assert_failed
1041  0541 5b04          	addw	sp,#4
1042  0543               L223:
1043                     ; 800   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
1044  0543 7b05          	ld	a,(OFST+1,sp)
1045  0545 a407          	and	a,#7
1046  0547 5f            	clrw	x
1047  0548 97            	ld	xl,a
1048  0549 1f01          	ldw	(OFST-3,sp),x
1049                     ; 803   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
1050  054b c6521a        	ld	a,21018
1051  054e 1402          	and	a,(OFST-2,sp)
1052  0550 6b03          	ld	(OFST-1,sp),a
1053                     ; 805   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
1054  0552 7b05          	ld	a,(OFST+1,sp)
1055  0554 a430          	and	a,#48
1056  0556 97            	ld	xl,a
1057  0557 4f            	clr	a
1058  0558 02            	rlwa	x,a
1059  0559 a30100        	cpw	x,#256
1060  055c 260d          	jrne	L521
1061                     ; 808     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
1062  055e c65217        	ld	a,21015
1063  0561 1506          	bcp	a,(OFST+2,sp)
1064  0563 2715          	jreq	L531
1066  0565 0d03          	tnz	(OFST-1,sp)
1067  0567 2711          	jreq	L531
1068                     ; 811       bitstatus = SET;
1070  0569 200b          	jp	LC008
1071                     ; 816       bitstatus = RESET;
1072  056b               L521:
1073                     ; 822     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
1074  056b c65218        	ld	a,21016
1075  056e 1506          	bcp	a,(OFST+2,sp)
1076  0570 2708          	jreq	L531
1078  0572 0d03          	tnz	(OFST-1,sp)
1079  0574 2704          	jreq	L531
1080                     ; 825       bitstatus = SET;
1081  0576               LC008:
1082  0576 a601          	ld	a,#1
1084  0578 2001          	jra	L331
1085  057a               L531:
1086                     ; 830       bitstatus = RESET;
1087  057a 4f            	clr	a
1088  057b               L331:
1089                     ; 834   return  bitstatus;
1091  057b 5b06          	addw	sp,#6
1092  057d 81            	ret	
1094                     ; 871 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
1094                     ; 872 {
1095  057e               _I2C_ClearITPendingBit:
1096  057e 89            	pushw	x
1097  057f 89            	pushw	x
1098       00000002      OFST:	set	2
1100                     ; 873   uint16_t flagpos = 0;
1101                     ; 876   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
1102  0580 a32220        	cpw	x,#8736
1103  0583 2722          	jreq	L433
1104  0585 a32108        	cpw	x,#8456
1105  0588 271d          	jreq	L433
1106  058a a32104        	cpw	x,#8452
1107  058d 2718          	jreq	L433
1108  058f a32102        	cpw	x,#8450
1109  0592 2713          	jreq	L433
1110  0594 a32101        	cpw	x,#8449
1111  0597 270e          	jreq	L433
1112  0599 ae036c        	ldw	x,#876
1113  059c 89            	pushw	x
1114  059d 5f            	clrw	x
1115  059e 89            	pushw	x
1116  059f ae000c        	ldw	x,#L3
1117  05a2 cd0000        	call	_assert_failed
1119  05a5 5b04          	addw	sp,#4
1120  05a7               L433:
1121                     ; 879   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
1122  05a7 7b04          	ld	a,(OFST+2,sp)
1123  05a9 5f            	clrw	x
1124  05aa 02            	rlwa	x,a
1125  05ab 1f01          	ldw	(OFST-1,sp),x
1126                     ; 882   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
1127  05ad 7b02          	ld	a,(OFST+0,sp)
1128  05af 43            	cpl	a
1129  05b0 c75218        	ld	21016,a
1130                     ; 883 }
1131  05b3 5b04          	addw	sp,#4
1132  05b5 81            	ret	
1134                     	xdef	_I2C_ClearITPendingBit
1135                     	xdef	_I2C_GetITStatus
1136                     	xdef	_I2C_ClearFlag
1137                     	xdef	_I2C_GetFlagStatus
1138                     	xdef	_I2C_GetLastEvent
1139                     	xdef	_I2C_CheckEvent
1140                     	xdef	_I2C_SendData
1141                     	xdef	_I2C_Send7bitAddress
1142                     	xdef	_I2C_ReceiveData
1143                     	xdef	_I2C_ITConfig
1144                     	xdef	_I2C_FastModeDutyCycleConfig
1145                     	xdef	_I2C_AcknowledgeConfig
1146                     	xdef	_I2C_StretchClockCmd
1147                     	xdef	_I2C_SoftwareResetCmd
1148                     	xdef	_I2C_GenerateSTOP
1149                     	xdef	_I2C_GenerateSTART
1150                     	xdef	_I2C_GeneralCallCmd
1151                     	xdef	_I2C_Cmd
1152                     	xdef	_I2C_Init
1153                     	xdef	_I2C_DeInit
1154                     	xref	_assert_failed
1155                     	switch	.const
1156  000c               L3:
1157  000c 7372635c7374  	dc.b	"src\stm8s_i2c.c",0
1158                     	xref.b	c_lreg
1159                     	xref.b	c_x
1160                     	xref	c_sdivx
1161                     	xref	c_ludv
1162                     	xref	c_rtol
1163                     	xref	c_smul
1164                     	xref	c_lmul
1165                     	xref	c_lcmp
1166                     	xref	c_ltor
1167                     	xref	c_lzmp
1168                     	end
