   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     ; 54 FlagStatus RST_GetFlagStatus(RST_Flag_TypeDef RST_Flag)
  19                     ; 55 {
  20                     	scross	off
  21  0000               _RST_GetFlagStatus:
  22  0000 88            	push	a
  23       00000000      OFST:	set	0
  25                     ; 57   assert_param(IS_RST_FLAG_OK(RST_Flag));
  26  0001 a110          	cp	a,#16
  27  0003 271d          	jreq	L01
  28  0005 a108          	cp	a,#8
  29  0007 2719          	jreq	L01
  30  0009 a104          	cp	a,#4
  31  000b 2715          	jreq	L01
  32  000d a102          	cp	a,#2
  33  000f 2711          	jreq	L01
  34  0011 4a            	dec	a
  35  0012 270e          	jreq	L01
  36  0014 ae0039        	ldw	x,#57
  37  0017 89            	pushw	x
  38  0018 5f            	clrw	x
  39  0019 89            	pushw	x
  40  001a ae0000        	ldw	x,#L3
  41  001d cd0000        	call	_assert_failed
  43  0020 5b04          	addw	sp,#4
  44  0022               L01:
  45                     ; 60   return((FlagStatus)(((uint8_t)(RST->SR & RST_Flag) == (uint8_t)0x00) ? RESET : SET));
  46  0022 c650b3        	ld	a,20659
  47  0025 1501          	bcp	a,(OFST+1,sp)
  48  0027 2603          	jrne	L41
  49  0029 4f            	clr	a
  50  002a 2002          	jra	L61
  51  002c               L41:
  52  002c a601          	ld	a,#1
  53  002e               L61:
  55  002e 5b01          	addw	sp,#1
  56  0030 81            	ret	
  58                     ; 69 void RST_ClearFlag(RST_Flag_TypeDef RST_Flag)
  58                     ; 70 {
  59  0031               _RST_ClearFlag:
  60  0031 88            	push	a
  61       00000000      OFST:	set	0
  63                     ; 72   assert_param(IS_RST_FLAG_OK(RST_Flag));
  64  0032 a110          	cp	a,#16
  65  0034 271d          	jreq	L62
  66  0036 a108          	cp	a,#8
  67  0038 2719          	jreq	L62
  68  003a a104          	cp	a,#4
  69  003c 2715          	jreq	L62
  70  003e a102          	cp	a,#2
  71  0040 2711          	jreq	L62
  72  0042 4a            	dec	a
  73  0043 270e          	jreq	L62
  74  0045 ae0048        	ldw	x,#72
  75  0048 89            	pushw	x
  76  0049 5f            	clrw	x
  77  004a 89            	pushw	x
  78  004b ae0000        	ldw	x,#L3
  79  004e cd0000        	call	_assert_failed
  81  0051 5b04          	addw	sp,#4
  82  0053               L62:
  83                     ; 74   RST->SR = (uint8_t)RST_Flag;
  84  0053 7b01          	ld	a,(OFST+1,sp)
  85  0055 c750b3        	ld	20659,a
  86                     ; 75 }
  87  0058 84            	pop	a
  88  0059 81            	ret	
  90                     	xdef	_RST_ClearFlag
  91                     	xdef	_RST_GetFlagStatus
  92                     	xref	_assert_failed
  93                     .const:	section	.text
  94  0000               L3:
  95  0000 7372635c7374  	dc.b	"src\stm8s_rst.c",0
  96                     	end
