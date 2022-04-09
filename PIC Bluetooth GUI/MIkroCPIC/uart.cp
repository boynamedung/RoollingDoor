#line 1 "C:/Users/ADMIN/Desktop/uart_test/uart.c"


int count = 0;
int count1 = 0;
char Receivedata;
int old_state = 0;
unsigned char readbuff[ 64 ] absolute 0x500;
unsigned char writebuff[ 64 ] absolute 0x540;
sbit LCD_RS at LATD0_bit;
sbit LCD_EN at LATD1_bit;
sbit LCD_D4 at LATD2_bit;
sbit LCD_D5 at LATD3_bit;
sbit LCD_D6 at LATD4_bit;
sbit LCD_D7 at LATD5_bit;

sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD2_bit;
sbit LCD_D5_Direction at TRISD3_bit;
sbit LCD_D6_Direction at TRISD4_bit;
sbit LCD_D7_Direction at TRISD5_bit;
void interrupt()
{
 if(PIR1.RCIF == 1)
 {
 PIR1.RCIF = 0;
 if (UART1_Data_Ready() == 1)
 {
 ReceiveData = UART1_Read();
 if(ReceiveData == '1')
 {
 PORTE.B0 = 1;
 PORTE.B1 = 0;
 old_state = 1;
 }
 if(ReceiveData == '3')
 {
 PORTE.B1 = 1;
 PORTE.B0 = 0;
 old_state = 3;
 }
 if(ReceiveData == '2')
 {
 PORTE.B0 = 0;
 old_state = 2;
 }
 if(ReceiveData == '4')
 {
 PORTE.B1 = 0;
 old_state = 4;
 }
 }
 }
 if(INTCON.INT0IF == 1)
 {
 INTCON.INT0IF = 0;
 count++;
 if((count % 2) != 0)
 {
 old_state = 1;
 PORTE.B0 = 1;
 PORTE.B1 = 0;
 }
 if((count % 2) == 0)
 {
 old_state = 2;
 PORTE.B0 = 0;
 count = 0;
 }
 }
 if(INTCON3.INT1IF == 1)
 {
 INTCON3.INT1IF = 0;
 count1++;
 if((count1 % 2) != 0)
 {
 old_state = 3;
 PORTE.B1 = 1;
 PORTE.B0 = 0;
 }
 if((count1 % 2) == 0)
 {
 old_state = 4;
 PORTE.B1 = 0;
 count1 = 0;
 }
 }
 }
void main()
{
 Lcd_Init();
 Lcd_Cmd(_Lcd_CLEAR);
 Lcd_Cmd(_Lcd_CURSOR_OFF);
 UART1_Init(9600);
 Lcd_Out(1,1,"Trang thai cua cuon");
 ADCON1 |= 0x0F;
 CMCON |= 0x07;
 PORTB = 0x00; LATB = 0x00;
 TRISB.TRISB0 = 1;
 TRISB.TRISB1 = 1;
 INTCON2.RBPU = 0;
 PORTE = 0x00; LATE = 0x00;
 TRISE.TRISE0 = 0;
 TRISE.TRISE1 = 0;
 PORTA = 0x00; LATA = 0x00;
 TRISA.TRISA0 = 1;
 TRISA.TRISA1 = 1;
 INTCON.INT0IF = 0;
 INTCON3.INT1IF = 0;
 INTCON.INT0IE = 1;
 INTCON3.INT1IE = 1;
 INTCON2.INTEDG0 = 1;
 INTCON2.INTEDG1 = 1;
 PIR1.RCIF = 0;
 PIE1.RCIE = 1;
 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 while(1)
 {
 if(PORTA.B0 == 0)
 {
 PORTE.B0 = 0;
 count = 0;
 Lcd_Out(2,1,"Da mo               ");
 old_state = 2;
 }
 if(PORTA.B1 == 0)
 {
 PORTE.B1 = 0;
 count1 = 0;
 Lcd_Out(2,1,"Da dong             ");
 old_state = 4;
 }
 if(old_state == 1)
 {
 Lcd_Out(2,1,"Dang mo cua         ");
 old_state = 0;
 UART1_Write_Text("A");
 }
 else if(old_state == 2)
 {
 Lcd_Out(2,1,"Da mo               ");
 old_state = 0;
 UART1_Write_Text("B");
 }
 else if(old_state == 3)
 {
 Lcd_Out(2,1,"Dang dong cua       ");
 old_state = 0;
 UART1_Write_Text("C");
 }
 else if(old_state == 4)
 {
 Lcd_Out(2,1,"Da dong             ");
 old_state = 0;
 UART1_Write_Text("D");
 }
}
}
