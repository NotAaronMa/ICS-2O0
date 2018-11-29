
void setup() {
  size(1000, 1000);

  
}
//current level of the fractal
int cl;

long nextKey;
void draw() {
  background(255);
 
  if (keyPressed && nextKey < System.currentTimeMillis()) {
    nextKey = System.currentTimeMillis() + 100;
    cl++;
  }
  cl %= 6;
  if (cl == 0) {
    cl++;
  }
  carpet(0, cl, 136, 136, 866, 866);
}

void carpet(int cl, int ml, float sx, float sy, float ex, float ey) {
  
  if (cl == ml) {
    return;
  }
  float delta = (ex - sx)/3f;
  stroke(cl * (255/ml));
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      float xval = (i)*delta + sx;
      float yval = (j)*delta + sy;
      if (!((i == 1) && (j== 1))) {
        rect(xval, yval, delta, delta);
        
        carpet(cl+1, ml, xval, yval, xval+delta, yval+delta);
      }
    }
  }
}
