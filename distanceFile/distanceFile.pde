import processing.serial.*;
PrintWriter output;
Serial udSerial;

void setup() {
  udSerial = new Serial(this, Serial.list()[1], 115200);
  print(udSerial);
  output = createWriter("ranges.csv");
  output.println("distance");
}

void draw() {
  if (udSerial.available() > 0) {
    String SenVal = udSerial.readString();
    print(SenVal);
    if (SenVal != null) {
      output.print(SenVal);
    }
  }
}

void keyPressed(){
  output.flush();
  output.close();
  print("CLOSED!");
  exit(); 
}
