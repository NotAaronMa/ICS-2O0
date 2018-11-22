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
 
}

//class defining a complex number
class Complex extends Vector2{
  public Complex(int a, int b){
    super(a,b); 
  }
  public void mul(Complex s){
    
  }
}
