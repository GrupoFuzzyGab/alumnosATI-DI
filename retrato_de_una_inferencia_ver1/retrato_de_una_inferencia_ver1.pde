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
 * Titulo del software: 
 * Autores de la obra: 
 * Basado en el codigo de:
 * 
 * Descripción sintetica del código:
 *  
 * 
 * 
 * 
 * 
 * Correo (de ustedes):
 * Sitio web de la exposición:
 */
 
import SimpleOpenNI.*;
SimpleOpenNI  context;

PImage img0, img1, img2, img3, img4, img5, img6, img7, img8, img9;
int xy=50;
int HALF_HOLE_SIZE = 60;
boolean bPersist = false;


int seleccion = 0;
int contadorR = 0;
int contador=0;



void setup() {
  frameRate(30);
  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.enableUser();
  context.setMirror(true);

  size(640, 480);
  img0=loadImage("img/gon_2.jpg");
  img1=loadImage("img/leo.jpg");
  img2=loadImage("img/dany_3.jpg");
  img3=loadImage("img/esther_1.png");
  img4=loadImage("img/dany_2.jpg");
  img5=loadImage("img/irati.jpg");
  img6=loadImage("img/gon_1.jpg");
  img7=loadImage("img/maria_1.jpg");
  img8=loadImage("img/dany_1.jpg");
  img9=loadImage("img/fondo.png");
  //img0.format = ARGB;
  stroke(0, 0, 255);
  smooth();

  background(0);
}


void draw() { 

  context.update();
  ///cargart todas las imagenes
  image(img0, 0, 0);
  image(img1, 0, 0); 
  image(img2, 0, 0); 
  image(img3, 0, 0);
  image(img4, 0, 0);
  image(img5, 0, 0);
  image(img6, 0, 0);
  image(img7, 0, 0);
  image(img8, 0, 0);
  image(img9, 0, 0);

  //image(context.depthImage(),0,0);   

  if (context.isTrackingSkeleton(1)) {
    revealImage(1);
  }
} 


//--Información del esqueleto--//
void revealImage(int userId) {
  PVector jointPosLeft = new PVector();
  PVector jointPosRight = new PVector();  

  PVector screenPosLeft= new PVector();
  PVector screenPosRight= new PVector();  

  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, jointPosLeft);
  context.convertRealWorldToProjective(jointPosLeft, screenPosLeft);  

  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, jointPosRight);
  context.convertRealWorldToProjective(jointPosRight, screenPosRight);  

  ChangePixels(int(screenPosLeft.x), int(screenPosLeft.y), false);
  ChangePixels(int(screenPosRight.x), int(screenPosRight.y), false);  

  noFill();
  strokeWeight(20);
  stroke(255, 255, 255, 125);

  ellipse(screenPosLeft.x, screenPosLeft.y, xy, xy);
  ellipse(screenPosRight.x, screenPosRight.y, xy, xy);  

  text("usuarios:"+context.getNumberOfUsers(), 50, 50);
  
  
  }

//----------------------------NO TOQUES, WEY-----------------------------------//

//--Aquí los datos--//
void ChangePixels(int x, int y, boolean bMakeOpaque) {
  if (x <= HALF_HOLE_SIZE || x >= img0.width - HALF_HOLE_SIZE) return;
  if (y <= HALF_HOLE_SIZE || y >= img0.height - HALF_HOLE_SIZE) return;

  text("tiempo"+contador, 50, 70);
  text("seleccion"+seleccion, 50, 80);

  /* 
   if(contadorR >= 3) {
   
   seleccion = int(random(0, 8));
   contadorR = 0;
   
   
   }
   contadorR++;
   
   */
   
   

  if (contador>=600) {
    seleccion++;
    contador=0;
  } 
  contador++;


  if (seleccion == 0) {


    img9.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img9.pixels[i + j * img9.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img9.pixels[i + j * img9.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img9.updatePixels();
  } else if (seleccion == 1) {


    img8.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img8.pixels[i + j * img8.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img8.pixels[i + j * img8.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img8.updatePixels();
  } else if (seleccion == 2) {

    img7.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img7.pixels[i + j * img7.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img7.pixels[i + j * img7.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img7.updatePixels();
  } else if (seleccion == 3) {

    img6.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img6.pixels[i + j * img6.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img6.pixels[i + j * img6.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img6.updatePixels();
  } else if (seleccion == 4) {

    img5.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img5.pixels[i + j * img5.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img5.pixels[i + j * img5.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img5.updatePixels();
  } else if (seleccion == 5) {

    img4.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img4.pixels[i + j * img4.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img4.pixels[i + j * img4.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img4.updatePixels();
  } else if (seleccion == 6) {

    img3.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img3.pixels[i + j * img3.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img3.pixels[i + j * img3.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img3.updatePixels();
  } else if (seleccion == 7) {

    img2.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img2.pixels[i + j * img2.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img2.pixels[i + j * img2.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img2.updatePixels();
  } else if (seleccion == 8) {

    img1.loadPixels();

    for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
    {
      for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
      {
        if (bMakeOpaque)
        {
          img1.pixels[i + j * img1.width] |= 0xFF000000;
        } else {
          //img0.pixels[i + j * img0.width] &= 0x00FFFFFF;
          img1.pixels[i + j * img1.width] &= color(0, 0, 0, 0);
        }
      }
    }

    img1.updatePixels();
  } else if (seleccion==9) {
    setup();
    seleccion=0;
  }
  
 
}



//----------------------------NO TOQUES, WEY-----------------------------------//





//-Impresion de detección de esqueleto--//
void onNewUser(SimpleOpenNI curContext, int userId) {
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId) {
  setup();
  seleccion=0;
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId) {
  println("onVisibleUser - userId: " + userId);
}

void seekPlayer(SimpleOpenNI curContext, int userId){
  println("¿Vas a querer?"+userId);
}

