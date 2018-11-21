/*
  Author: Aaron Ma
  Date Finished: 11/21/2018
*/

//radius of the circle
int rad = 10;
//stores the alpha value at circle i,j
int[][]alpha;
void setup(){
  size(500,680);
  //instantiate alpha
  alpha = new int[width/rad + 1][height/rad +1];
  //generate the alpha values
  for(int i = 0; i < alpha.length-1; i++){
     for(int j = 0; j < alpha[0].length-1; j++){
       //position of the circle in pixels
       int xval = i*rad;
       int yval = j*rad;
       // 255 - (2*x*y)%255
       alpha[i][j] = 255-((xval*yval)+(xval*yval)%255);
     }
  }
  //debug code
  //System.out.println(alpha[0][0]);
}


void draw(){
  //set background
  background(255);
  noStroke();
  //loop through rows
  for(int i = 0; i < alpha.length; i++){
    //loop through collumns
    for(int j = 0; j < alpha.length; j++){
      //set fill to purple with alpha of alpha[i][j]
      fill(encodeColor(255, 81, 226,(int)(alpha[i][j])));
      //draw the ellipse
      ellipse((i+1)*rad-rad/2, (j+1)*rad-rad/2, rad,rad); 
    }
  }
  //white
  fill(255);
  //rectangles
  rect(mouseX, 0, width, height);
  rect(0, mouseY, width, height);
}
public int encodeColor(int r, int g, int b, int a) {
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}
