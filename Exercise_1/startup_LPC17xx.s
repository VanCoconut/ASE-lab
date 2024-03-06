;/*****************************************************************************
; * @file:    startup_LPC17xx.s
; * @purpose: CMSIS Cortex-M3 Core Device Startup File 
; *           for the NXP LPC17xx Device Series 
; * @version: V1.01
; * @date:    21. December 2009
; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------
; *
; * Copyright (C) 2009 ARM Limited. All rights reserved.
; * ARM Limited (ARM) is supplying this software for use with Cortex-M3 
; * processor based microcontrollers.  This file can be freely distributed 
; * within development tools that are supporting such ARM based processors. 
; *
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; *****************************************************************************/


; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
				DCD		USBActivity_IRQHandler    ; USB Activity interrupt to wakeup
				DCD		CANActivity_IRQHandler    ; CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF


                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                IMPORT  __main
                LDR     R0, =__main
                BX      R0
                ENDP

;function
				AREA ASM_functions, CODE, READONLY
					
					
translate_morse PROC
				EXPORT translate_morse
				
				MOV R12, sp
				STMFD sp!, {r4-r8, r10-r11, lr}
				LDR R4, [R12]			;QUESTO è 2
				LDR	R5, [R12, #4]		;3
				LDR R6, [R12, #8]		;4
				
reading_input	LDRB R7, [R0], #1 	;valori del vettore input
				CMP R7, R4			;se non è 2 continuo
				BEQ end_character
				CMP R7, R5			;se non è 3 continuo
				BEQ end_character
				CMP R7, R6			;se non è 4 continuo
				BEQ end_character
				ADD R9, #1 			;contatore di lunghezza bit
				ADD R8, R7, R8 		;il valore recuperato lo copio su r8
				LSL R8, #1			;shifto r8 di 1
				BNE reading_input
				
end_character	LSR R8, #1
				
				CMP R9, #1 	;numero è ad 1 bit
				BEQ onebit
				
				CMP R9, #2 ; numero a 2 bit
				BEQ twobits
				
				CMP R9, #3 ; numero a 3 bit
				BEQ threebits
				
				CMP R9, #4 ; numero a 4 bit
				BEQ fourbits
				
				CMP R9, #5 ; numero a 4 bit
				BEQ fourbits
				
onebit			CMP R8, #0
				MOVEQ R10, #69 ;E
				
				CMP R8, #1
				MOVEQ R10, #84 ;T
				BEQ finish_1
				
twobits			CMP R8, #0
				MOVEQ R10, #73 ;I
				
				CMP R8, #1
				MOVEQ R10, #65 ;A
				
				CMP R8, #2
				MOVEQ R10, #78 ;N
				
				CMP R8, #3
				MOVEQ R10, #77 ;M
				BEQ finish_2
				
finish_1		B finish_2

threebits		CMP R8, #0
				MOVEQ R10, #83 ;S
				BEQ finish_2
				
				CMP R8, #1
				MOVEQ R10, #85 ;U
				BEQ finish_2
				
				CMP R8, #2
				MOVEQ R10, #82 ;R
				BEQ finish_2
				
				CMP R8, #3
				MOVEQ R10, #87 ;W
				BEQ finish_2
				
				CMP R8, #4
				MOVEQ R10, #68 ;D
				BEQ finish_2
				
				CMP R8, #5
				MOVEQ R10, #75 ;K
				BEQ finish_2
				
				CMP R8, #6
				MOVEQ R10, #71 ;G
				BEQ finish_2
				
				CMP R8, #7
				MOVEQ R10, #79 ;O
				BEQ finish_2
				
finish_2		B finish_3
				
fourbits		CMP R9, #5 ; numero a 5 bit
				BEQ fivebits

				CMP R8, #0
				MOVEQ R10, #72 ;H
				BEQ finish_3
				
				CMP R8, #1
				MOVEQ R10, #86 ;V
				BEQ finish_3
				
				CMP R8, #2
				MOVEQ R10, #70 ;F
				BEQ finish_3
				
				CMP R8, #8
				MOVEQ R10, #66 ;B
				BEQ finish_3
				
				CMP R8, #10
				MOVEQ R10, #67 ;C
				BEQ finish_3
				
				CMP R8, #7
				MOVEQ R10, #74 ;J
				BEQ finish_3
				
				CMP R8, #4
				MOVEQ R10, #76 ;L
				BEQ finish_3
				
				CMP R8, #6
				MOVEQ R10, #80 ;P
				BEQ finish_3
				
				CMP R8, #13
				MOVEQ R10, #81 ;Q
				BEQ finish_3
				
				CMP R8, #9
				MOVEQ R10, #88 ;X
				BEQ finish_3
				
				CMP R8, #11
				MOVEQ R10, #89 ;Y
				BEQ finish_3
				
				CMP R8, #12
				MOVEQ R10, #90 ;Z
				BEQ finish_3
				
finish_3		B finish

fivebits 		CMP R8, #31
				MOVEQ R10, #48 ;0
				BEQ finish

				CMP R8, #15
				MOVEQ R10, #49 ;1
				BEQ finish
				
				CMP R8, #7
				MOVEQ R10, #50 ;2
				BEQ finish
				
				CMP R8, #3
				MOVEQ R10, #51 ;3
				BEQ finish
				
				CMP R8, #1
				MOVEQ R10, #52 ;4
				BEQ finish
				
				CMP R8, #0
				MOVEQ R10, #53 ;5
				BEQ finish
				
				CMP R8, #16
				MOVEQ R10, #54 ;6
				BEQ finish
				
				CMP R8, #24
				MOVEQ R10, #55 ;7
				BEQ finish
				
				CMP R8, #28
				MOVEQ R10, #56 ;8
				BEQ finish
				
				CMP R8, #30
				MOVEQ R10, #57 ;9
				BEQ finish
				
				
finish   		STRB R10, [R2], #4
				ADD R11, R11, #1
				MOV R9, #0
				MOV R8, #0
				CMP R7, #4
				BEQ	out 
				BNE reading_input
				
				
out				MOV R0, R11
				LDMFD sp!, {r4-r8, r10-r11, pc}
				ENDP

; Dummy Exception Handlers (infinite loops which can be modified)                

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
				EXPORT  USBActivity_IRQHandler    [WEAK]
				EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler           
TIMER0_IRQHandler         
TIMER1_IRQHandler         
TIMER2_IRQHandler         
TIMER3_IRQHandler         
UART0_IRQHandler          
UART1_IRQHandler          
UART2_IRQHandler          
UART3_IRQHandler          
PWM1_IRQHandler           
I2C0_IRQHandler           
I2C1_IRQHandler           
I2C2_IRQHandler           
SPI_IRQHandler            
SSP0_IRQHandler           
SSP1_IRQHandler           
PLL0_IRQHandler           
RTC_IRQHandler            
EINT0_IRQHandler          
EINT1_IRQHandler          
EINT2_IRQHandler          
EINT3_IRQHandler          
ADC_IRQHandler            
BOD_IRQHandler            
USB_IRQHandler            
CAN_IRQHandler            
DMA_IRQHandler          
I2S_IRQHandler            
ENET_IRQHandler       
RIT_IRQHandler          
MCPWM_IRQHandler             
QEI_IRQHandler            
PLL1_IRQHandler           
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB
                
                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit
                
                ELSE
                
                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
