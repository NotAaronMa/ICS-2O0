
//pattern 1 but with a gradiant
void setup() {
  size(1000, 1000);

  
}
//current level of the fractal
int cl;

long nextKey;
void draw() {
  background(75);
 
  if (keyPressed && nextKey < System.currentTimeMillis()) {
    nextKey = System.currentTimeMillis() + 100;
    cl++;
  }
  cl %= 6;
  if (cl == 0) {
    cl++;
  }
  int[][]col = new int[2][2];
  col[0][0] = encodeColor(255,0,255,255);
  col[0][1] = encodeColor(255,0,255,255);
  col[1][0] = encodeColor(0,0,0,255);
  col[1][1] = encodeColor(0,0,0,255);
  System.out.println(col[1][1]);
  carpet(0, cl, 136, 136, 866, 866,col);
}

void carpet(int cl, int ml, float sx, float sy, float ex, float ey,int[][]col) {
  
  if (cl == ml) {
    return;
  }
  int[][]grad = grad(col,5);
  float delta = (ex - sx)/3f;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      float xval = (i)*delta + sx;
      float yval = (j)*delta + sy;
      //if (!((i == 1) && (j== 1))) {
        stroke(grad[i][j]);
        fill(grad[i][j]);
        rect(xval, yval, delta, delta);
        
        int[][]colc = new int[2][2];
        colc[0][0] = grad[i][j];
        colc[0][1] = grad[i][j+1];
        colc[1][0] = grad[i+1][j];
        colc[0][1] = grad[i+1][j+1];
    
        carpet(cl+1, ml, xval, yval, xval+delta, yval+delta,col);
      /*}else{
        fill(255);
        stroke(255);
        
        rect(xval, yval,delta,delta);
      }
      */
    }
  }
}
//cl will be read as a 2x2 array repereseting the color in each corner;
//blends colors based of cartisian distance;
int[][]grad(int[][]cl, int points) {
  int[][]spec = new int[points][points];
  float[][]dist = new float[2][2];
  pair[]p = new pair[4];
  for (int i = 0; i < points-1; i++) {
    for (int j = 0; j < points-1; j++) {
      dist[0][0] = sqrt(i*i + j*j); //distance from 0,0;
      dist[1][0] = sqrt((points-i)*(points-i) + j*j); //distance from 1,0
      dist[0][1] = sqrt(i*i+(points-j)*(points-j)); // distance from 0,1
      dist[1][1] = sqrt((points-i)*(points-i)+(points-j)*(points-j)); // distance from 1,1
      for(int k = 0; k < 2; k++){
        for(int l = 0; l < 2; l++){
           int n = k*2 + l;
           p[n] = new pair(cl[k][l],(dist[k][l]+dist[k][l])/(points+points));
        }
      }
      spec[i][j] = addativeMix(p);
    }
  }
  return spec;
}

//takes an array of vectors with colors[n].a being argb value and colors[n].b being the strength relative to the rest of the colors
int addativeMix(pair[]colors) {  
  //decompose colors into argb values
  int coltotal = 0;
  for (int i = 0; i < colors.length; i++) {  
    int c = (int)colors[i].a;
    int b = c &255;
    int g = (c >> 8) &255;
    int r = (c >> 16) &255;
    int a = (c >>  24) & 255;
    
    float str = colors[i].b/3;
    int b1 = coltotal &255;
    int g1 = (coltotal >> 8) &255;
    int r1 = (coltotal >> 16) &255;
    int a1 = (coltotal >>  24) & 255;

    coltotal = encodeColor(minimum((int)(r*str+ r1),255),minimum((int)(g*str+g1),255),minimum((int)(b*str + b1),255),minimum((int)(a*str+a1),255)); 
  }
  return coltotal;
  
}

public static int minimum(int a, int b) {
  if (a > b) {
    return a;
  }else {
    return b;
  }
}
public int encodeColor(int r, int g, int b, int a) {
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}
class pair {
  float a;
  float b;
  public pair(float a, float b) {
    this.a = a;
    this.b = b;
  }
}
