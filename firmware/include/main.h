
#ifndef __MAIN_H
#define __MAIN_H

#define STATE_ADC_READY (1 << 0)
#define STATE_I2C_READY (1 << 1)
#define STATE_TMR_TICK 	(1 << 2)

#define LED_port GPIOD
#define LED_pin GPIO_PIN_3

#define ADDR_port GPIOD
#define ADDR_pin_1 GPIO_PIN_4
#define ADDR_pin_2 GPIO_PIN_5

#define ADC_port GPIOD
#define ADC_pin GPIO_PIN_6

#define LED_ONCE				0xC000

#define LED_PANIC 			0x2AAA
#define LED_ON 					0x3FFF
#define LED_OFF					0x0000
#define	LED_BLIP				0x0001
#define LED_BLINK				0x007F
#define LED_SLOW_FLASH	0x03FE

extern volatile uint8_t state;

#endif //__MAIN_H