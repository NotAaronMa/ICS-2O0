/*
  Author: Aaron Ma
  Date Finished: 11/21/2018
*/
//radius of a circle
int rad = 10;
//array storing alpha on each circle
int[][]alpha;

//setup
void setup(){
  size(500,680);
  //instatiate alpha
  alpha = new int[width/rad + 1][height/rad +1];
  
  //gen the alpha values for each circle
  for(int i = 0; i < alpha.length-1; i++){
     for(int j = 0; j < alpha[0].length-1; j++){
       // get pos of circle i,j in pixels
       int xval = i*rad;
       int yval = j*rad;
       //set alpha at [i][j] to 255- (2*x*y%255)
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
  //loop counters
  int i = 0,j = 0;
  //rows
  while(i < alpha.length){
    //collumns
    while(j < alpha[0].length){
      fill(encodeColor(255, 81, 226,(int)(alpha[i][j])));
      ellipse((i+1)*rad-rad/2, (j+1)*rad-rad/2, rad,rad); 
      //inc j
      j++;
    }
    //reset j
    j = 0;
    //inc i
    i++;
  }
  //set color to white
  fill(255);
  //draw rectangles that cover up what should be covered
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