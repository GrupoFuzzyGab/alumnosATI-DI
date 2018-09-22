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
 * Titulo del software: Windows, Processing 2.2.1, Kinect xbox360
 * Autores de la obra: Joaquín Díaz, Cristina Cotelo, Alba Lozano, Miguel Dominguez y Cristina Asensio
 * Basado en el codigo de: Daniel Shiffman en Making Things see y varios autores de forum.processing.org
 * 
 * Descripción sintetica del código: Código para trabajar con Kinect. Se basa en una nube de puntos que detecta al usuario y lanza un audio. Luego detecta el tracking del esqueleto del usuario
 y dependiendo de la pose que tenga le lanza una imagen u otra a la vez que te hace una foto.
 *  
 * 
 * 
 * 
 * 
 * Correo (de ustedes): cristicotelo@gmail.com, lozalba@gmail.com, Miguel.dzsz86@gmail.com, cristina_asensiomartin@hotmail.com
 * Sitio web de la exposición:  http://blueinexhibition.wix.com/blue-in
 */
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 ////////// si aprietan barra espaciadora cambian de vista entre nube de puntos y RGB
// con las flechas del teclado cambian la perspectiva
//intercambien el audio
// y ubiquen donde y de que tamaño debe ir el cubo con los valores de las variables boxCenter y boxSize


import ddf.minim.*;


Minim minim;
int tamano = 100;
///////////////////////////  esta es la parte del boton
Hotpoint botonInst;
AudioPlayer instruc;


float        zoomF =0.3f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
// the data from openni comes upside down
float        rotY = radians(0);

/////////// tamaño del boton
int boxSize = 400;

//////////////coordenadas iniciales del boton
//aqui es donde hay ubicar el boton
/// esta parte si es en centimetros
/// estas son las coordenadas x, y, z
PVector boxCenter = new PVector(-1000, -300, 2000);


///// variables de la visualizacion

boolean nubePuntos = false;
boolean imagenRGB = false;



///////////

import SimpleOpenNI.*;

SimpleOpenNI kinect;

//  int[] ya;
//  int[] casi;
//  int[] esta;
//  int[] hecho;
//  
//    ya = new int[5];
//    esta = new int[5];
//    casi = new int[5];
//    hecho = new int[5];
//PImage[] ya = new PImage[5]
//ArrayList ya = new ArrayList();
PImage[] pose1;
PImage[] pose2;
PImage[] pose3;
PImage[] pose4;
PImage[] pose5;
PImage[] pose6;

PImage img1;

String[] pose1Name = {
  "0.jpg", "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", "11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg", "18.jpg", "19.jpg"
};
String[] pose2Name = {
  "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg", "28.jpg", "29.jpg", "30.jpg", "31.jpg", "32.jpg", "33.jpg", "34.jpg", "35.jpg", "36.jpg", "37.jpg", "38.jpg", "39.jpg", "40.jpg", "41.jpg", "42.jpg", "43.jpg", "44.jpg", "45.jpg", "46.jpg", "47.jpg", "48.jpg", "49.jpg", "50.jpg"
};
String[] pose3Name = {
  "51.jpg", "52.jpg", "53.jpg", "54.jpg", "55.jpg", "56.jpg", "57.jpg", "58.jpg", "59.jpg", "60.jpg", "61.jpg", "62.jpg", "63.jpg", "64.jpg", "65.jpg", "66.jpg", "67.jpg", "68.jpg", "69.jpg", "70.jpg", "71.jpg", "72.jpg", "73.jpg", "74.jpg", "75.jpg", "76.jpg", "77.jpg", "78.jpg", "79.jpg", "80.jpg", "81.jpg", "82.jpg", "83.jpg", "84.jpg", "85.jpg", "86.jpg"
};
String[] pose4Name = {
  "87.jpg", "88.jpg", "89.jpg", "90.jpg", "91.jpg", "92.jpg", "93.jpg", "94.jpg", "95.jpg", "96.jpg", "97.jpg", "98.jpg", "99.jpg", "100.jpg", "101.jpg", "102.jpg", "103.jpg", "104.jpg", "105.jpg", "106.jpg", "107.jpg", "108.jpg"
};
String[] pose5Name = {
  "109.jpg", "110.jpg", "111.jpg", "112.jpg", "113.jpg", "114.jpg", "115.jpg", "116.jpg", "117.jpg", "118.jpg", "119.jpg", "120.jpg", "121.jpg", "122.jpg", "123.jpg", "124.jpg", "125.jpg", "126.jpg", "127.jpg", "128.jpg", "129.jpg", "130.jpg"
};
String[] pose6Name = {
  "131.jpg", "132.jpg", "133.jpg", "134.jpg", "135.jpg", "136.jpg", "137.jpg", "138.jpg", "139.jpg", "140.jpg", "141.jpg", "142.jpg", "143.jpg", "144.jpg", "145.jpg", "146.jpg", "147.jpg", "148.jpg", "149.jpg", "150.jpg", "151.jpg", "152.jpg", "153.jpg", "154.jpg", "155.jpg", "156.jpg", "157.jpg"
};

