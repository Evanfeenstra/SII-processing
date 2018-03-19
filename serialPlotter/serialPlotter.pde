import processing.serial.*;
int windowWidth = 600;
int windowHeight = 400;
float[] readings = new float[windowWidth]; // initialized to zeroes
boolean gotData = false;
int lowest = 1023;
PFont myFont;

Serial myPort;

void setup () {
  size(windowWidth, windowHeight);        
  myFont = createFont("Arial", 13);
  
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600); 
  myPort.bufferUntil('\n');
  background(0);
  
}
void draw () {
  if(gotData==true){
    background(0);
    
    stroke(127,34,255);
    strokeWeight(2);
    for (int i = 2; i < windowWidth-1; i++) {
      if (readings[i] != 0) {
        line(i/2-1, readings[i-2], i/2, readings[i-1]); 
      }
      readings[i] = readings[i + 1];
    }
    
    stroke(127,255,255);
    strokeWeight(1);
    line(0,height-lowest,windowWidth,height-lowest);
    
    textFont(myFont);
    text(lowest,windowWidth-30, height-lowest-3);
    
    gotData=false;
  }
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    float inByte = float(inString);
    inByte = map(inByte, 0, 1023, 0, height); //map to the screen height.
    readings[windowWidth-1] = height - inByte;
    
    if(inByte < lowest){
      lowest = int(inByte);
    }
    gotData = true;
  }
}

void keyPressed(){
  if(keyCode==32){
    lowest = 1023; 
  }
}
