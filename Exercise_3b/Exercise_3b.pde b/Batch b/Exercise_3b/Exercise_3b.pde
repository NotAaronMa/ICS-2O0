void setup(){
   noLoop();
   size(500,700);
   background(255);
   
   int rad1 = 20;
   int i = 0;
   while( i < width/rad1 +2){
     int col1 = 0;
     int j = 0;
     while( j < (4/7f)*height / rad1){
         fill(col1);
         ellipse(i*rad1- rad1/2, j*rad1 - rad1/2, rad1, rad1);
         col1 += 255/((4/7f)*height / rad1) + 1;
         j++;
     }
     i++;
   }
   noStroke();
   fill(encodeColor(155, 15, 240, 3));
   float centerY = (4/7f)*height;
   centerY = (height - 150);
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