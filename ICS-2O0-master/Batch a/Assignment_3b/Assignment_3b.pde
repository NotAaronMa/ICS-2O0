/*
* Assignment 1 
* By Aaron Ma
* created oct 10
* last modified oct 15
*/

void setup(){ 
  size(400,700); //setup screen
}

void draw(){
  
  float y = random(700f); //generate random cords and rgb values for color
  float x = random(400f);
  int r = (int)random(255); //set random byte rgb value
  int g = (int)random(255);
  int b = (int)random(255);
  int c = 0; // fill color
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= 255 << 24; //set alpha channel to 255
  fill(c); //set fill to the random gened color
  ellipse(x,y,20,20); //draw ellipse
}