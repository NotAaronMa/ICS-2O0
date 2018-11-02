
/*
* Assignment 1 
* By Aaron Ma
* created oct 10
* last modified oct 15
*/
void setup(){ 
 size(400,700); //set size
 x1 = 0; //init all variables
 x2 = 0;
 size1 = 20;
 size2 = 90;
 x2 = 100;
 y2 = 700;
}
float size1,size2,x1,x2,y1,y2;//cords and size for circles
boolean done = false; //check if sketch is done
void draw(){
   if(!done){
     ellipse(x1,y1,size1,size1); //draw ellipse 1 
     x1++; //increment x1
     y1++; //increment y1
     size1+=0.2; //increment the size of circle 1
     size2+=0.2; //increment the size of circle 2
     done  = y1 >= 500; //set done to wheather y1 is greater than 500
   
     x2 += 1; //increment x2
     y2 -=6; //increment y2
     size2  -= 0.7; //decrement size2
   ellipse(x2,y2,size2,size2); //draw circle2
 }
}
