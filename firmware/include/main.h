
#ifndef __MAIN_H
#define __MAIN_H

#define STATE_ADC_READY (1 << 0)
#define STATE_I2C_READY (1 << 1)
#define STATE_TMR_TICK 	(1 << 2)
#define STATE_LED_TICK	(1 << 3)

extern volatile uint8_t state;

#endif //__MAIN_H