
_interrupt:

;uart.c,22 :: 		void interrupt()
;uart.c,24 :: 		if(PIR1.RCIF == 1)
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt0
;uart.c,26 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;uart.c,27 :: 		if (UART1_Data_Ready() == 1)
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;uart.c,29 :: 		ReceiveData = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Receivedata+0 
;uart.c,30 :: 		if(ReceiveData == '1')
	MOVF        R0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;uart.c,32 :: 		PORTE.B0 = 1;
	BSF         PORTE+0, 0 
;uart.c,33 :: 		PORTE.B1 = 0;
	BCF         PORTE+0, 1 
;uart.c,34 :: 		old_state = 1;
	MOVLW       1
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,35 :: 		}
L_interrupt2:
;uart.c,36 :: 		if(ReceiveData == '3')
	MOVF        _Receivedata+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;uart.c,38 :: 		PORTE.B1 = 1;
	BSF         PORTE+0, 1 
;uart.c,39 :: 		PORTE.B0 = 0;
	BCF         PORTE+0, 0 
;uart.c,40 :: 		old_state = 3;
	MOVLW       3
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,41 :: 		}
L_interrupt3:
;uart.c,42 :: 		if(ReceiveData == '2')
	MOVF        _Receivedata+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;uart.c,44 :: 		PORTE.B0 = 0;
	BCF         PORTE+0, 0 
;uart.c,45 :: 		old_state = 2;
	MOVLW       2
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,46 :: 		}
L_interrupt4:
;uart.c,47 :: 		if(ReceiveData == '4')
	MOVF        _Receivedata+0, 0 
	XORLW       52
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
;uart.c,49 :: 		PORTE.B1 = 0;
	BCF         PORTE+0, 1 
;uart.c,50 :: 		old_state = 4;
	MOVLW       4
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,51 :: 		}
L_interrupt5:
;uart.c,52 :: 		}
L_interrupt1:
;uart.c,53 :: 		}
L_interrupt0:
;uart.c,54 :: 		if(INTCON.INT0IF == 1)
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt6
;uart.c,56 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;uart.c,57 :: 		count++;
	INFSNZ      _count+0, 1 
	INCF        _count+1, 1 
;uart.c,58 :: 		if((count % 2) != 0)
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _count+0, 0 
	MOVWF       R0 
	MOVF        _count+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt25
	MOVLW       0
	XORWF       R0, 0 
L__interrupt25:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt7
;uart.c,60 :: 		old_state = 1;
	MOVLW       1
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,61 :: 		PORTE.B0 = 1;
	BSF         PORTE+0, 0 
;uart.c,62 :: 		PORTE.B1 = 0;
	BCF         PORTE+0, 1 
;uart.c,63 :: 		}
L_interrupt7:
;uart.c,64 :: 		if((count % 2) == 0)
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _count+0, 0 
	MOVWF       R0 
	MOVF        _count+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt26
	MOVLW       0
	XORWF       R0, 0 
L__interrupt26:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;uart.c,66 :: 		old_state = 2;
	MOVLW       2
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,67 :: 		PORTE.B0 = 0;
	BCF         PORTE+0, 0 
;uart.c,68 :: 		count = 0;
	CLRF        _count+0 
	CLRF        _count+1 
;uart.c,69 :: 		}
L_interrupt8:
;uart.c,70 :: 		}
L_interrupt6:
;uart.c,71 :: 		if(INTCON3.INT1IF == 1)
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt9
;uart.c,73 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;uart.c,74 :: 		count1++;
	INFSNZ      _count1+0, 1 
	INCF        _count1+1, 1 
;uart.c,75 :: 		if((count1 % 2) != 0)
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _count1+0, 0 
	MOVWF       R0 
	MOVF        _count1+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt27
	MOVLW       0
	XORWF       R0, 0 
L__interrupt27:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt10
;uart.c,77 :: 		old_state = 3;
	MOVLW       3
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,78 :: 		PORTE.B1 = 1;
	BSF         PORTE+0, 1 
;uart.c,79 :: 		PORTE.B0 = 0;
	BCF         PORTE+0, 0 
;uart.c,80 :: 		}
L_interrupt10:
;uart.c,81 :: 		if((count1 % 2) == 0)
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _count1+0, 0 
	MOVWF       R0 
	MOVF        _count1+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt28
	MOVLW       0
	XORWF       R0, 0 
L__interrupt28:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
;uart.c,83 :: 		old_state = 4;
	MOVLW       4
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,84 :: 		PORTE.B1 = 0;
	BCF         PORTE+0, 1 
;uart.c,85 :: 		count1 = 0;
	CLRF        _count1+0 
	CLRF        _count1+1 
;uart.c,86 :: 		}
L_interrupt11:
;uart.c,87 :: 		}
L_interrupt9:
;uart.c,88 :: 		}
L_end_interrupt:
L__interrupt24:
	RETFIE      1
; end of _interrupt

_main:

;uart.c,89 :: 		void main()
;uart.c,91 :: 		Lcd_Init();                // Inicializa LCD
	CALL        _Lcd_Init+0, 0
;uart.c,92 :: 		Lcd_Cmd(_Lcd_CLEAR);       // Limpiar display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;uart.c,93 :: 		Lcd_Cmd(_Lcd_CURSOR_OFF);  // Desactivar cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;uart.c,94 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;uart.c,95 :: 		Lcd_Out(1,1,"Trang thai cua cuon");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_uart+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_uart+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;uart.c,96 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;uart.c,97 :: 		CMCON |= 0x07;
	MOVLW       7
	IORWF       CMCON+0, 1 
;uart.c,98 :: 		PORTB = 0x00; LATB = 0x00;
	CLRF        PORTB+0 
	CLRF        LATB+0 
