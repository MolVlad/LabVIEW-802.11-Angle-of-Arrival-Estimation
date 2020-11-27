#include <Servo.h>

Servo servo;  // Создаем объект
void setup() {
    Serial.begin(9600);
  servo.attach(9);   // Указываем объекту класса Servo, что серво присоединен к пину 9
  servo.write(0);   // Выставляем начальное положение 
  int data = Serial.read();
  }

void loop() {
  if (Serial.available() > 0) {
    int data = Serial.parseInt();
    if ((data > 0) && (data <= 180))
    {
      Serial.println(data);
      servo.write(data);
    }
    if (data == -1) {
      Serial.println(0);
      servo.write(0);
    }
  }
}
