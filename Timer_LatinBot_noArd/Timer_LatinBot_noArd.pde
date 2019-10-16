import controlP5.*;
import java.nio.ByteBuffer;
import processing.serial.*;
PImage bg;
int y;
float Input, Setpoint, Output;
String val;
double currentTime=0;
double nowTime=0;
boolean flag= false;
Serial myPort;

ControlP5 controlP5;
controlP5.Textfield SPField,myfield;
controlP5.Button b;
void setup() {
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  frameRate(30);
  size(1360, 765);
  println(Serial.list());                                           // * Initialize Serial
  myPort = new Serial(this, Serial.list()[0], 9600);                //   Communication with
  myPort.bufferUntil('\n'); 
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 640 x 360 pixels.
  bg = loadImage("/images/TimerLatinbot1.jpg");
  controlP5 = new ControlP5(this); 

  
   ControlFont cf1 = new ControlFont(createFont("Arial",80));
   ControlFont cf2 = new ControlFont(createFont("Arial",20));
   createButton("Start/Stop",0,580,455,color(255,0,0),cf2);
   createField("",10,200,100,color(255,0,0),cf1);
  // SPField= controlP5.addTextfield("",750,330,400,200);
}
Button createButton(String theName, int theValue, int theX, int theY, color theColor, ControlFont theFont) {
  Button b = controlP5.addButton(theName,theValue,theX,theY,130,80);
  b.setColorActive(theColor); // color for mouse-over
  b.setColorBackground(color(90)); // default color
  b.captionLabel().setControlFont(theFont);
  return b;
}

Textfield createField(String theName, int theValue, int theX, int theY, color theColor, ControlFont theFont) {
   myfield = controlP5.addTextfield(theName,750,330,400,200);
  // myfield.setColorActive(theColor); // color for mouse-over
  myfield.setColorBackground(color(90)); // default color
  myfield.captionLabel().setControlFont(theFont);
  myfield.setFont(theFont);
  return myfield;
}

void draw() {
  background(bg);
  if (flag==true){
  currentTime=(millis()-nowTime)/1000;
  
  }
  myfield.setText(currentTime +" s");
  stroke(226, 204, 0);
  line(0, y, width, y);
  
  y++;
  if (y > height) {
    y = 0; 
  }
}

 
void controlEvent(ControlEvent theEvent) {
if(theEvent.isController()) { 
    
    print("control event from : "+theEvent.controller().name());
    println(", value : "+theEvent.controller().value());
    
   
    
    if(theEvent.controller().name()=="Start/Stop") {
      myPort.write('1');         //send a 1
      println("1"); 
      nowTime=millis();
      flag=!flag;
    }
  }
}
