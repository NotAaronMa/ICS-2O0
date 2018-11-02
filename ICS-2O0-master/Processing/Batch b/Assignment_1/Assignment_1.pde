
int rad = 16;
int[][]alpha;
void setup(){
  size(500,680);
  alpha = new int[width/rad + 1][height/rad +1];
  for(int i = 0; i < alpha.length; i++){
     for(int j = 0; j < alpha[0].length; j++){
       alpha[i][j] = 255;
     }
  }
  for(int i = 2; i < alpha.length-1; i++){
     for(int j = 2; j < alpha[0].length-1; j++){
       alpha[i][j] = (int)random(255);
     }
  }
}


void draw(){
  background(255);
  noStroke();
 
  for(int i = 0; i < width/rad + 1; i++){
    for(int j = 0; j < height/rad+1; j++){
      //double a = random(1);
      fill(encodeColor(255, 81, 226,(int)(alpha[i][j])));
      ellipse(i*rad-rad/2, j*rad-rad/2, rad,rad); 
    }
  }
  fill(255);
  rect(mouseX, 0, width, height);
  rect(0, mouseY, width, height);
}
public int encodeColor(int r, int g, int b, int a) {
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}