int k = 0;

int contador = 0;
//int(random(pose1Name.length));

int savedTime;
int totalTime = 1000;

boolean x;


void setup() {
  
  ////****
  size(1012,700,P3D);
  //size(640, 480);
  
  savedTime = millis();
  ///////////////////////////////////


  minim = new Minim(this);
  instruc = minim.loadFile ("facebook_audio.wav"); // acordaros que la cancion o lo que querais trabajar ha de estar en la carpeta data dentro del proyecto de processing

  //  cancion.play();
  //  cancion.rewind();
  //  
///////// se inicializa el boton
  botonInst = new Hotpoint(boxCenter.x, boxCenter.y, boxCenter.z, boxSize);


  /////////////////////////////
  

  kinect= new SimpleOpenNI(this);

  kinect.enableDepth();
  kinect.enableRGB();
  kinect.setMirror(true);
  kinect.alternativeViewPointDepthToImage();

  kinect.enableUser();
  
  img1 = loadImage("facebook.jpg");

  pose1 = new PImage[pose1Name.length];
  pose2 = new PImage[pose2Name.length];
  pose3 = new PImage[pose3Name.length];
  pose4 = new PImage[pose4Name.length];
  pose5 = new PImage[pose5Name.length];  
  pose6 = new PImage[pose6Name.length];

  // contador // condicion // aumento
  for (int i = 0; i < pose1Name.length; i++) {
    pose1[i] = loadImage(pose1Name[i]);  
    //  println(pose1Name[i]);
  }
  for (int i = 0; i < pose2Name.length; i++) {
    pose2[i] = loadImage(pose2Name[i]); 
    //   println(pose2Name[i]);
  } 
  for (int i = 0; i < pose3Name.length; i++) {
    pose3[i] = loadImage(pose3Name[i]);
    // println(pose3Name[i]);
  }
  for (int i = 0; i < pose4Name.length; i++) {
    pose4[i] = loadImage(pose4Name[i]); 
    //  println(pose4Name[i]);
  } 
  for (int i = 0; i < pose5Name.length; i++) {
    pose5[i] = loadImage(pose5Name[i]); 
    //  println(pose4Name[i]);
  } 
  for (int i = 0; i < pose6Name.length; i++) {
    pose6[i] = loadImage(pose6Name[i]); 
    //  println(pose4Name[i]);
  } 
  //println(pose1Name[i]);
}



