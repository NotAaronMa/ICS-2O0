
void setup() {
  noise  = new smoothedNoise(width/tileSide, height/tileSide, 1, 1,5);
  stars = new Vector2[1024];
  for(int i = 0; i < stars.length; i++){
    stars[i] = new Vector2(random(width),random(height)); 
  }
  size(800, 600);
}
boolean keyDown;
int tileSide = 8;
smoothedNoise noise;
Vector2[]stars;
mountain[]mountains = {
  //            x  peak   w   h     base color, snowcap color
  new mountain(250, 350, 700, 300,     90,          90), 
  new mountain(400, 450, 700, 400,     90,          90), 
  new mountain(600, 400, 500, 400,     90,          90)
};
void keyPressed(){
  timeScale = 3;
}
void keyReleased(){
  timeScale = 0.25f; 
}
void draw() {
  time = normalizeAngle(time);
  renderSky(time);
  for (int i = 0; i < mountains.length; i++) {
    mountains[i].render();
  }
  fill(encodeColor(40,105,40,255));
  rect(0, height - 200,width, height);
  fill(70);
  fill(encodeColor(30,50,205,255));
  ellipse(width/2, height-100 , 700,150);
  time += timeScale; 
}
float timeScale = 1;
float time = 0;
public float normalizeAngle(float theta){
   return theta%=360; 
}

public int genBgColor(float time, int alpha){ //time is an angle between 0 and 360 representing how far allong the sun is across it's path
  //System.out.println(time);
  if(0<=time && time<30){ //time is between 0 and 360 return dark grey
     return encodeColor(200, 200, 200,alpha);
  }else if(30 <= time && time < 150){ //if time is between 60 and 150 white
    return encodeColor(255,255,255,alpha);
  }else if(150 <= time && time < 180){ //if time is between 150 and 180 grey
   return encodeColor(200, 200, 200,alpha); 
  }else if(180 <= time && time < 210){ // if time is between 180 and 210 return purple
   return encodeColor(61,0,55,255);
  }else if(210 <= time && time < 330){ // if time is between 210 and 240 return black
    return encodeColor(0,0,0,alpha);
  }else if(330 <= time && time < 360){ // if time is between 330 and 360 return purple
    return encodeColor(61,0,55,alpha);
  }
  return encodeColor(255,255,255,255); //default return white
  
  
  
}

public void renderNoise(int r,int g,int b, double[][]noiseArr){
    for(int i = 0; i < noiseArr.length; i++){
        for(int j = 0; j < noiseArr[0].length; j++){
            int c1 = encodeColor(r,g,b,(int)(noiseArr[i][j]*255));
            strokeWeight(0);
            stroke(c1);
            fill(c1);
            rect(i*tileSide, j*tileSide, tileSide,tileSide);         
       }
    } 
}
public void renderSun(float time, boolean day){
    float sunX, sunY;

    //caluclate the position of the sun based on a sine function
    sunX = (width+100)*(time/180f);
    sunY = -250*sin(radians(time/0.9f)) + 300;
    strokeWeight(0);
    if(day){
        fill(encodeColor(255,255,0,255));
        ellipse(sunX, sunY, 100,100);
    }else{
        fill(200);
        ellipse(sunX, sunY, 70,70);
    }
    
}
public void renderSky(float time){
   //get a noise image from the random noise generator
    double[][] noiseArr = noise.noiseImage();
     //the x and y of the sun
    float sunX, sunY;
    background(genBgColor(time,255));
    //If it is night
    if(time > 180){ 
      time -= 180; 
      renderNoise(0,0,0,noiseArr);
      
      
      stroke(encodeColor(255,255,0,200));
      strokeWeight(2);
      for(int i = 0; i < stars.length; i++){
        float x = stars[i].a;
        float y = stars[i].b;
        point(x,y);
      }
      renderSun(time,false);
    // if it is day
    }else{
     
      renderNoise(50,70,230,noiseArr);
      renderSun(time,true);
    }
}
public int encodeColor(int r, int g, int b, int a) { //utility method to make my life easier
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}
class Vector2{
 float a, b; 
 public Vector2(float a, float b){
     this.a = a;
     this.b =b;
 }
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
    stroke(color1);
    triangle(
      x, height - peak, 
      x - w/2, height - peak +h, 
      x + w/2, height - peak +h);
    fill(color2);
    stroke(color2);
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
        boolean flag = inBounds(a.length, a[0].length, i ,j);
        if (flag) {
          total+= a[i][j];
          n++;
        }
      }
    }
    return total/n;
  }
  private boolean inBounds(int mx, int my, int x, int y){
     return x < mx && y < my && x >= 0 && y >= 0; 
  }
}
