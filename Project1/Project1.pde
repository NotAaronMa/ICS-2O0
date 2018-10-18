void setup(){
  size(800,600);
  sn = new smoothedNoise(width,height,1,20,3);
  mountainHeight = new fourierSeries(2,0.5).genFourier(20,width,10,1000);

  
}
double[]mountainHeight;
smoothedNoise sn;
void draw(){
  long now = System.currentTimeMillis();
  strokeWeight(0);
  int tileSize = 4;
   
  background(encodeColor(255,255,255,255));
  
  double[][]noise = sn.noiseImage();
  for(int i = 0; i < sn.w; i++){
    for(int j = 0; j < sn.h; j++){
       int b = (int)(noise[i][j]*255);
      
       int c = (encodeColor(0,70,255,b));
       stroke(c);
       fill(c);
       rect(i*tileSize,j*tileSize,tileSize,tileSize);
    }
  }
  
    stroke(encodeColor(0,0,0,255));
    strokeWeight(2);
    for(int i = 0; i < mountainHeight.length; i++){
        point(i,(float)mountainHeight[i]+100);
    }
  sync(now);

}
long looptime=200;
public void sync(long start){
  while(System.currentTimeMillis() < start + looptime){
    try{Thread.sleep(1);}catch(Throwable t){}
  }
  
}
//makes it easier to choose colors without using color picker

int encodeColor(int r, int g, int b,int a){
   int c = 0;
   c += r<<16; //left shift by 16 for red channel
   c += g<<8; //left shift by 8 for green channel
   c += b;  //blue channel 
   c+= a << 24; //set alpha channel to 255
   return c;
}
void printarr(double[][]a){ // debug method
   for(int i = 0; i < a.length; i++){
     for(int j = 0; j < a[0].length; j++){
       System.out.print(a[i][j] + " ");
     } 
     System.out.print(" \n");
   }
} 



public class smoothedNoise{ // a class defining 2d array generated using random noise and smothed using a boxblur
  int w, h,range,interp,interpw;
  public smoothedNoise(int w, int h, int range, int interp,int interpw){
    this.w = w;
    this.h = h;
    this.range =range;
    this.interp = interp;
    this.interpw = interpw;
  }
  double[][] noiseImage(){
    double[][]ni = new double[w][h];
    for(int i = 0; i < w; i++){
       for(int j = 0; j < h; j++){
         ni[i][j] = random(range);
       }
    
    }
    for(int i = 0; i < interp; i++){
       boxblur(ni);
    }
  
    return ni;
  }  

  public void boxblur(double[][]noise){ //nearest neighbor interpolation
     for(int i = 0; i < noise.length; i++){
       for(int j = 0; j < noise[0].length; j++){
         noise[i][j] = getAverage(noise,i-interpw/2,j-interpw/2,interpw);
       
       } 
     }   
  }  
  public double getAverage(double[][]a,int Xtr, int Ytr, int l){
   int n = 0;
    double total = 0;
    for(int i = Xtr; i < l+Xtr; i++){
      for(int j = Ytr; j < l+Ytr;j++){
        boolean flag = true;
        
        if(i >= a.length){
          flag = false;
        }
         if(j >= a[0].length){
          flag = false;
        }
        if(i < 0){
          flag = false;
        }
        if(j < 0){
          flag = false;
        }
        if(flag){
          total+= a[i][j];
          n++;
        }
      }
    }
    return total/n;
  }
}

class fourierSeries{ // a simple class for aproximating an infinite series of sine functions in order to generate the mountains
  float coeficient;
  int bottemMultiplier;
  public fourierSeries(int bottemMultiplier, float coeficient){
   
    this.bottemMultiplier = bottemMultiplier;
    this.coeficient = coeficient;
  }
  private double yAt(int x, int accuracy){
     float r = radians(x); 
     int bottem = 1;
     double total = 0;
     for(int i = 0; i < accuracy; i++){
       total += r*sin(r/bottem);
       bottem *= bottemMultiplier;
     }
     return total * coeficient;
     
  }
  
  public double[] genFourier(int accuracy,int w, int diffPoints, int phaseShift){
    double[]d = new double[w];
    for(int i = 0; i < w; i++){
      d[i] = yAt(i*diffPoints- phaseShift*diffPoints,accuracy);
    }
    return d;
  }
}
  
