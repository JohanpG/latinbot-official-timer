
const byte LED = 3;  // Timer 2 "B" output: OC2B

#define PIN_IR 3
#define PIN_DETECT 2
#define PIN_STATUS 5

const long frequency = 38000L;  // Hz

void setup() 
{
  pinMode (LED, OUTPUT);

  TCCR2A = bit (WGM20) | bit (WGM21) | bit (COM2B1); // fast PWM, clear OC2B on compare
  TCCR2B = bit (WGM22) | bit (CS21);         // fast PWM, prescaler of 8
  OCR2A =  ((F_CPU / 8) / frequency) - 1;    // zero relative  
  OCR2B = ((OCR2A + 1) / 4) - 1;             // 50% duty cycle
//  pinMode(PIN_DETECT, INPUT);
//  pinMode(PIN_STATUS, OUTPUT);
//
//  Serial.begin(9600);
}  // end of setup

void loop()
{

//  digitalWrite(PIN_STATUS, !digitalRead(PIN_DETECT));
//  Serial.println(!digitalRead(PIN_DETECT));
  delay(100);
}
