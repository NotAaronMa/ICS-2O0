/*
  Author: Aaron Ma
  Date Finished: 11/21/2018
*/
void setup(){
   //make it so that draw() does not run
   noLoop();
   //set size
   size(500,700);
   //set background to white
   background(255);
   //radius of the small circles
   int rad1 = 20;
  
   for(int i = 0; i < width/rad1 +2; i++){
     //color of the current collumn
     int col1 = 0;
     for(int j = 0; j < (4/7f)*height / rad1; j++){
         fill(col1);
         //draw the ellipse
         ellipse(i*rad1- rad1/2, j*rad1 - rad1/2, rad1, rad1);
         //inc col1
         col1 += 255/((4/7f)*height / rad1) + 1;
     }
   }
  
   noStroke();
   //translucent purple
   fill(encodeColor(255, 15, 255, 3));
   // the y component of the middle of the circle
   float centerY = (height - 150);
   
   //draw larger and larger translucent circles atop eachother
   //to create the fade effect
   for(int rad = 0; rad < 270; rad+= 2 ){
      ellipse(width/2, centerY, rad, rad);
      
   }
   
}



public int encodeColor(int r, int g, int b, int a) {
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}