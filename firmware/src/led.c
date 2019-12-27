#include "led.h"

volatile struct led_state led;

void SetLED(uint16_t pattern, uint8_t repeatCount)
{
	led.pattern = pattern;
	led.duration = repeatCount;
	led.ctr = 0;
}

void LEDTick()
{
	if (led.pattern & (1 << led.ctr))
	{
		GPIO_WriteLow(LED_port, LED_pin);
	}
	else
	{
		GPIO_WriteHigh(LED_port, LED_pin);					
	}
	
	led.ctr++;
	if(led.ctr >= 16)
	{
		if (led.duration == 1)
		{
			led.pattern = LED_OFF;
		}
		if (led.duration > 0)
		{
			led.duration--;
		}
		led.ctr = 0;					
	}
}