void setup(){
  size(729,729);
 
  
}
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
  carpet(0,cl,-3,-3,width,height);
  keyCooldown--;
}

void carpet(int cl, int ml, int sx, int sy, int ex, int ey){
  if(cl == ml){
     return; 
  }
  int delta = (ex - sx)/3;
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
       int xval = i*delta + sx;
       int yval = j*delta + sy;
       if(!((i == 1) && (j== 1))){
         fill(255);
         rect(xval,yval,delta,delta);
         carpet(cl+1, ml,xval,yval,xval+delta,yval+delta);
       }        
    }
  }
}
