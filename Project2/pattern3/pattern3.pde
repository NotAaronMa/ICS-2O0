
//pattern 1 but like different

void setup() {
  size(1000, 1000);
  noFill();
  
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
  
  
  ArrayList<pair> verts = new ArrayList<pair>();
  stroke(cl*255/6 );
  float delta = (ex - sx)/3f;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      float xval = (i)*delta + sx;
      float yval = (j)*delta + sy;
      if((i == 0 || i == 2)&&(j == 0 || j== 2)){
      
        rect(xval, yval, delta, delta);
        carpet(cl+1, ml, xval, yval, xval+delta, yval+delta);
      }else if(i == 1 && j == 1){
        ellipse(xval +(delta/2) ,yval + (delta/2), delta* 1.413f, delta * 1.413f); 
        carpet(cl+1, ml, xval, yval, xval+delta, yval+delta);
      }else if( i == 0|| i == 2 || j == 0 || j ==2){
        //verts.add(xval + delta/2, yval + delta/2);
      }
        
    }
  }
}
class pair {
  float a;
  float b;
  public pair(float a, float b) {
    this.a = a;
    this.b = b;
  }
}
