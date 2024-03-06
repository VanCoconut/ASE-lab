#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"

char num=0;

void EINT0_IRQHandler (void)	  
{
	num=0;
	LED_Out(0);
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	num++;
	LED_Out(num);
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	num--;
  LED_Out(num);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


