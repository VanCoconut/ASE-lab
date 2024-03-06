/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"
#include "../led/led.h"

/******************************************************************************
** Function name:		Timer0_IRQHandler
**
** Descriptions:		Timer/Counter 0 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
extern unsigned char led_value;					/* defined in funct_led								*/
extern int lenght_output;
void TIMER0_IRQHandler (void)						//accende una volta si una no il led
{
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
	LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */ 
	
	NVIC_EnableIRQ(EINT2_IRQn);              // enable irq in nvic                         
  NVIC_EnableIRQ(EINT0_IRQn); 
	LPC_TIM0->IR |= 1;			// clear interrupt flag 
	LPC_GPIO2->FIOCLR    = 0x000000FF;  //all LEDs off
	
}


/******************************************************************************
** Function name:		Timer1_IRQHandler
**
** Descriptions:		Timer/Counter 1 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void TIMER1_IRQHandler (void)
{
	static uint8_t count = 0;
	if(count%2==0){
		LPC_GPIO2->FIOCLR    = 0x000000FF;  //all LEDs off
		LPC_TIM1->IR = 1;			/* clear interrupt flag */
		count++;
		return;
	}
	LPC_TIM1->IR = 1;			/* clear interrupt flag */
	LED_Out(lenght_output);	
	count++;
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