void draw() {

  background(0);

  kinect.update();
  
//  if (contador >= 300){
//  k = int(random(pose1Name.length));
//  contador = 0;
//  }
//  contador++;


/////////////////////////

  if(nubePuntos == false){
    
  image(kinect.depthImage(), 145, 175);
  image(kinect.rgbImage(), 145, 175);
  }

  IntVector userList= new IntVector();
  kinect.getUsers(userList);

int passedTime = millis();// - savedTime;


  if (userList.size()>0) {
    int userId= userList.get(0);

    if (kinect.isTrackingSkeleton(userId)) {
      PVector rightHand= new PVector();
      PVector leftShoulder= new PVector();
      PVector leftHand= new PVector();
      PVector rightShoulder= new PVector();
      PVector rightElbow= new PVector();
      PVector leftElbow= new PVector();
      PVector Head= new PVector();
      PVector Neck= new PVector();
      PVector leftHip= new PVector();
      PVector rightHip= new PVector();

      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);      
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, leftShoulder);            
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);            
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, rightShoulder); 
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, rightElbow);  
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, leftElbow);  
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, Head); 
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, Neck);
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, leftHip);            
      kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, rightHip); 

      PVector convertedRightHand= new PVector();
      kinect.convertRealWorldToProjective(rightHand, convertedRightHand);
      PVector convertedLeftShoulder= new PVector();
      kinect.convertRealWorldToProjective(leftShoulder, convertedLeftShoulder);
      PVector convertedLeftHand= new PVector();
      kinect.convertRealWorldToProjective(leftHand, convertedLeftHand);     
      PVector convertedRightShoulder= new PVector();
      kinect.convertRealWorldToProjective(rightShoulder, convertedRightShoulder);            
      PVector convertedRightElbow= new PVector();
      kinect.convertRealWorldToProjective(rightElbow, convertedRightElbow);
      PVector convertedLeftElbow= new PVector();
      kinect.convertRealWorldToProjective(leftElbow, convertedLeftElbow);
      PVector convertedHead= new PVector();
      kinect.convertRealWorldToProjective(Head, convertedHead);
      PVector convertedNeck= new PVector();
      kinect.convertRealWorldToProjective(Neck, convertedNeck);
      PVector convertedLeftHip= new PVector();
      kinect.convertRealWorldToProjective(leftHip, convertedLeftHip); 
      PVector convertedRightHip= new PVector();
      kinect.convertRealWorldToProjective(rightHip, convertedRightHip);

      ellipse(convertedRightHand.x+145, convertedRightHand.y+175, 8, 8);            
      ellipse(convertedLeftShoulder.x+145, convertedLeftShoulder.y+175, 8, 8);                  
      ellipse(convertedLeftHand.x+145, convertedLeftHand.y+175, 8, 8);                  
      ellipse(convertedRightShoulder.x+145, convertedRightShoulder.y+175, 8, 8);   
      ellipse(convertedRightElbow.x+145, convertedRightElbow.y+175, 8, 8);
      ellipse(convertedLeftElbow.x+145, convertedLeftElbow.y+175, 8, 8);  
      ellipse(convertedHead.x+145, convertedHead.y+175, 8, 8);
      ellipse(convertedNeck.x+145, convertedNeck.y+175, 8, 8);  
      ellipse(convertedLeftHip.x+145, convertedLeftHip.y+175, 8, 8);                  
      ellipse(convertedRightHip.x+145, convertedRightHip.y+175, 8, 8);

      float distance=distanciaDosPuntos(convertedLeftHand, convertedHead);
      float distance1=distanciaDosPuntos(convertedRightHand, convertedRightHip);
      float distance2=distanciaDosPuntos(convertedLeftHand, convertedLeftHip);
      float distance3=distanciaDosPuntos(convertedLeftHand, convertedRightElbow);
      float distance4=distanciaDosPuntos(convertedRightHand, convertedHead);
      float distance5=distanciaDosPuntos(convertedRightHand, convertedLeftHand);
      
      
      if (distance<70 || distance1<60 || distance2<60 || distance3<90 || distance4<70 || distance5<70) {


        
       if(k >= pose1.length-1){
         k = 0;
         }
       if(k >= pose2.length-1){
         k = 0;
         }
         if(k >= pose3.length-1){
         k = 0;
         }
         if(k >= pose4.length-1){
         k = 0;
         }
         if(k >= pose5.length-1){
         k = 0;
         }
         if(k >= pose6.length-1){
         k = 0;
         }
         
         
        if (distance<distance1 && distance<distance2 && distance<distance3 && distance<distance4 && distance<distance5) {
          saveFrame("pose1-##.jpg");
          image(img1, 0, 0);
          image(pose1[k], 145, 175);
         //else if (x > 500) {
          // boolean result = false;
         // image(cam, 0, 0);
          //(ya[i], 0, 0, random(-2, 2));
          //if(k == pose1.length){
           //delay(1000);
        } else if (distance1<distance && distance1<distance2 && distance1<distance3 && distance1<distance4 && distance1<distance5) {
          saveFrame("pose2-##.jpg");
          image(img1, 0, 0);
          image(pose2[k], 145, 175);
          //delay(1000);
        } else if ( distance2<distance && distance2<distance1 && distance2<distance3 && distance2<distance4 && distance2<distance5) {
          saveFrame("pose3-##.jpg");
          image(img1, 0, 0);
          image(pose3[k], 145, 175);
          //delay(1000);
        } else if ( distance3<distance && distance3<distance1 && distance3<distance2 && distance3<distance4 && distance3<distance5) {
          saveFrame("pose4-##.jpg");
          image(img1, 0, 0);
          image(pose4[k], 145, 175);
          //delay(1000);
        } else if (distance4<distance && distance4<distance1 && distance4<distance2 && distance4<distance3 && distance4<distance5) {
          saveFrame("pose5-##.jpg");
          image(img1, 0, 0);
          image(pose5[k], 145, 175);
        } else if (distance5<distance && distance5<distance1 && distance5<distance2 && distance5<distance3 && distance5<distance4) {
          saveFrame("pose6-##.jpg");
          image(img1, 0, 0);
          image(pose6[k], 145, 175);
        }
        
        

         
         if (contador >= 3){
         k = int(random(pose1Name.length));
         contador = 0;
        }
         contador++;
         
//         if (passedTime > totalTime) {
//           k++;
//           savedTime = millis();
//           image(pose1[k],0 , 0);//(ya[i], 0, 0, random(-2, 2));    
//                k++;
//          }
            

                
                  
//            if(k >= pose2.length){
//             k = 0;  
//          }
//            // image(pose2[k],0 ,0);
//        
//          k++;
//          
//           if(k >= pose3.length){
//            k = 0;  
//          }
//             //image(pose3[k],0 ,0);
//        
//           k++;
//           
//            if(k >= pose4.length){
//            k = 0;  
//          }
//            // image(pose4[k],0 ,0);
//        
//           k++;
      
      
      
        }
    }
  }


 //////////////// esta es la parte de la nube de puntos

  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(0.3f);

  int[]   depthMap = kinect.depthMap();
  int     steps   = 15;  // to speed up the drawing, draw every third point
  int     index;
  PVector realWorldPoint;

  translate(0, 0, -1000);  // set the rotation center of the scene 1000 infront of the camera

  stroke(255);

  PVector[] realWorldMap = kinect.depthMapRealWorld();

  // draw pointcloud

    for (int i=0; i < realWorldMap.length; i+=steps)
  {
    // draw the projected point
    //        realWorldPoint = context.depthMapRealWorld()[index];
    PVector currentPoint = realWorldMap[i];
    stroke(2, 200, 20);
    
    //// esta linea pregunta por los puntos en el cubo
    botonInst.check(currentPoint);
     // botonInst.center.z = 2000;
     
     
     ///// cuando este liosto comentar
    point(currentPoint.x, currentPoint.y, currentPoint.z);  // make realworld z negative, in the 3d drawing coordsystem +z points in the direction of the eye
    //println("x: " + x + " y: " + y);
  }


