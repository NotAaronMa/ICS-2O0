/*
  Author: Aaron Ma
  Date Finished: 11/21/2018
*/
void setup(){
   //makes so that draw() does not run
   noLoop();
   //set size
   size(500,700);
   //background white
   background(255);
   //radius
   int rad1 = 20;
   //set i to 0
   int i = 0;
   //loop to go through all small black circles
   while( i < width/rad1 +2){
     //current color
     int col1 = 0;
     int j = 0;
     while( j < (4/7f)*height / rad1){
         fill(col1);
         ellipse(i*rad1- rad1/2, j*rad1 - rad1/2, rad1, rad1);
         col1 += 255/((4/7f)*height / rad1) + 1;
         //inc j
         j++;
     }
     //inc i
     i++;
   }
   /*
      strategy is to draw translucent circles on top of eachother in order to create a translucent effect
   */
   // make no stroke
   noStroke();
   // set the fill to translucent purple
   fill(encodeColor(155, 15, 240, 3));
   float centerY = (4/7f)*height;
   centerY = (height - 150);
   // radius starts at 0
   int rad = 0;
   while(rad < 270){
      ellipse(width/2, centerY, rad, rad);
      rad++;
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
