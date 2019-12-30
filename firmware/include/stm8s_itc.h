/**
  ******************************************************************************
  * @file    stm8s_itc.h
  * @author  MCD Application Team
  * @version V2.3.0
  * @date    16-June-2017
  * @brief   This file contains all functions prototype and macros for the ITC peripheral.
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM8S_ITC_H
#define __STM8S_ITC_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Exported types ------------------------------------------------------------*/

/** @addtogroup ITC_Exported_Types
  * @{
  */

/**
  * @brief  ITC Interrupt Lines selection
  */
typedef enum {
	ITC_IRQ_TIM2_OVF       = (uint8_t)13,  /*!< TIM2 update /overflow interrupt */
  ITC_IRQ_I2C            = (uint8_t)19,  /*!< I2C interrupt */
	ITC_IRQ_ADC1           = (uint8_t)22  /*!< ADC1 interrupt */
} ITC_Irq_TypeDef;

/**
  * @brief  ITC Priority Levels selection
  */
typedef enum {
  ITC_PRIORITYLEVEL_0 = (uint8_t)0x02, /*!< Software priority level 0 (cannot be written) */
  ITC_PRIORITYLEVEL_1 = (uint8_t)0x01, /*!< Software priority level 1 */
  ITC_PRIORITYLEVEL_2 = (uint8_t)0x00, /*!< Software priority level 2 */
  ITC_PRIORITYLEVEL_3 = (uint8_t)0x03  /*!< Software priority level 3 */
} ITC_PriorityLevel_TypeDef;

/**
  * @}
  */

/* Private macros ------------------------------------------------------------*/

/**
  * @brief  Macros used by the assert function in order to check the different functions parameters.
  * @addtogroup ITC_Private_Macros
  * @{
  */

void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue);

/**
  * @}
  */

#endif /* __STM8S_ITC_H */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
