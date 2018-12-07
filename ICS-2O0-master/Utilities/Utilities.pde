/*
  3 patterns drawn out by a complex function
*/
void setup(){
   size(300,400);
}
// bunch of utility classes and methods
// Author Aaron Ma
//defines a 2 dimensional vector
class Vector2{
  //components of vector
 float a, b; 
 //constructor
 public Vector2(float a, float b){
     this.a = a;
     this.b =b;
 }
 //multiplies the vector with a scaler
 public void mul(int s){
   a*=s;
   b*=s;
 }
 //adds the vector with another vector
 public void add(Vector2 v){
    a += v.a;
    b += v.b;
 }
 public float mag(){
    return sqrt(a*a + b*b); 
 }
 public Vector2 unit(){
    float mag = mag();
    return new Vector2(a/mag, b/mag);
 }
}
//class defining a complex number
class Complex extends Vector2{
  public Complex(float a, float b){
    super(a,b); 
  }
  //algebraic mul of to compex numbers
  //(a+bi)(c+di) = ac-bd + adi + bci
  public Complex prod(Complex s){
    float a,b,c,d;
    a = this.a;
    b = this.b;
    c = s.a;
    d = s.b;
    return new Complex(a*c - b*d, a*d + b*c);
  }
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
    return new col(blendV(r,cl.r,ratio), blendV(g,cl.g,ratio), blendV(b,cl.b,ratio), alpha);
  }
  private int blendV(int a, int b, float ratio){
    float a1, b1;
    a1 = a/255f;
    b1 = b/255f;
    float res = (float)Math.sqrt((1-ratio)*a1*a1 + ratio*b1*b1);
    return (int)(res * 255);
    
  }
}


