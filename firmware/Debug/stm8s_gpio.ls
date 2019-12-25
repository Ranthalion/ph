   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     ; 53 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
  19                     ; 54 {
  20                     	scross	off
  21  0000               _GPIO_DeInit:
  23                     ; 55   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
  24  0000 7f            	clr	(x)
  25                     ; 56   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
  26  0001 6f02          	clr	(2,x)
  27                     ; 57   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
  28  0003 6f03          	clr	(3,x)
  29                     ; 58   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
  30  0005 6f04          	clr	(4,x)
  31                     ; 59 }
  32  0007 81            	ret	
  34                     ; 71 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
  34                     ; 72 {
  35  0008               _GPIO_Init:
  36  0008 89            	pushw	x
  37       00000000      OFST:	set	0
  39                     ; 77   assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
  40  0009 7b06          	ld	a,(OFST+6,sp)
  41  000b 2731          	jreq	L21
  42  000d a140          	cp	a,#64
  43  000f 272d          	jreq	L21
  44  0011 a120          	cp	a,#32
  45  0013 2729          	jreq	L21
  46  0015 a160          	cp	a,#96
  47  0017 2725          	jreq	L21
  48  0019 a1a0          	cp	a,#160
  49  001b 2721          	jreq	L21
  50  001d a1e0          	cp	a,#224
  51  001f 271d          	jreq	L21
  52  0021 a180          	cp	a,#128
  53  0023 2719          	jreq	L21
  54  0025 a1c0          	cp	a,#192
  55  0027 2715          	jreq	L21
  56  0029 a1b0          	cp	a,#176
  57  002b 2711          	jreq	L21
  58  002d a1f0          	cp	a,#240
  59  002f 270d          	jreq	L21
  60  0031 a190          	cp	a,#144
  61  0033 2709          	jreq	L21
  62  0035 a1d0          	cp	a,#208
  63  0037 2705          	jreq	L21
  64  0039 ae004d        	ldw	x,#77
  65  003c ad5d          	call	LC001
  66  003e               L21:
  67                     ; 78   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
  68  003e 7b05          	ld	a,(OFST+5,sp)
  69  0040 2607          	jrne	L02
  70  0042 ae004e        	ldw	x,#78
  71  0045 ad54          	call	LC001
  72  0047 7b05          	ld	a,(OFST+5,sp)
  73  0049               L02:
  74                     ; 81   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
  75  0049 1e01          	ldw	x,(OFST+1,sp)
  76  004b 43            	cpl	a
  77  004c e404          	and	a,(4,x)
  78  004e e704          	ld	(4,x),a
  79                     ; 87   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
  80  0050 7b06          	ld	a,(OFST+6,sp)
  81  0052 2a14          	jrpl	L5
  82                     ; 89     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
  83  0054 a510          	bcp	a,#16
  84  0056 2705          	jreq	L7
  85                     ; 91       GPIOx->ODR |= (uint8_t)GPIO_Pin;
  86  0058 f6            	ld	a,(x)
  87  0059 1a05          	or	a,(OFST+5,sp)
  89  005b 2004          	jra	L11
  90  005d               L7:
  91                     ; 95       GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
  92  005d 7b05          	ld	a,(OFST+5,sp)
  93  005f 43            	cpl	a
  94  0060 f4            	and	a,(x)
  95  0061               L11:
  96  0061 f7            	ld	(x),a
  97                     ; 98     GPIOx->DDR |= (uint8_t)GPIO_Pin;
  98  0062 e602          	ld	a,(2,x)
  99  0064 1a05          	or	a,(OFST+5,sp)
 101  0066 2005          	jra	L31
 102  0068               L5:
 103                     ; 103     GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 104  0068 7b05          	ld	a,(OFST+5,sp)
 105  006a 43            	cpl	a
 106  006b e402          	and	a,(2,x)
 107  006d               L31:
 108  006d e702          	ld	(2,x),a
 109                     ; 110   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 110  006f 7b06          	ld	a,(OFST+6,sp)
 111  0071 a540          	bcp	a,#64
 112  0073 2706          	jreq	L51
 113                     ; 112     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 114  0075 e603          	ld	a,(3,x)
 115  0077 1a05          	or	a,(OFST+5,sp)
 117  0079 2005          	jra	L71
 118  007b               L51:
 119                     ; 116     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 120  007b 7b05          	ld	a,(OFST+5,sp)
 121  007d 43            	cpl	a
 122  007e e403          	and	a,(3,x)
 123  0080               L71:
 124  0080 e703          	ld	(3,x),a
 125                     ; 123   if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 126  0082 7b06          	ld	a,(OFST+6,sp)
 127  0084 a520          	bcp	a,#32
 128  0086 2708          	jreq	L12
 129                     ; 125     GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 130  0088 1e01          	ldw	x,(OFST+1,sp)
 131  008a e604          	ld	a,(4,x)
 132  008c 1a05          	or	a,(OFST+5,sp)
 134  008e 2007          	jra	L32
 135  0090               L12:
 136                     ; 129     GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 137  0090 1e01          	ldw	x,(OFST+1,sp)
 138  0092 7b05          	ld	a,(OFST+5,sp)
 139  0094 43            	cpl	a
 140  0095 e404          	and	a,(4,x)
 141  0097               L32:
 142  0097 e704          	ld	(4,x),a
 143                     ; 131 }
 144  0099 85            	popw	x
 145  009a 81            	ret	
 146  009b               LC001:
 147  009b 89            	pushw	x
 148  009c 5f            	clrw	x
 149  009d 89            	pushw	x
 150  009e ae0000        	ldw	x,#L3
 151  00a1 cd0000        	call	_assert_failed
 153  00a4 5b04          	addw	sp,#4
 154  00a6 81            	ret	
 156                     ; 141 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 156                     ; 142 {
 157  00a7               _GPIO_Write:
 158       fffffffe      OFST: set -2
 160                     ; 143   GPIOx->ODR = PortVal;
 161  00a7 7b03          	ld	a,(OFST+5,sp)
 162  00a9 f7            	ld	(x),a
 163                     ; 144 }
 164  00aa 81            	ret	
 166                     ; 154 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 166                     ; 155 {
 167  00ab               _GPIO_WriteHigh:
 168       fffffffe      OFST: set -2
 170                     ; 156   GPIOx->ODR |= (uint8_t)PortPins;
 171  00ab f6            	ld	a,(x)
 172  00ac 1a03          	or	a,(OFST+5,sp)
 173  00ae f7            	ld	(x),a
 174                     ; 157 }
 175  00af 81            	ret	
 177                     ; 167 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 177                     ; 168 {
 178  00b0               _GPIO_WriteLow:
 179       fffffffe      OFST: set -2
 181                     ; 169   GPIOx->ODR &= (uint8_t)(~PortPins);
 182  00b0 7b03          	ld	a,(OFST+5,sp)
 183  00b2 43            	cpl	a
 184  00b3 f4            	and	a,(x)
 185  00b4 f7            	ld	(x),a
 186                     ; 170 }
 187  00b5 81            	ret	
 189                     ; 180 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 189                     ; 181 {
 190  00b6               _GPIO_WriteReverse:
 191       fffffffe      OFST: set -2
 193                     ; 182   GPIOx->ODR ^= (uint8_t)PortPins;
 194  00b6 f6            	ld	a,(x)
 195  00b7 1803          	xor	a,(OFST+5,sp)
 196  00b9 f7            	ld	(x),a
 197                     ; 183 }
 198  00ba 81            	ret	
 200                     ; 191 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 200                     ; 192 {
 201  00bb               _GPIO_ReadOutputData:
 203                     ; 193   return ((uint8_t)GPIOx->ODR);
 204  00bb f6            	ld	a,(x)
 206  00bc 81            	ret	
 208                     ; 202 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 208                     ; 203 {
 209  00bd               _GPIO_ReadInputData:
 211                     ; 204   return ((uint8_t)GPIOx->IDR);
 212  00bd e601          	ld	a,(1,x)
 214  00bf 81            	ret	
 216                     ; 213 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 216                     ; 214 {
 217  00c0               _GPIO_ReadInputPin:
 218       fffffffe      OFST: set -2
 220                     ; 215   return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 221  00c0 e601          	ld	a,(1,x)
 222  00c2 1403          	and	a,(OFST+5,sp)
 224  00c4 81            	ret	
 226                     ; 225 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 226                     ; 226 {
 227  00c5               _GPIO_ExternalPullUpConfig:
 228  00c5 89            	pushw	x
 229       00000000      OFST:	set	0
 231                     ; 228   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 232  00c6 7b05          	ld	a,(OFST+5,sp)
 233  00c8 2605          	jrne	L64
 234  00ca ae00e4        	ldw	x,#228
 235  00cd ad23          	call	LC002
 236  00cf               L64:
 237                     ; 229   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 238  00cf 7b06          	ld	a,(OFST+6,sp)
 239  00d1 2708          	jreq	L65
 240  00d3 4a            	dec	a
 241  00d4 2705          	jreq	L65
 242  00d6 ae00e5        	ldw	x,#229
 243  00d9 ad17          	call	LC002
 244  00db               L65:
 245                     ; 231   if (NewState != DISABLE) /* External Pull-Up Set*/
 246  00db 7b06          	ld	a,(OFST+6,sp)
 247  00dd 2708          	jreq	L52
 248                     ; 233     GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 249  00df 1e01          	ldw	x,(OFST+1,sp)
 250  00e1 e603          	ld	a,(3,x)
 251  00e3 1a05          	or	a,(OFST+5,sp)
 253  00e5 2007          	jra	L72
 254  00e7               L52:
 255                     ; 236     GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 256  00e7 1e01          	ldw	x,(OFST+1,sp)
 257  00e9 7b05          	ld	a,(OFST+5,sp)
 258  00eb 43            	cpl	a
 259  00ec e403          	and	a,(3,x)
 260  00ee               L72:
 261  00ee e703          	ld	(3,x),a
 262                     ; 238 }
 263  00f0 85            	popw	x
 264  00f1 81            	ret	
 265  00f2               LC002:
 266  00f2 89            	pushw	x
 267  00f3 5f            	clrw	x
 268  00f4 89            	pushw	x
 269  00f5 ae0000        	ldw	x,#L3
 270  00f8 cd0000        	call	_assert_failed
 272  00fb 5b04          	addw	sp,#4
 273  00fd 81            	ret	
 275                     	xdef	_GPIO_ExternalPullUpConfig
 276                     	xdef	_GPIO_ReadInputPin
 277                     	xdef	_GPIO_ReadOutputData
 278                     	xdef	_GPIO_ReadInputData
 279                     	xdef	_GPIO_WriteReverse
 280                     	xdef	_GPIO_WriteLow
 281                     	xdef	_GPIO_WriteHigh
 282                     	xdef	_GPIO_Write
 283                     	xdef	_GPIO_Init
 284                     	xdef	_GPIO_DeInit
 285                     	xref	_assert_failed
 286                     .const:	section	.text
 287  0000               L3:
 288  0000 7372635c7374  	dc.b	"src\stm8s_gpio.c",0
 289                     	end
