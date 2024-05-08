// Arduino Sketch
void setup() {
  Serial.begin(9600);         // Start serial communication at 9600 baud rate
  pinMode(3, INPUT_PULLUP);   // Set pin 3 as an input with an internal pull-up resistor
  pinMode(4, INPUT_PULLUP);   // Set pin 4 as an input with an internal pull-up resistor
  pinMode(5, INPUT_PULLUP);   // Set pin 5 as an input with an internal pull-up resistor
  pinMode(6, INPUT_PULLUP);   // Set pin 6 as an input with an internal pull-up resistor
}

void loop() {
  // Read the state of the buttons
  int buttonState3 = digitalRead(3);
  int buttonState4 = digitalRead(4);
  int buttonState5 = digitalRead(5);
  int buttonState6 = digitalRead(6);

  // Send the button states over serial, separated by commas
  Serial.print(buttonState3);
  Serial.print(",");
  Serial.print(buttonState4);
  Serial.print(",");
  Serial.print(buttonState5);
  Serial.print(",");
  Serial.println(buttonState6);  // 'println' for a new line at the end

  delay(100);  // Delay for a short period to avoid sending too much data
}
