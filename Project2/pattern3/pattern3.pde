
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
  cl %= 5;
  if (cl == 0) {
    cl = 1;
  }
  
  col[]col = {new col(25,25,255,255),new col(25,255,25,255)};
  noStroke();
  carpet(0, cl, 136, 136, 866, 866,col);
  
  
}

void carpet(int cl, int ml, float sx, float sy, float ex, float ey, col[]col) {
  col[][]grad = grad(col,5);
  if (cl != ml) {
    float delta = (ex - sx)/3f;
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        float xval = (i)*delta + sx;
        float yval = (j)*delta + sy;
        if (!((i == 1) && (j== 1))) {
          fill(grad[i+1][j+1].encode());
          rect(xval, yval, delta, delta);
          col[]cl1 = {grad[i+1][j+1], grad[i][j]};
          carpet(cl+1, ml, xval, yval, xval+delta, yval+delta,cl1);
        }else{
           fill(255);
           rect(xval,yval,delta,delta);
          
        }
      }
    }
  }
}
double sqr(double k){
 return k*k; 
}

public col[][]grad(col[]col, int w){
  col[][]a = new col[w][w];
  for(int i = 0; i < w; i++){
     for(int j = 0; j < w; j++){
       double dx,dy;
       dx = i/(float)w;
       dy = j/(float)w;
       float d1 = sqrt((float)((sqr(dx) + sqr(dy))));
       a[i][j] = col[0].mix(col[1],1-d1);
     }
  }

  
  return a;
}



class col {
  int r, g, b, a;

  public col(int c) {
    b = c &255;
    g = (c >> 8) &255;
    r = (c >> 16) &255;
    a = (c >>  24) & 255;
  }
  public col(int r, int g, int b, int a) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }

  public int encode() {
    int c = 0;
    c += r<<16; //left shift by 16 for red channel
    c += g<<8; //left shift by 8 for green channel
    c += b;  //blue channel 
    c+= a << 24; //set alpha channel to 255
    return c;
  }
  public col mix(col cl, float ratio) {
    int alpha = (int)(((1-ratio) * a + ratio*cl.a)*255);
    //alpha = 255;
    return new col(blendV(r, cl.r, ratio), blendV(g, cl.g, ratio), blendV(b, cl.b, ratio), alpha);
  }
  private int blendV(int a, int b, float ratio) {
    float a1, b1;
    a1 = a/255f;
    b1 = b/255f;
    float res = (float)Math.sqrt((1-ratio)*a1*a1 + ratio*b1*b1);
    return (int)(res * 255);
  }
}
