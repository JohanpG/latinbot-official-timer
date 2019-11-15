import controlP5.*;
import java.nio.ByteBuffer;
import processing.serial.*;
PImage bg;
int y;
float Input, Setpoint, Output;
String val="0.0";
float valor=0.0;

double nowTime=0;
boolean flag= false;
Serial myPort;

ControlP5 controlP5;
controlP5.Textfield myfield1,myfield;
controlP5.Button b;
void setup() {
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify(); 
  frameRate(30);
  size(1280, 1024);
  println(Serial.list());                                           // * Initialize Serial
  myPort = new Serial(this, Serial.list()[0], 9600);                //   Communication with
  myPort.bufferUntil('\n'); 
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 640 x 360 pixels.
  bg = loadImage("/images/TimerLatinbot2.jpg");
  controlP5 = new ControlP5(this); 

  
   ControlFont cf1 = new ControlFont(createFont("Arial",140));
   ControlFont cf2 = new ControlFont(createFont("Arial",20));
   createField("",450,400,700,400,color(255,0,0),cf1);
  // SPField= controlP5.addTextfield("",750,330,400,200);
}
Button createButton(String theName, int theValue, int theX, int theY, color theColor, ControlFont theFont) {
  Button b = controlP5.addButton(theName,theValue,theX,theY,143,80);
  b.setColorActive(theColor); // color for mouse-over
  b.setColorBackground(color(90)); // default color
  b.captionLabel().setControlFont(theFont);
  return b;
}

Textfield createField(String theName, int theX, int theY,int theW,int theH, color theColor, ControlFont theFont) {
   myfield = controlP5.addTextfield(theName,theX,theY,theW,theH);
  // myfield.setColorActive(theColor); // color for mouse-over
  myfield.setColorBackground(color(90)); // default color
  myfield.captionLabel().setControlFont(theFont);
  myfield.setFont(theFont);
  return myfield;
}



void draw() {
  background(bg);
 
  myfield.setText(valor/1000 +" s");

  
 
}

void keyPressed(){
     if (key == ESC) { //The ASCII code for esc is 27, so therefore: 27
     //insert your function here
     key=0 ;
     // Clear the buffer, or available() will still be > 0
      myPort.clear();
      // Close the port
      myPort.stop();
      println(" I'm done!");
      exit();
   
}
} 


void controlEvent(ControlEvent theEvent) {
if(theEvent.isController()) { 
    
    print("control event from : "+theEvent.controller().name());
    println(", value : "+theEvent.controller().value());
    
  
  }
}

void serialEvent( Serial myPort) {
//put the incoming data into a String - 
//the '\n' is our end delimiter indicating the end of a complete packet
val = myPort.readStringUntil('\n');
//make sure our data isn't empty before continuing
if (val != null) {
  //trim whitespace and formatting characters (like carriage return)
//  val = trim(val);
  println(val);
  valor=Float.parseFloat(val);
  
}
}
