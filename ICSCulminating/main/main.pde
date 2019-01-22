/*
ICS2O0 Culminating
Author: Aaron Ma
Date last edited: 22/01/19
*/

//current time
public long now;
//time of program start
public long start;
//the letters
Letter[]letters;
//the different backgrounds
Background[]backgrounds;
//the index of the current background
int currentBG;
//prevents the background from changing if a key is held down
boolean autoBG = true;
void setup(){
    size(1280,720);
    letters = new Letter[5];
    start = System.currentTimeMillis();
    for(int i = 0; i < 5; i++){
        int nx = Letter.w*i;
        letters[i] = createLetter(i,nx + (width - 5*Letter.w)/2,Letter.h*2);
    }
    backgrounds = new Background[2];
    backgrounds[0] = new Vaporwave();
    backgrounds[1] = new Rain();
}

void draw(){
    //update current time
    now = System.currentTimeMillis() - start;
    //render current background and letters
    backgrounds[currentBG].render();
    renderLetters();
   
}

void renderLetters(){

    float phase = sin(radians(now/10f));
    //set up the transformation matrix
    float[][]transform = backgrounds[currentBG].getMatrix(now);
    //render the letter
    noStroke();   
    col c;

    //generate the color of the name based on the cordinates of the mouse
    float mag, th;
    mag = sqrt(sq(mouseX - width/2) + sq(mouseY - height/2));
    int g =(int)(127 + 127*sin(1/2f*radians(mag))); 
    int b;
    if(mouseX - width/2 != 0){
        b = (int)(127 + 127*atan((mouseY - height/2)/(mouseX-width/2)));
    }else{
        b = (int)(127 + 127*atan((mouseY - height/2)));
    }
    c = new col(127,g,b,255);
    //render the letters
    for(int i = 0; i < letters.length; i++){
        letters[i].render(c.encode(),transform);
    }
    //render the lines under name
    renderULines(c.encode(),transform);
}

//input handling
void keyPressed(){
    //only allow background to be changed if key is released
    if(!autoBG){
        currentBG++;
        currentBG %= 2;
        autoBG = true;
    }
}
void keyReleased(){
    autoBG = false;
}