/////// si se activa da play al archivo
  if (botonInst.isHit()) {
    instruc.play();
  }
  
//// si se ha terminado de reproducor lo rebobina para dejarlo listo para el siguiente play
  if (!instruc.isPlaying()) {
    instruc.rewind();
  }
  
// display each hotpoint and clear its points
  botonInst.draw(); 
  botonInst.clear();
}
/////////////////////////////////

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}



void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}



void onVisibleUser(SimpleOpenNI curContext, int userId) {
}


void stop() {


  super.stop();
}

float distanciaDosPuntos(PVector p1, PVector p2) {
  return(sqrt(pow(p2.x-p1.x, 2)+pow(p2.y-p1.y, 2)+pow(p2.z-p1.z, 2)));
}

////////// si aprietan barra espaciadora cambian de vista entre nube de puntos y RGB
// con las flechas del teclado cambian la perspectiva



void keyPressed()
{
  switch(key)
  {
  case ' ':
  
  nubePuntos = !nubePuntos;

    break;
  }

  switch(keyCode)
  {
  case LEFT:
    rotY += 0.1f;
    break;
  case RIGHT:
    // zoom out
    rotY -= 0.1f;
    break;
  case UP:
    if (keyEvent.isShiftDown())
      zoomF += 0.02f;
    else
      rotX += 0.1f;
    break;
  case DOWN:
    if (keyEvent.isShiftDown())
    {
      zoomF -= 0.02f;
      if (zoomF < 0.01)
        zoomF = 0.01;
    } else
      rotX -= 0.1f;
    break;
  }
}

////////////


