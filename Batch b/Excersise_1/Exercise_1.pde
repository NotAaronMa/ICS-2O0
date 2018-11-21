int rad = 10;
int[][]alpha;
void setup(){
  size(500,680);
  alpha = new int[width/rad + 1][height/rad +1];

  for(int i = 0; i < alpha.length-1; i++){
     for(int j = 0; j < alpha[0].length-1; j++){
       
       int xval = i*rad;
       int yval = j*rad;
       alpha[i][j] = 255-((xval*yval)+(xval*yval)%255);
     }
  }
  System.out.println(alpha[0][0]);
}


void draw(){
  background(255);
  noStroke();
  int i = 0,j = 0;
  while(i < alpha.length){
    while(j < alpha[0].length){
      //double a = random(1);
      fill(encodeColor(255, 81, 226,(int)(alpha[i][j])));
      ellipse((i+1)*rad-rad/2, (j+1)*rad-rad/2, rad,rad); 
      j++;
    }
    j = 0;
    i++;
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
