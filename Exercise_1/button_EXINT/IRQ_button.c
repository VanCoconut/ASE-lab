#include "button.h"
#include "lpc17xx.h"


#include "../led/led.h"
#include "../timer/timer.h"

char vett_input[100] ={0,0,0,0,2,1,1,1,2,0,1,0,0,2,0,1,3,1,1,1,1,1,2,0,0,1,1,1,4};
int lenght_input=0;
extern int lenght_output;
char* vett_output[100];
	
extern int translate_morse(char[], int, char*[], int, char, char, char);

void EINT0_IRQHandler (void)	  	/* INT0														 */
{
	lenght_output=0;
	disable_timer(1);
	LED_Off2();
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  	/* KEY1														 */
{
	int i=0;
		LED_Off2();
		for (i = 0; i < 100; i++) {
		if(vett_input[i]==4){
			break;
		}
  }
	
		NVIC_DisableIRQ(EINT0_IRQn);		//supponendo che sono disabbilitati sin dall'inizio
		NVIC_DisableIRQ(EINT2_IRQn);
		
	init_timer(0,0x47868C0);					// 3s 
	enable_timer(0);
	
	LPC_GPIO2->FIOSET    = 0x000000FF;	//all LEDs on
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  	/* KEY2														 */
{			
	//translate_morse()
	volatile int r=0;
	NVIC_DisableIRQ(EINT0_IRQn);
	NVIC_DisableIRQ(EINT1_IRQn);
	
	r=translate_morse( &vett_input[0], lenght_input, vett_output, lenght_output, 2, 3, 4);
	lenght_output=r;
	
	init_timer(1,0xBEBC20);					//0.5s blink
	enable_timer(1);  
	
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */ 
	
	NVIC_EnableIRQ(EINT1_IRQn);                              
  NVIC_EnableIRQ(EINT0_IRQn); 	
	
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */  
	
}


