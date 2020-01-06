
#ifndef __MAIN_H
#define __MAIN_H

#define STATE_ADC_READY (1 << 0)
#define STATE_I2C_RESET (1 << 1)
#define STATE_TMR_TICK 	(1 << 2)

#define ADDR_port GPIOD
#define ADDR_pin_1 GPIO_PIN_4
#define ADDR_pin_2 GPIO_PIN_5

#define ADC_port GPIOD
#define ADC_pin GPIO_PIN_6

extern volatile uint8_t state;
extern volatile uint16_t phRaw;
extern volatile uint8_t i2cBuffer1[3];
extern volatile uint8_t *startPoint;
extern volatile uint8_t *currentPoint;
#endif //__MAIN_H