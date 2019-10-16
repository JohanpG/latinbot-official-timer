#define PIN_DETECT 2 // This is where the IR detector "out" signal is connected to
#define PIN_STATUS 13 // Used to indicate a break in the barrier, could be a buzzer or something else
 
volatile boolean irbeamup = true; // This value is changed by the Interrupt code 
 boolean flag=false;                                  // and is used both inside and outside the Interrupt code = volatile 
long lastuptime = 0;               // Indicates how many milliseconds since we last had a beam detected
long lapTime = 0; 
long startTime = 0; 
char val; // Data received from the serial port 


void irchanged()
// Interrupt Service Routine for detecting change in the IR reading
// This is connected to Pin 2 on the Arduino
// If there is IR, the value is low, if there is no IR, the value is high
// We want to execute and exit the code as quick as possible, so we only read the value to set the
// boolean irbeamup flag
 
{
   if (digitalRead(PIN_DETECT) == LOW) irbeamup = true;
   else irbeamup = false;
}
 
void setup()
{
    Serial.begin(9600); // Start serial communication at 9600 bps
    pinMode(PIN_DETECT, INPUT);             // This is where we read the IR detector
    pinMode(PIN_STATUS, OUTPUT);            // To show some status
    attachInterrupt(0, irchanged, CHANGE);  // Here the magic is happening: On a CHANGE on Port 0 (Pin 2), 
                                            // the irchanged function will interrupt whatever is going on
}
 
void loop() {
  if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }
   if (val == '1') 
   { // If 1 was received
   
     startTime=millis();
     flag=true;
     val == '0';
    
   } else {
     startTime=0;
     val == '0';
     
   }

   if ((irbeamup == true) && (flag==true)) {                     // We have a beam 
        lastuptime = millis();                 // So set the current time to lastuptime
        digitalWrite(PIN_STATUS, HIGH);        // Light the LED, we have a beam
   }
   else {                                      // A break in the beam was detected
                                               // However, if less than 100 mS since last IR was detected,
                                               // I do not yet indicate a break
        if ((millis() - lastuptime > 5)&& (flag==true)) {
                  digitalWrite(PIN_STATUS, LOW);
                  lapTime=millis()-startTime;
                  Serial.println(lapTime);
                  Serial.flush();
                  flag=false;
                  // Other actions for the break. We know we last had a beam at lastuptime.
        }
        else{
          }
   }
}
