#include "stm8s.h"
#include "main.h"
#include <stdbool.h>
#include "led.h"
#include "stm8s_itc.h"

void init(void);
void ADC_setup(void);
void TIM2_setup(void);
void HandleADC(void);
void HandleTimerTick(void);

void InitI2C(void);

volatile uint8_t state = 0;
volatile uint16_t phRaw = 1111;

#define BUFFER_SIZE 64
uint16_t adcValues[BUFFER_SIZE];
volatile uint8_t i2cBuffer1[3];
uint8_t idxBuffer = 0;
bool bufferEmpty = true;

uint32_t averagedValue = 0;

volatile uint8_t *startPoint;
volatile uint8_t *currentPoint;

main()
{
	//Clock div / 1
	CLK->CKDIVR = 0;
	GPIOD->ODR = 0x08;
	
	// Init GPIO for LED and ADDR
	GPIOD->CR1 |= 0x38;	//Pull ups on 4 and 5, push-pull on 3
	GPIOD->DDR = 0x08;  //All pins inputs, except PD3

	InitI2C();
	
	//Enable peripheral clocks for TIM2 and I2C
	CLK->PCKENR1 = 0x21;  //TIM2 and I2C
	CLK->PCKENR2 = 0x08;  //ADC
	
	/* Enable general interrupts */
  enableInterrupts();
	
		GPIOD->ODR = 0x08;
	//Set up ADC and Timer
	init();
	
	//SetLED(LED_PANIC, 1);
	SetLED(LED_OFF, 0);
	
	startPoint = &i2cBuffer1[1];
	currentPoint = startPoint;
	I2C->SR2 &= ~I2C_SR2_AF;
	wfi(); //wait for interrupts
	while (1)
	{
		while (state > 0)
		{
			//Check ADC State
			if (state & STATE_ADC_READY)
			{
				HandleADC();				
			}
			
			//Check I2C State
			if (state & STATE_I2C_RESET)
			{
				state &= ~(STATE_I2C_RESET);
				InitI2C();				
			}
			
			//Check TMR State
			if (state & STATE_TMR_TICK)
			{
				LEDTick();
				state &= ~(STATE_TMR_TICK);
			}
		}
		
		wfi();
	}
}

void assert_failed(u8* file, u32 line)
{
	//SetLED(LED_PANIC, 10);
}

void InitI2C()
{
	uint8_t address = 0x45;
	uint8_t addressOffset = 0;
	
	// Init GPIO for I2C use
	//GPIOB->CR1 |= 0x30;
	GPIOB->CR1 |= 0x00;
	GPIOB->DDR &= ~0x30;
	GPIOB->CR2 &= ~0x30;
	
	//Determine I2C address
	addressOffset = (GPIOD->IDR && 0x30) >> 4;
	address = address - addressOffset;
	
	//Set up I2C
	I2C->CR1 |= 0x01;  						//Enable I2C peripheral
	I2C->CR2 = 0x04;	 						//Enable I2C acknowledgement
	I2C->FREQR = 16; 	 						// Set I2C Freq value (16MHz)
	I2C->OARL = (address << 1) ;	// set address
	I2C->OARH = 0x40;							// Set 7bit address mode
	I2C->ITR	= 0x07;							// all I2C interrupt enable  
	
	
}

void init()
{
	//TODO: [ML] Consider changing all pins to input with pull up.
	//Set PORTC input pullup 
	//Set PA2,3 input pullup
	ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF, ITC_PRIORITYLEVEL_2);
	ITC_SetSoftwarePriority(ITC_IRQ_ADC1, ITC_PRIORITYLEVEL_2);
	
	ADC_setup();
	TIM2_setup();
}

void ADC_setup()
{
	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
	ADC1_DeInit();
	
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
             ADC1_CHANNEL_6,
             ADC1_PRESSEL_FCPU_D12, 
             ADC1_EXTTRIG_GPIO, 
             DISABLE, 
             ADC1_ALIGN_RIGHT, 
             ADC1_SCHMITTTRIG_CHANNEL6, 
             DISABLE);
	ADC1_DataBufferCmd(ENABLE);
	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
	ADC1_Cmd(ENABLE);
}

void TIM2_setup(void)
{
    TIM2_DeInit();
    TIM2_TimeBaseInit(TIM2_PRESCALER_32, 32000);
		TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
    TIM2_Cmd(ENABLE);
}

void HandleADC()
{
	uint8_t x = 0;
				
	//Sum the values into the buffer
	adcValues[idxBuffer] = 0;
	for(x = 0; x < 8; x++)
	{
		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 3);
	}
	
	//Fill up the buffer with the first value 
	//so averaging isn't skewed toward 0.  
	if(bufferEmpty)
	{
		bufferEmpty = false;
		for(x = 1; x < BUFFER_SIZE; x++)
		{
			adcValues[x] = adcValues[0];
		}
	}
	
	//Average the readings in the buffer
	averagedValue = 0;
	for(x = 0; x < BUFFER_SIZE; x++)
	{
		averagedValue += adcValues[x];
	}
	averagedValue = averagedValue / (BUFFER_SIZE * 8);
	phRaw = averagedValue;
	i2cBuffer1[0] = phRaw >> 8;
	i2cBuffer1[1] = phRaw;
	//Increment buffer and roll over
	idxBuffer++;
	if (idxBuffer >= BUFFER_SIZE)
	{
		idxBuffer = 0;
	}
	
	state &= ~(STATE_ADC_READY);
}
