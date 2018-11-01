//time and timeScale
float timeScale = 0.25;
float time = 0;
//array containing positions the stars
Vector2[]stars;
//array containing the mountains
mountain[]mountains = {
  //            x  peak   w   h     base color, snowcap color
  new mountain(250, 350, 700, 300,     90,          90), 
  new mountain(400, 450, 700, 400,     90,          90), 
  new mountain(600, 400, 500, 400,     90,          90)
};


void setup() {
  //array storing the position of the stars at night
  stars = new Vector2[1024];
  
  //randomly generate the positions for the stars
  for(int i = 0; i < stars.length; i++){
    stars[i] = new Vector2(random(width),random(height)); 
  }
  //set the size
  size(800, 600);
}

//if key is pressed
void keyPressed(){
  //set timescale to 7
  timeScale = 7;
}// when a key is released
void keyReleased(){
  //reset timescale
  timeScale = 0.25f; 
}
void draw() {
  //normalize time to between 0 and 360 degrees
  time = normalizeAngle(time); 
  //render the sky
  renderSky(time); 
  
  //render all the mountains
  for (int i = 0; i < mountains.length; i++) {
    mountains[i].render();
  }
  
  //draw the ground
  fill(encodeColor(40,105,40,255));
  rect(0, height - 200,width, height);
 
  //draw the lake
  fill(encodeColor(30,50,205,255));
  ellipse(width/2, height-100 , 700,150);
  
  //increment the time by timescale
  time += timeScale; 
}

//returns an angle between 0 and 360 equal to theta
public float normalizeAngle(float theta){
   //return theta modulo 360
   return theta%=360; 
}

//generates the color of  the sky based on the time
public int genBgColor(float time, int alpha){ //time is an angle between 0 and 360 representing how far allong the sun is across it's path
  //System.out.println(time);
  if(0<=time && time<30){ //time is between 0 and 360 return dark blue
     return encodeColor(14, 55, 155,alpha);
  }else if(30 <= time && time < 150){ //if time is between 60 and 150 white
    return encodeColor(130,150,255,alpha);
  }else if(150 <= time && time < 180){ //if time is between 150 and 180 grey
   return encodeColor(130,150,255,alpha); 
  }else if(180 <= time && time < 210){ // if time is between 180 and 210 return purple
   return encodeColor(61,0,55,255);
  }else if(210 <= time && time < 330){ // if time is between 210 and 240 return black
    return encodeColor(0,0,0,alpha);
  }else if(330 <= time && time < 360){ // if time is between 330 and 360 return purple
    return encodeColor(61,0,55,alpha);
  }
  //default return white
  return encodeColor(255,255,255,255); 
}

//renders the sun or moon based upon a sine function
public void renderSun(float time, boolean day){
    // x and y cords of the sun
    float sunX, sunY;

    //caluclate the position of the sun based on a sine function
    sunX = (width+100)*(time/180f);
    sunY = -250*sin(radians(time/0.9f)) + 300;
    
    //draw the sun or the moon
    strokeWeight(0);
    if(day){
        fill(encodeColor(255,255,0,255));
        ellipse(sunX, sunY, 100,100);
    }else{
        fill(200);
        ellipse(sunX, sunY, 70,70);
    }
    
}
//renders the sky
public void renderSky(float time){
    //set the background to the bgColor(time)
    background(genBgColor(time,255));
    //If it is night
    if(time > 180){ 
      //set make the time smaller than 180 so the render function works
      time -= 180; 
      //draw the stars based on the array of vectors
      stroke(encodeColor(255,255,0,200));
      strokeWeight(2);
      for(int i = 0; i < stars.length; i++){
        float x = stars[i].a;
        float y = stars[i].b;
        point(x,y);
      }
      
      //render the moon 
      renderSun(time,false);
    // if it is day
    }else{
       //render the sun
      renderSun(time,true);
    }
}

//encodes a color into an int using bitshifts
//allows me to alter the alpha of a color
//makes my life easier because then i can store the color as an int instead of 4 bytes
//like int color instead of byte r, g, b, a;
public int encodeColor(int r, int g, int b, int a) {
  int c = 0;
  c += r<<16; //left shift by 16 for red channel
  c += g<<8; //left shift by 8 for green channel
  c += b;  //blue channel 
  c+= a << 24; //set alpha channel to 255
  return c;
}

// class defining a 2d Vector
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

//mountain class
class mountain {
  float x, peak, h, w;
  int color1, color2;
  
  //constructor
  public mountain(int x, int y, int w, int h, int color1, int color2) {
    this.x = x;
    this.peak = y;
    this.h =h;
    this.w = w;
    this.color1 = color1;
    this.color2 = color2;
  }
  
  //renders the mountain
  public void render() {
    stroke(0);
    
    fill(color1);
    stroke(color1);
    //draws base triangle
    triangle(
      x, height - peak, 
      x - w/2, height - peak +h, 
      x + w/2, height - peak +h);
      
    //makes the top 1/3 of the mountain color2
    fill(color2);
    stroke(color2);
    float n = h/3;
    triangle(
      x,         height-peak, 
      x - w/6, height - peak+n, 
      x + w/6, height - peak+n
    );
  }
}