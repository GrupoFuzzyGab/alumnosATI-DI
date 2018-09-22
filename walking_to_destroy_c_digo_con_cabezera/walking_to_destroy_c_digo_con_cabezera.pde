
/**
 *                                                                                                                 
 *     `````                     ```````                             
 * ``,,;::,,..`..``   ```.`..`...,::;::,.`          ``......``.`..`  
 * `,:+#@##:,,,+:.`   .,+:,,,+::'+@@###;,.`         .',:;+,:,,',:,.` 
 * `,:##+++;:::+:,.   .:+;,,,+;;'+++''',.`          .',:;':::,',::.` 
 * `,,#:,::+;;;+:,.`  .:+:,,:+:;;+:,.`              .',::':;,:':::.` 
 * `,,#:,::+;;;+:,.`  .:+;,::+:;;+;:,``             .',::';;;:+:::.` 
 * `,:#;;;;#:;;+:,.   .:+;,,:+:;'+;;:,`             .',:;'+'';+:::.` 
 * `,;#@@#@:,::+:,.`  .:+;,,:+:;'+@@;:,`            .',:;+;#''#;;:.` 
 * `,:#++++;:;:+:,.`  .:+;,,:+:;'+#+:,.`            .',:;+:#''#';:.` 
 * `,:#:,::+;;;+:,.   .:+;,,:+:;;+;:,`              .',:;':;'++;;:.` 
 * `,,#:,::#:;;+:,.```.:+;,::+:;;+;:.```            .',:;+:;,,+:;:.` 
 * `,:#;;;:#:;;+;;:,..,:+;:;:+::;+;;:,,..`          .',;;':;,,',;:.` 
 * `,:#@###;,:;+##@##:,,:####;,:;+#@@##:,.`         .',::'::,,',:,.` 
 *  `.'+++',..,'+++++,...''++,..,'+++++,,`     `````.;..,;....;`..`  
 *    ````` `  ````````    ```    ```````   `.,::;;::..`      `      
 *                                          `'+###@#;,.`             
 *                                          ``..,,,,..`                                                                               
 * Titulo del software:Walking to Destroy 
 * Autores de la obra: Beatriz Hernández, Laura Marina Pedreño, Elena Luna y Elena Gil 
 * Basado en el codigo de:
 * Joaquín Díaz
 * Descripción sintetica del código:
 *  Sensor de movimiento con la que se apaga el sonido de fondo y cambia la imagen. Cuando la instalación está en marcha aparece una imagen y un sonido,
 cuando el sensor detecta movimiento se cambia la imagen y apaga el sonido de fondo.
 * 
 * 
 * 
 * 
 * Correo (de ustedes):bea_1440@hotmail.com, elenagiljuana@hotmail.com,  elanamoon_94@hotmail.es, lauramarina4@outlook.es

 * Sitio web de la exposición:
 *//http://blueinexhibition.wix.com/blue-in


import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;




Minim cadena;
AudioPlayer cancion;

//la parte decomunicacion ardu-proc
import processing.serial.*;
Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph

PImage imagendos;

PImage imagenuno;

void setup() {
  cadena=new Minim(this);
  cancion=cadena.loadFile("audio1.mp3");

  // set the window size:
  size(400, 300);
  imagenuno = loadImage("imagen1.jpg");
  imagendos = loadImage("imagen2.jpg");
  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  
  //variar el numero de puerto para saber cual es el bueno, serial.list[]
  myPort = new Serial(this, Serial.list()[2], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:
  background(0);
}
void draw() {
  
  
  
  
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {


    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    float inByte = float(inString);

//    inByte = map(inByte, 0, 1023, 0, height);
// esto es lo que pasa cuando se toca el sensor;
// se puede cambiar los metros del sensor con la función if (inbyte<20;

if (inByte < 200) {
    image(imagendos,0, 0);
 cancion.pause();
    cancion.rewind();
  }
  
  // esto es lo que pasa cuando no se toca el sensor;
  
  else  {
    
    
   image(imagenuno,0,0);
    cancion.play();  
}
    
    
  }
}

void keyPressed() {
  if (key=='1') {
    cancion.play();
  }
  if (key=='2') {
    cancion.pause();
    cancion.rewind();
  }
}




