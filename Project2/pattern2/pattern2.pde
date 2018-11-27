//pattern 1 but with a gradiant
void setup(){
  size(1000,1000);
 
  
}
//current level of the fractal
int cl;

int keyCooldown = 0;
void draw(){
  background(255);
  noFill();
  if(keyPressed && keyCooldown < 0){
    cl++;
    keyCooldown = 10;
  }
  cl %= 6;
  System.out.println(cl);
  carpet(0,cl,136,136,866,866 );
  keyCooldown--;
}

void carpet(int cl, int ml, float sx, float sy, float ex,float ey){
  if(cl == ml){
     return; 
  }
  float delta = (ex - sx)/3f;
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
       float xval = i*delta + sx;
       float yval = j*delta + sy;
       if(!((i == 1) && (j== 1))){
         stroke(0);
         rect(xval,yval,delta,delta);
         carpet(cl+1, ml,xval,yval,xval+delta,yval+delta);
       }        
    }
  }
}


//cl will be read as a 2x2 array repereseting the color in each corner;
//blends colors based of cartisian distance;
int[][]grad(int[][]cl, int points){
   int[][]spec = new int[points][points];
   float[][]dist = new float[2][2];
   for(int i = 0; i < points-1; i++){
     for(int j = 0; j < points-1; j++){
       dist[0][0] = sqrt(i*i + j*j); //distance from 0,0;
       dist[1][0] = sqrt((points-i)*(points-i) + j*j); //distance from 1,0
       dist[0][1] = sqrt(i*i+(points-j)*(points-j)); // distance from 0,1
       dist[1][1] = sqrt((points-i)*(points-i)+(points-j)*(points-j)); // distance from 1,1
       
       
       spec[i][j] = addativeMix(spec[0][0],dist[0][0],spec[1][0],dist[1][0],spec[0][1], dist[0][1],spec[1][1],dist[1][1]);
     }
   }
   return spec;
   
}
int addativeMix(int a, float adis, int b, float bdis, int c, float cdis, int d, float ddis){  
   return 0;
}
int[]decomposeColor(int c){
  int r,g,b,a;
   r = c >>
 
}
public int encodeColor(int r, int g, int b, int a) {
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}
