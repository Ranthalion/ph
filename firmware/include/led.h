
#ifndef __LED_H
#define __LED_H

#include "stm8s.h"

#define LED_port GPIOD
#define LED_pin GPIO_PIN_3

#define LED_PANIC 			0x3333
#define LED_ON 					0xFFFF
#define LED_OFF					0x0000
#define	LED_BLIP				0x0001
#define LED_BLINK				0x007F
#define LED_SLOW_FLASH	0x03FE

struct led_state
{
	uint8_t ctr;
	uint16_t pattern;
	uint8_t duration;
};

extern volatile struct led_state led;

void SetLED(uint16_t pattern, uint8_t repeatCount);
void LEDTick(void);
void LEDToggle(void);
void LEDOff(void);

#endif //__LED_H