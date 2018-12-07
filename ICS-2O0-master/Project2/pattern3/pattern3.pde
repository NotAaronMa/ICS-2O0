/*
 Author: Aaron Ma
 date last edited: Dec 7 2018
 Assignment 2 Pattern 3
 */
void setup() {
  size(830, 830);
  noFill();
}
//current level of the fractal
int cl;
//the next time a key press will be registered register
long nextKey;
//the current phase used to change color;
int phase;
void draw() {
  background(255); 
  //if a key is pressed and the cooldown on the key is over
  if (keyPressed && nextKey < System.currentTimeMillis()) {
    nextKey = System.currentTimeMillis() + 100;
    cl++;
  }
  cl %= 5 ;
  //if current fractal layer is zero
  if (cl == 0) {
    //inc phase
    phase++;
   
  }

  fractal(0, cl, 15, 15, 815, 815);
}

//renders a fractal recursively
//dimension of ln(8)/ln(3)
void fractal(int cl, int ml, float sx, float sy, float ex, float ey) {
  
  if (cl == ml) {
    return;
  }
  float delta = (ex - sx)/3f;
  
  
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      //the top left corner of the smaller square is (xval, yval);
      float xval = (i)*delta + sx;
      float yval = (j)*delta + sy;
      stroke(200);
      if ((i == 0 || i == 2) && (j== 0 || j == 2)) {
        //draw square
        rect(xval, yval, delta, delta);
        //recursive call of carpet inside the square 
        fractal(cl+1, ml, xval, yval, xval+delta, yval+delta);
      }else if(i == 1 && j == 1){
        //draw a circle touching the corners of the corner squares
        ellipse(xval +delta/2, yval + delta/2, delta*1.414f, delta*1.414f);
        //draw the fractal inside the circle
        fractal(cl+1, ml, xval, yval, xval+delta, yval+delta);
    
      }else{
        //draw ellipse tangent to the 2 corner squares next to it
        ellipse(xval +delta/2, yval + delta/2, delta, delta);
      }
    }
  }
}