;uart.c,99 :: 		TRISB.TRISB0 = 1;
	BSF         TRISB+0, 0 
;uart.c,100 :: 		TRISB.TRISB1 = 1;
	BSF         TRISB+0, 1 
;uart.c,101 :: 		INTCON2.RBPU = 0;
	BCF         INTCON2+0, 7 
;uart.c,102 :: 		PORTE = 0x00; LATE = 0x00;
	CLRF        PORTE+0 
	CLRF        LATE+0 
;uart.c,103 :: 		TRISE.TRISE0 = 0;
	BCF         TRISE+0, 0 
;uart.c,104 :: 		TRISE.TRISE1 = 0;
	BCF         TRISE+0, 1 
;uart.c,105 :: 		PORTA = 0x00; LATA = 0x00;
	CLRF        PORTA+0 
	CLRF        LATA+0 
;uart.c,106 :: 		TRISA.TRISA0 = 1;
	BSF         TRISA+0, 0 
;uart.c,107 :: 		TRISA.TRISA1 = 1;
	BSF         TRISA+0, 1 
;uart.c,108 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;uart.c,109 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;uart.c,110 :: 		INTCON.INT0IE = 1;
	BSF         INTCON+0, 4 
;uart.c,111 :: 		INTCON3.INT1IE = 1;
	BSF         INTCON3+0, 3 
;uart.c,112 :: 		INTCON2.INTEDG0 = 1;
	BSF         INTCON2+0, 6 
;uart.c,113 :: 		INTCON2.INTEDG1 = 1;
	BSF         INTCON2+0, 5 
;uart.c,114 :: 		PIR1.RCIF = 0;
	BCF         PIR1+0, 5 
;uart.c,115 :: 		PIE1.RCIE = 1;
	BSF         PIE1+0, 5 
;uart.c,116 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;uart.c,117 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;uart.c,118 :: 		while(1)
L_main12:
;uart.c,120 :: 		if(PORTA.B0 == 0)
	BTFSC       PORTA+0, 0 
	GOTO        L_main14
;uart.c,122 :: 		PORTE.B0 = 0;
	BCF         PORTE+0, 0 
;uart.c,123 :: 		count = 0;
	CLRF        _count+0 
	CLRF        _count+1 
;uart.c,124 :: 		Lcd_Out(2,1,"Da mo               ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_uart+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_uart+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;uart.c,125 :: 		old_state = 2;
	MOVLW       2
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,126 :: 		}
L_main14:
;uart.c,127 :: 		if(PORTA.B1 == 0)
	BTFSC       PORTA+0, 1 
	GOTO        L_main15
;uart.c,129 :: 		PORTE.B1 = 0;
	BCF         PORTE+0, 1 
;uart.c,130 :: 		count1 = 0;
	CLRF        _count1+0 
	CLRF        _count1+1 
;uart.c,131 :: 		Lcd_Out(2,1,"Da dong             ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_uart+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_uart+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;uart.c,132 :: 		old_state = 4;
	MOVLW       4
	MOVWF       _old_state+0 
	MOVLW       0
	MOVWF       _old_state+1 
;uart.c,133 :: 		}
L_main15:
;uart.c,134 :: 		if(old_state == 1)
	MOVLW       0
	XORWF       _old_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVLW       1
	XORWF       _old_state+0, 0 
L__main30:
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;uart.c,136 :: 		Lcd_Out(2,1,"Dang mo cua         ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_uart+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_uart+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;uart.c,137 :: 		old_state = 0;
	CLRF        _old_state+0 
	CLRF        _old_state+1 
;uart.c,138 :: 		UART1_Write_Text("A");
	MOVLW       ?lstr5_uart+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_uart+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;uart.c,139 :: 		}
	GOTO        L_main17
L_main16:
;uart.c,140 :: 		else if(old_state == 2)
	MOVLW       0
	XORWF       _old_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVLW       2
	XORWF       _old_state+0, 0 
L__main31:
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;uart.c,142 :: 		Lcd_Out(2,1,"Da mo               ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_uart+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_uart+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;uart.c,143 :: 		old_state = 0;
	CLRF        _old_state+0 
	CLRF        _old_state+1 
;uart.c,144 :: 		UART1_Write_Text("B");
	MOVLW       ?lstr7_uart+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_uart+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;uart.c,145 :: 		}
	GOTO        L_main19
L_main18:
;uart.c,146 :: 		else if(old_state == 3)
	MOVLW       0
	XORWF       _old_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVLW       3
	XORWF       _old_state+0, 0 
L__main32:
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;uart.c,148 :: 		Lcd_Out(2,1,"Dang dong cua       ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_uart+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_uart+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;uart.c,149 :: 		old_state = 0;
	CLRF        _old_state+0 
	CLRF        _old_state+1 
;uart.c,150 :: 		UART1_Write_Text("C");
	MOVLW       ?lstr9_uart+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_uart+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;uart.c,151 :: 		}
	GOTO        L_main21
L_main20:
;uart.c,152 :: 		else if(old_state == 4)
	MOVLW       0
	XORWF       _old_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       4
	XORWF       _old_state+0, 0 
L__main33:
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
;uart.c,154 :: 		Lcd_Out(2,1,"Da dong             ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_uart+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_uart+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;uart.c,155 :: 		old_state = 0;
	CLRF        _old_state+0 
	CLRF        _old_state+1 
;uart.c,156 :: 		UART1_Write_Text("D");
	MOVLW       ?lstr11_uart+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_uart+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;uart.c,157 :: 		}
L_main22:
L_main21:
L_main19:
L_main17:
;uart.c,158 :: 		}
	GOTO        L_main12
;uart.c,159 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
