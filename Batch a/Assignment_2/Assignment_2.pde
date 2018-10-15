/*
* Assignment 1 
* By Aaron Ma
* created oct 9
* last modified oct 15
*/


public static final double pi = 3.1415926; 

public float rad(float deg){ //radians to degrees
  return (deg/180)*(float)pi;
  
}
void setup(){
  size(640,640);  
  int xhalf = width/2;
  int yhalf = height/2 + 50;
  
  arc[]a = { //array containing all the data for the arcs
    //        x       y      start angle  end angle   color    width  radius
    new arc(xhalf, yhalf+20, rad(180),    rad(360),   #BFE335, 20,    430), //yellow arc
    new arc(xhalf, yhalf,    rad(180),    rad(360),   #0890FC, 10,    440), //blue arc
    new arc(xhalf, yhalf-20, rad(180),    rad(370),   #FA0834, 10,    440), //red arc
    new arc(xhalf, yhalf-30, rad(140),    rad(380),   #27FA08, 20,    440), //green arc
    new arc(xhalf, yhalf,    rad(170),    rad(380),   #FF00FB, 6,     480), //purple arc
    
    
  };
  
  af = new arc[a.length]; // copies the local array into a global array 
  for(int i = 0; i < af.length; i++){
    af[i] = a[i];
  }
}
arc[]af; //array containing the arcs
void draw(){
   background(255); //sets background
   for(int i = 0; i < af.length; i++){
      af[i].drawArc(); //draws the arc based on the data in the array
   } 
}

class arc{ //small class to help with drawing the arcs
   int x; //x pos
   int y; //y pos
   double sa; // angle to start at
   double ea; // angle to end at
   double r; // radius of the arc
   int colour, weight; //color and weight
   public arc(int x, int y, double sa,  double ea, int colour, int weight,double radius){ //constructor
     this.x = x; this.y = y; this.sa = sa; this.ea = ea;this.colour = colour;this.weight = weight;this.r = radius; 
   }
   
   
   public void drawArc(){
     stroke(colour); //sets color
     strokeWeight(weight); //sets weight
     noFill(); //makes sure the arc isn't filled
     arc((float)x,(float)y,(float)r,(float)r,(float)sa,(float)ea); //draws arc
     strokeWeight(10);
     point(x,y); //draws point
     color(0); //resets the color
     strokeWeight(1);
     
     
   }
}