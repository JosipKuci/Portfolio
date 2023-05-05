#include <LiquidCrystal.h>         

LiquidCrystal lcd(12, 11, 5, 4, 3, 2); 
const int inPin = 0;                   
int sensor;
double temp;

void setup()
{
  lcd.begin(16,2);
}
void loop()
{
  sensor = analogRead(inPin); 
  lcd.setCursor(0,1);
  temp = (double)sensor / 1024;       
  temp = temp * 5;                 
  temp = temp - 0.5;               
  temp = temp * 100;               
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Temperatura: ");
  lcd.setCursor(0,1);
  lcd.print(temp);
  lcd.print("C");
  delay(500);
}