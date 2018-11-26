void setup(){
  size(640,640);
  
  System.out.println("done");
}


void draw(){
  background(255);
  noFill();
  
  carpet(0,5,-3,-3,width,height);
}

void carpet(int cl, int ml, int sx, int sy, int ex, int ey){
  if(cl == ml){
     return; 
  }
  int delta = (ex - sx)/3;
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
       int xval = i*delta + sx+1;
       int yval = j*delta + sy+1;
       if(!((i == 1) && (j== 1))){
         color(0);
         fill(255);
         rect(xval,yval,delta,delta);
         carpet(cl+1, ml,xval,yval,xval+delta,yval+delta);
       }
        
    }
  }
}
