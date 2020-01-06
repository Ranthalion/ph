   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  43                     ; 50 uint8_t ITC_GetCPUCC(void)
  43                     ; 51 {
  45                     	switch	.text
  46  0000               _ITC_GetCPUCC:
  50                     ; 53   _asm("push cc");
  53  0000 8a            push cc
  55                     ; 54   _asm("pop a");
  58  0001 84            pop a
  60                     ; 55   return; /* Ignore compiler warning, the returned value is in A register */
  63  0002 81            	ret
 192                     ; 78 void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
 192                     ; 79 {
 193                     	switch	.text
 194  0003               _ITC_SetSoftwarePriority:
 196  0003 89            	pushw	x
 197  0004 89            	pushw	x
 198       00000002      OFST:	set	2
 201                     ; 80   uint8_t Mask = 0;
 203                     ; 81   uint8_t NewPriority = 0;
 205                     ; 86   Mask = (uint8_t)(~(uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U)));
 207  0005 9e            	ld	a,xh
 208  0006 a403          	and	a,#3
 209  0008 48            	sll	a
 210  0009 5f            	clrw	x
 211  000a 97            	ld	xl,a
 212  000b a603          	ld	a,#3
 213  000d 5d            	tnzw	x
 214  000e 2704          	jreq	L01
 215  0010               L21:
 216  0010 48            	sll	a
 217  0011 5a            	decw	x
 218  0012 26fc          	jrne	L21
 219  0014               L01:
 220  0014 43            	cpl	a
 221  0015 6b01          	ld	(OFST-1,sp),a
 223                     ; 89   NewPriority = (uint8_t)((uint8_t)(PriorityValue) << (((uint8_t)IrqNum % 4U) * 2U));
 225  0017 7b03          	ld	a,(OFST+1,sp)
 226  0019 a403          	and	a,#3
 227  001b 48            	sll	a
 228  001c 5f            	clrw	x
 229  001d 97            	ld	xl,a
 230  001e 7b04          	ld	a,(OFST+2,sp)
 231  0020 5d            	tnzw	x
 232  0021 2704          	jreq	L41
 233  0023               L61:
 234  0023 48            	sll	a
 235  0024 5a            	decw	x
 236  0025 26fc          	jrne	L61
 237  0027               L41:
 238  0027 6b02          	ld	(OFST+0,sp),a
 240                     ; 91   switch (IrqNum)
 242  0029 7b03          	ld	a,(OFST+1,sp)
 244                     ; 107   default:
 244                     ; 108     break;
 245  002b a00d          	sub	a,#13
 246  002d 270a          	jreq	L12
 247  002f a006          	sub	a,#6
 248  0031 2718          	jreq	L32
 249  0033 a003          	sub	a,#3
 250  0035 2726          	jreq	L52
 251  0037 2034          	jra	L311
 252  0039               L12:
 253                     ; 93   case ITC_IRQ_TIM2_OVF:
 253                     ; 94 		ITC->ISPR4 &= Mask;
 255  0039 c67f73        	ld	a,32627
 256  003c 1401          	and	a,(OFST-1,sp)
 257  003e c77f73        	ld	32627,a
 258                     ; 95     ITC->ISPR4 |= NewPriority;
 260  0041 c67f73        	ld	a,32627
 261  0044 1a02          	or	a,(OFST+0,sp)
 262  0046 c77f73        	ld	32627,a
 263                     ; 96     break;
 265  0049 2022          	jra	L311
 266  004b               L32:
 267                     ; 98   case ITC_IRQ_I2C:
 267                     ; 99     ITC->ISPR5 &= Mask;
 269  004b c67f74        	ld	a,32628
 270  004e 1401          	and	a,(OFST-1,sp)
 271  0050 c77f74        	ld	32628,a
 272                     ; 100     ITC->ISPR5 |= NewPriority;
 274  0053 c67f74        	ld	a,32628
 275  0056 1a02          	or	a,(OFST+0,sp)
 276  0058 c77f74        	ld	32628,a
 277                     ; 101     break;
 279  005b 2010          	jra	L311
 280  005d               L52:
 281                     ; 102   case ITC_IRQ_ADC1:
 281                     ; 103     ITC->ISPR6 &= Mask;
 283  005d c67f75        	ld	a,32629
 284  0060 1401          	and	a,(OFST-1,sp)
 285  0062 c77f75        	ld	32629,a
 286                     ; 104     ITC->ISPR6 |= NewPriority;
 288  0065 c67f75        	ld	a,32629
 289  0068 1a02          	or	a,(OFST+0,sp)
 290  006a c77f75        	ld	32629,a
 291                     ; 105     break;
 293  006d               L72:
 294                     ; 107   default:
 294                     ; 108     break;
 296  006d               L311:
 297                     ; 110 }
 300  006d 5b04          	addw	sp,#4
 301  006f 81            	ret
 314                     	xdef	_ITC_GetCPUCC
 315                     	xdef	_ITC_SetSoftwarePriority
 334                     	end
