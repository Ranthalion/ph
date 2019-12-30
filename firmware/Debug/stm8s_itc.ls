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
 205                     ; 85   Mask = (uint8_t)(~(uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U)));
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
 223                     ; 88   NewPriority = (uint8_t)((uint8_t)(PriorityValue) << (((uint8_t)IrqNum % 4U) * 2U));
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
 240                     ; 90   switch (IrqNum)
 242  0029 7b03          	ld	a,(OFST+1,sp)
 243  002b a113          	cp	a,#19
 244  002d 2610          	jrne	L701
 247  002f               L12:
 248                     ; 93   case ITC_IRQ_I2C:
 248                     ; 94     ITC->ISPR5 &= Mask;
 250  002f c67f74        	ld	a,32628
 251  0032 1401          	and	a,(OFST-1,sp)
 252  0034 c77f74        	ld	32628,a
 253                     ; 95     ITC->ISPR5 |= NewPriority;
 255  0037 c67f74        	ld	a,32628
 256  003a 1a02          	or	a,(OFST+0,sp)
 257  003c c77f74        	ld	32628,a
 258                     ; 96     break;
 260  003f               L32:
 261                     ; 98   default:
 261                     ; 99     break;
 263  003f               L701:
 264                     ; 101 }
 267  003f 5b04          	addw	sp,#4
 268  0041 81            	ret
 281                     	xdef	_ITC_GetCPUCC
 282                     	xdef	_ITC_SetSoftwarePriority
 301                     	end
