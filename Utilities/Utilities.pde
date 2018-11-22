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
