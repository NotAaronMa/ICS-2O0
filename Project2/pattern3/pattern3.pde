/*
Author Aaron Ma
Date last edited Dec 7
Assignment 2 pattern 3
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
  fractal(0, cl, 136, 136, 866, 866);
}




void fractal(int cl, int ml, float sx, float sy, float ex, float ey) {
  //base case is that the current layer is equal to the max layer
  if (cl == ml) {
    return;
  }
  // the side length of one of the smaller squares
  float delta = (ex - sx)/3f;
 
  stroke(200);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      //the top left corner of the smaller square is (xval, yval);
      float xval = (i)*delta + sx;
      float yval = (j)*delta + sy;
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
