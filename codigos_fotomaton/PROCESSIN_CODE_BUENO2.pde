import processing.serial.*;

/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

import processing.video.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float inByte = 0;
boolean inByteBool = false;   //nuestra creacion


Capture cam;

void setup() {
  size(640, 480);
  
  
  //serial
  
  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[0]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
    
    // Start capturing the images from the camera
    cam.start();
  }
}

void draw() {
  
background(0);

  
//   // draw the line:
//  stroke(127, 34, 255);
//  line(xPos, height, xPos, height - inByte);

  // at the edge of the screen, go back to the beginning:
//  if (xPos >= width) {
//    xPos = 0;
//    background(0);
//  } else {
//    // increment the horizontal position:
//    xPos++;
//  }
  
  
  
  if (cam.available() == true) {
    cam.read();
  }
  
  if(inByteBool){
    
      image(cam, 0, 0);
      saveFrame("imagen-#######.jpg");
      inByteBool = false;
  
  }
 

  // The following does the same as the above image() line, but 
  // is faster when just drawing the image without any additional 
  // resizing, transformations, or tint.
  //set(0, 0, cam);
}



void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = float(inString);
    
    //condición apagado y encendido
    if(inByte>0){
      
    inByteBool = true;
    
    }else{
    
      inByteBool = false;
    }
    
    
    println(inByte);
    inByte = map(inByte, 0, 1, 0, height);
  }
}



