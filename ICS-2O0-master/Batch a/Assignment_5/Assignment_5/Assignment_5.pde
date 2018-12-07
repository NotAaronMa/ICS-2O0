
/*
* Assignment 1 
* By Aaron Ma
* created oct 12
* last modified oct 15
*/
void setup(){
   size(500,680); //sets screen width and height
   stroke(#0FFF2D); //draws green line
   strokeWeight(15);
   line(0,320,500,320);
   x1 = 0; //sets init x values for circle1 and 2
   x2 = 0; 
   diam1 = 10; //sets init size for circle1
}
void draw(){ //draws both the circles to the screen
  circle1();
  circle2();
}


float x1,y1,diam1; //data for drawing circle1
float x2,y2,diam2; //data for drawing circle2

void circle1(){ // draw circle1
  diam1 += 0.6; //increment size
  strokeWeight(0); //set stroke color, fill color and stroke weight
  stroke(255);
  fill(0);
  x1+= dx; //increments x by delta x
  y1+=dy; //increment y by delta y
  if(y1 >= height/2 -10||x1 >= width|| x1 < -40){ // check if circle reaches edge of the screen or green line
   //System.out.println("reset 1"); //debug code please ignore
   reset1(); //resets circle1
  }
  ellipse(x1,y1,diam1,diam1); //draws the elipse
}
void circle2(){ // draw circle2
  stroke(0); //set the strokeweight and fill
  fill(255);
  ellipse(x2,y2,diam2,diam2); //draw circle 2
  x2 += 1; //increment x by 1
  y2 -= 7; //decrement y by 7
  if(x2 >= width || y2 <= height/2){ //check if circle reaches edge of screen or green line
    reset2();
  }
}
float px = 0; // previous x value
float dx = 1.2; // delta x
float dy = 4; // delta y
void reset1(){ // resets circle one
  px = x1; // saves the final position of the previous circle
  if(x1 >= width){ //if previous position is greater than the width
    x1 = -20; // set new x value
  }else{ //every other case
    x1 = px; //set x value to previous x value
  }
  diam1 = 25; //set the size to 25;
  y1 = 0; // set y value to 0
  dx = random(0.5)+1; // change in x min value -1 max value 4 so it tends to go to the right
  dy = random(5) +3; //change in y min value 2 max value 7 
 // x1 = random(width);
  
}
int nx2; // the x value of the next circle's start pos
void reset2(){ //resets circle 2
  diam2 = 50; // set size to 50
  nx2 += 25; // set x to previous start value +25
  x2 = nx2; // save the current start x value
  y2 = height; //sets the y to the bottem of the screen
  if(nx2 >= width){ // resets the value if y is greater than the screen width
     nx2 =- 40; // resets the next x value
  }
}
