#include "stm8s.h"
#include "main.h"
#include <stdbool.h>
#include "led.h"

/*
PA1	ADC
PB4	I2C SCL
PB5	I2C SDA
PD1	SWIM
PD3	LED
PD4	ADDR1
PD5	ADDR2
*/

//TODO: Set up i2c

void init(void);
void clock_setup(void);
void GPIO_setup(void);
void ADC_setup(void);
void I2C_setup(uint16_t address);
void TIM2_setup(void);
void Delay (uint16_t nCount);
void HandleADC(void);
void HandleTimerTick(void);

volatile uint8_t state = 0;
volatile uint16_t phRaw = 0;

#define BUFFER_SIZE 32
uint16_t adcValues[BUFFER_SIZE];
uint8_t idxBuffer = 0;
bool bufferEmpty = true;

bool need = true;

uint32_t averagedValue = 0;

main()
{
	init();
	
	//SetLED(LED_PANIC, 1);
	//SetLED(LED_BLINK, 0);

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
			if (state & STATE_I2C_READY  && 1 == 0)
			{
				state &= ~(STATE_I2C_READY);
			}
			
			//Check TMR State
			if (state & STATE_TMR_TICK)
			{
				HandleTimerTick();
				if(need == true)
				{
					need = false;
					//I2C_setup(0x45);
					
				}
			}
		}
		
		wfi();
	}
}

void assert_failed(u8* file, u32 line)
{
  led.pattern = LED_PANIC;
}

void Delay(uint16_t nCount)
{
  /* Decrement nCount value */
  while (nCount != 0)
  {
    nCount--;
  }
}

void init()
{
  clock_setup();
  GPIO_setup();
	ADC_setup();
	TIM2_setup();
	I2C_setup(0x45);
	
	
	/* Enable general interrupts */
  enableInterrupts();
}

void clock_setup(void)
{
  CLK_DeInit();
                                
  CLK_HSECmd(DISABLE);
  CLK_LSICmd(DISABLE);
  CLK_HSICmd(ENABLE);
  while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
                                
  CLK_ClockSwitchCmd(ENABLE);
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV2);
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
                                
  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
		DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
                                
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
}

void GPIO_setup()
{
	//Set up LED
  GPIO_DeInit(LED_port);
  GPIO_Init(LED_port, LED_pin, GPIO_MODE_OUT_PP_LOW_FAST);
	
	//Set up ADDR
	GPIO_Init(ADDR_port, ADDR_pin_1, GPIO_MODE_IN_PU_NO_IT);
	GPIO_Init(ADDR_port, ADDR_pin_2, GPIO_MODE_IN_PU_NO_IT);
	
	//Set up  ADC
	GPIO_Init(ADC_port, ADC_pin, GPIO_MODE_IN_FL_NO_IT);
	
	//Set up I2C
	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST);
	GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);
	
}

void ADC_setup()
{
	ADC1_DeInit();
	
	ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS, 
             ADC1_CHANNEL_6,
             ADC1_PRESSEL_FCPU_D8, 
             ADC1_EXTTRIG_GPIO, 
             DISABLE, 
             ADC1_ALIGN_RIGHT, 
             ADC1_SCHMITTTRIG_CHANNEL6, 
             DISABLE);
	ADC1_DataBufferCmd(ENABLE);
	ADC1_ITConfig(ADC1_IT_EOCIE, ENABLE);
	ADC1_Cmd(ENABLE);
}

void I2C_setup(uint16_t address)
{
	//TODO: [ML] Set appropriate parameters for slave device
	
	I2C_DeInit();
	I2C_Init(100000, 
					 address << 1, 
					 I2C_DUTYCYCLE_2, 
					 I2C_ACK_CURR, 
					 I2C_ADDMODE_7BIT, 
					 (CLK_GetClockFreq() / 1000000));

	/* Enable Error Interrupt*/
  I2C_ITConfig((I2C_IT_TypeDef)(I2C_IT_ERR | I2C_IT_EVT | I2C_IT_BUF), ENABLE);
  
	//I2C_Cmd(ENABLE);
	//enableInterrupts();
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
		adcValues[idxBuffer] += (ADC1_GetBufferValue(x) << 2);
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
	//Increment buffer and roll over to 0 if > 31
	idxBuffer++;
	if (idxBuffer > 31)
	{
		idxBuffer = 0;
	}
	
	state &= ~(STATE_ADC_READY);
}

void HandleTimerTick()
{
	LEDTick();
	state &= ~(STATE_TMR_TICK);	
}
