int tileSide = 8;
smoothedNoise sn;
void setup() {

  sn  = new smoothedNoise(width/tileSide, height/tileSide, 1, 2, 9);
  // 
  size(800, 600);
}
mountain[]mountains = {
  //            x  peak   w   h
  new mountain(250, 350, 700, 300,70,255), 
  new mountain(400, 450, 700, 400,70,255), 
  new mountain(600, 400, 500, 400,70,255)
};

boolean keyDown;
void keyPressed(){
  keyDown = true;
}
void keyReleased(){
  keyDown = false; 
}
void draw() {
  if(!keyDown){
    background(0);
  
  }else{
    daySky();
     
  }
  
  for (int i = 0; i < mountains.length; i++) {
    mountains[i].render();
  }
  fill(encodeColor(40,105,40,255));
  rect(0, height - 200,width, height);
  fill(70);
  
}
public void daySky(){
    background(255); 
    double[][] noise = sn.noiseImage();
    for(int i = 0; i < noise.length; i++){
      for(int j = 0; j < noise[0].length; j++){
        fill(encodeColor(30,80,255,(int)(noise[i][j]*255)));
        strokeWeight(0);
        stroke(encodeColor(30,8,255,(int)(noise[i][j]*255)));
        rect(i*tileSide, j*tileSide, tileSide,tileSide);
      }
    }
}
public void nightSky(){


}





public int encodeColor(int r, int g, int b, int a) { //utility method to make my life easier
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}
class pair{
 float a, b; 
  
}
class mountain {
  float x, peak, h, w;
  int color1, color2;


  public mountain(int x, int y, int w, int h, int color1, int color2) {
    this.x = x;
    this.peak = y;
    this.h =h;
    this.w = w;
    this.color1 = color1;
    this.color2 = color2;
  }
  public void render() {
    stroke(0);
    
    fill(color1);
    triangle(
      x, height - peak, 
      x - w/2, height - peak +h, 
      x + w/2, height - peak +h);
    fill(color2);
    float n = h/3;
    triangle(
      x,         height-peak, 
      x - w/6, height - peak+n, 
      x + w/6, height - peak+n
    );

  }
}

class smoothedNoise { // a class defining 2d array generated using random noise and smothed using a boxblur
  int w, h, range, interp, interpw;
  public smoothedNoise(int w, int h, int range, int interp, int interpw) {
    this.w = w;
    this.h = h;
    this.range =range;
    this.interp = interp;
    this.interpw = interpw;
  }
  double[][] noiseImage() {
    double[][]ni = new double[w][h];
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        ni[i][j] = random(range);
      }
    }
    for (int i = 0; i < interp; i++) {
      boxblur(ni);
    }

    return ni;
  }  


  public void boxblur(double[][]noise) { //nearest neighbor interpolation
    for (int i = 0; i < noise.length; i++) {
      for (int j = 0; j < noise[0].length; j++) {
        noise[i][j] = getAverage(noise, i-interpw/2, j-interpw/2, interpw);
      }
    }
  }  
  public double getAverage(double[][]a, int Xtr, int Ytr, int l) {
    int n = 0;
    double total = 0;
    for (int i = Xtr; i < l+Xtr; i++) {
      for (int j = Ytr; j < l+Ytr; j++) {
        boolean flag = true;

        if (i >= a.length) {
          flag = false;
        }
        if (j >= a[0].length) {
          flag = false;
        }
        if (i < 0) {
          flag = false;
        }
        if (j < 0) {
          flag = false;
        }
        if (flag) {
          total+= a[i][j];
          n++;
        }
      }
    }
    return total/n;
  }
}
