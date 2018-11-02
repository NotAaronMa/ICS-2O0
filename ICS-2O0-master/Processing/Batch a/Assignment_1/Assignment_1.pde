/*
* Assignment 1 
* By Aaron Ma
* created oct 5
* last modified oct 15
*/

int w,h,horizon;
//w is screenwidth, h is screenheight,horizon is length between the top of the screen and the horizon
void setup(){
   size(900,500);
   w = 900;
   h = 500;
   p = new pair[17];
   
   horizon = 250;// set distance from the top to the horizon
   sunc = new pair(200,horizon); // sets cords for the sun
   for(int i = 0; i < p.length; i++){ //generates the endpoint of the sun rays
     p[i] = new pair(i*20-180, 125, sunc); // angle is i * 20-180, 150 is magnitude

  }
}
pair sunc;
pair[]p;
void draw(){ 
  int n = #1B9EF2; // color for background
  background(n); // sets the background color to the hex of n
  int radius = 130; // radius of the sun
  fill(#FAFF00); // the sun color
  strokeWeight(0);
  ellipse(sunc.x,sunc.y,radius,radius); //draws the sun
  
  for(int i = 0; i < p.length; i++){
   p[i].drawLineBetween(sunc);
  }
  fill(#39DB6B); //sets the fill to the color of the grass
 // strokeWeight(0);
  rect(-10,horizon,w+10,h+10); //fills in the grass drawing a bit of extra to make sure that only the line on the horizon shows
  //strokeWeight(1);
  
  //background done now time for house
  fill(#C14646);
  int houseHeight = horizon - 50;
  rect(w - 400, horizon -50, 250,150);
 // rect(househeight
  fill(0);
  triangle((float)(w -425),(float)houseHeight, (float)(w-125), (float)houseHeight, (float)(w -275f),(float)(houseHeight - 75));
  fill(255);
  rect(w -300, houseHeight + 50,45,90);
  fill(0);
  ellipse(w-290,horizon + 35,10,10);
}
class pair{ // helper class for drawing the rays
  int x,y; //x and y components of the yeet
  public pair(int a, int b){ // constructor that sets the variables
    this.x = a; //set x to a
    this.y = b; //set y to b
  };
  public pair(float th, int m, pair o){ // creates a point with magnitude m and angle th (theta in deg) away from pair o
      th = (th/180)*3.14159; //converts theta to radians
      float sin = sin(th);  //gets trig values
      float cos = sin(th-(3.1415926/2));
      x = (int)(cos*m) + o.x; //sets the length of x and y components 
      y = (int)(sin*m) + o.y; 
  }
  void drawLineBetween(pair a){ // draw the line 
    stroke(#FAFF00); //sets color to yellow
    strokeWeight(4); // set stroke width to 10
    
    line(a.x,a.y,x,y); //draws the line
    strokeWeight(1); //resets the stroke
    stroke(0);
  }
  
  
}