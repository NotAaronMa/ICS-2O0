/*
Author Aaron Ma
Date last edited
*/

void setup() {
  size(1000, 1000);
  noFill();
  
}
//current level of the fractal
int cl;
//the net time the button can be updated
long nextKey;

void draw() {
  //set background to white
  background(255);
  
  //if a key is pressed and the current time is greater than nextkey
  if (keyPressed && nextKey < System.currentTimeMillis()) {
    //set nextKey to now + 100
    nextKey = System.currentTimeMillis() + 100;
    //increment the current layer
    cl++;
  }
  //make sure cl is in the range (1<= cl <= 5) 
  cl %= 6;
  if (cl == 0) {
    cl++;
  }
  //draw the fractal
  carpet(0, cl, 136, 136, 866, 866);
}

void carpet(int cl, int ml, float sx, float sy, float ex, float ey) {
  if (cl == ml) {
    
    return;
  }
  stroke(cl*255/6 );
  float delta = (ex - sx)/3f;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      float xval = (i)*delta + sx;
      float yval = (j)*delta + sy;
      
      //if the current rectange is a corner
      if((i == 0 || i == 2)&&(j == 0 || j== 2)){
        rect(xval, yval, delta, delta);
        //draw the next level of the fractal inside the square
        carpet(cl+1, ml, xval, yval, xval+delta, yval+delta);
      
        //else if the current rectangle is the centre
      }else if(i == 1 && j == 1){
        //draw an ellipse with radius = sqrt(2) delta so that it touches the corner of the other rectangles
        ellipse(xval +(delta/2) ,yval + (delta/2), delta* 1.413f, delta * 1.413f); 
        //draw the same fractal inscribed in the circle
        carpet(cl+1, ml, xval, yval, xval+delta, yval+delta);
      }else{
        //else draw a circle tangent to the two squares next to it
        ellipse(xval + delta/2,yval + delta/2 ,delta, delta);
      }
    }
  }
  
}

