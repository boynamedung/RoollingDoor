#include <LiquidCrystal.h>
const int rs = 9, en = 8, d4 = 7, d5 = 6, d6 = 5, d7 = 4;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
#define motor1_pin 13 //khai báo 1 chân động cơ pin 13
#define motor2_pin 12 //khai báo 1 chân động cơ pin 12
#define sw1_pin 2 //khai báo chân nút nhấn pin 2
#define sw2_pin 3 //khai báo chân nút nhấn pin 3
#define sw11 11 //khai báo chân switches pin 11
#define sw22 10 //khai báo chân switches pin 10

int sw1_state = 0; //biến trạng thái nút nhấn 1
int sw2_state = 0; //biến trạng thái nút nhấn 2
int last_sw1; //biến trạng thái cuối cùng nút nhấn 1 
int last_sw2; //biến trạng thái cuối cùng nút nhấn 2
int count = 0; //biến đếm nút nhấn 1 khi được nhấn
int count1 = 0; //biến đếm nút nhấn 2 khi được nhấn
char receivedata; //biến lưu data truyền qua COM

void setup() {
  lcd.begin(20,4);
  lcd.setCursor(0,0);
  lcd.print("Trang thai cua cuon");
  pinMode(motor1_pin, OUTPUT); //khai báo 1 chân động cơ OUTPUT
  pinMode(motor2_pin, OUTPUT); //khai báo 1 chân động cơ OUTPUT
  pinMode(sw1_pin, INPUT_PULLUP); //khai báo chân điện trở kéo lên nút nhấn 1
  pinMode(sw2_pin, INPUT_PULLUP); //khai báo chân điện trở kéo lên nút nhấn 2
  pinMode(sw11, INPUT_PULLUP); //khai báo chân điện trở kéo lên switch 1
  pinMode(sw22, INPUT_PULLUP); //khai báo chân điện trở kéo lên switch 2
  Serial3.begin(9600,SERIAL_8N1); //baudrate 9600, data = 8, parity = none, stop = 1
  attachInterrupt(0,SW_ISR1, RISING); //cấu hình ngắt cạnh lên lúc nhấn nút 1
  attachInterrupt(1,SW_ISR2, RISING); //cấu hình ngắt cạnh lên lúc nhấn nút 2 
}

void loop(){
sw1_state = digitalRead(sw11); //đọc trạng thái switch 1 lưu vào sw1_state
sw2_state = digitalRead(sw22); //đọc trạng thái switch 2 lưu vào sw2_state
if (sw1_state != last_sw1){ //xác định trạng thái switch
    if (sw1_state == LOW) //nếu sw1_state nhấn 
    {
      digitalWrite(motor1_pin,LOW);
      Serial3.println("Da mo");
      lcd.setCursor(0,1);
      lcd.print("Da mo               ");
      count = 0; //xóa biến đếm count 
    }
}
last_sw1 = sw1_state; //lưu trạng thái cuối của switch 1
if (sw2_state != last_sw2){ //xác định trạng thái switch 
    if (sw2_state == LOW) //nếu sw2_state nhấn
    {
      digitalWrite(motor2_pin,LOW);
      Serial3.println("Da dong");
      lcd.setCursor(0,1);
      lcd.print("Da dong             ");
      count1 = 0; //xóa biến đếm count1
    }
}
last_sw2 = sw2_state; //lưu trạng thái cuối của switch 2
        if (Serial3.available() > 0) //nếu nhận data từ COM
        {
        receivedata = Serial3.read(); //lưu data nhận vào receivedata
                switch(receivedata) // sử dụng switch case để xếp data theo 4 data '1','2','3','4'
                {
               case '1':
                   digitalWrite(motor1_pin, HIGH);
                   Serial3.println("Dang mo cua");
                   lcd.setCursor(0,1);
                   lcd.print("Dang mo cua         ");
                   delay(200);
                   break;
                case '2':
                  digitalWrite(motor2_pin, HIGH);
                  Serial3.println("Dang dong cua");
                  lcd.setCursor(0,1);
                  lcd.print("Dang dong cua       ");
                  delay(200);
                  break;
                case '3':
                  digitalWrite(motor1_pin,LOW);
                  Serial3.println("Da mo");
                  lcd.setCursor(0,1);
                  lcd.print("Da mo               ");
                  delay(200);
                  break;
                case '4':
                  digitalWrite(motor2_pin,LOW);
                  Serial3.println("Da dong");
                  lcd.setCursor(0,1);
                  lcd.print("Da dong             ");
                  delay(200);
                }
                }
                }
void SW_ISR1(){ 
  count++; //tăng biến đếm nếu nút nhấn 1 được nhấn
  if (count % 2 != 0) //nhấn 1 lần, động cơ hoạt động mở
  {
    digitalWrite(motor1_pin,HIGH);
    Serial3.println("Dang mo cua");
    lcd.setCursor(0,1);
    lcd.print("Dang mo cua         ");
  }
  else if (count % 2 == 0) //nhấn 2 lần, động cơ ngừng mở
  {
    digitalWrite(motor1_pin,LOW);
    Serial3.println("Da mo");
    lcd.setCursor(0,1);
    lcd.print("Da mo               "); 
    count = 0; //xóa biến đếm count 
  }
}
void SW_ISR2(){
  count1++; //tăng biến đếm nếu nút nhấn 2 được nhấn
  if (count1 % 2 != 0) //nhấn 1 lần, động cơ hoạt động đóng
  {
    digitalWrite(motor2_pin,HIGH);
    Serial3.println("Dang dong cua");
    lcd.setCursor(0,1);
    lcd.print("Dang dong cua       ");
  }
  else if (count1 % 2 == 0) //nhấn 2 lần, động cơ ngừng đóng
  {
    digitalWrite(motor2_pin,LOW);
    Serial3.println("Da dong");
    lcd.setCursor(0,1);
    lcd.print("Da dong             ");
    count1 = 0; //xóa biến đếm count1
  }
  }
  
