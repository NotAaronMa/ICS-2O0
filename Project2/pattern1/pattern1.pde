/*
Author Aaron Ma
Date last edited 
*/
void setup() {
  size(830, 830);
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
  carpet(0, cl, 15, 15, 815, 815);
}
//render the fractal from (sx, sy) (ex, ey)
void carpet(int cl, int ml, float sx, float sy, float ex, float ey) {
  //base case is that the current layer is equal to the max layer
  if (cl == ml) {
    return;
  }
  // the side length of one of the smaller squares
  float delta = (ex - sx)/3f;
  //make the stroke lighter as the level get highter
  stroke(cl * (120/ml));
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      //the top left corner of the smaller square is (xval, yval);
      float xval = (i)*delta + sx;
      float yval = (j)*delta + sy;
      //if it is currently not the center 
      if (!((i == 1) && (j== 1))) {
        //draw a subrectangle 
        rect(xval, yval, delta, delta);
        //recursive call of carpet that makes the whole thing work
        carpet(cl+1, ml, xval, yval, xval+delta, yval+delta);
      }
    }
  }
}
