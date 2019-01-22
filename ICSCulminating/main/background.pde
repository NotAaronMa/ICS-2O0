//class defines behavior for a background
abstract class Background{

    //constructor
    public Background(){
        init();
    }
    //returns the transformation matrix for the name
    float[][] getMatrix(long now){
        return createTMatrix();
    }
    //do the preloading
    abstract void init();
    //render the background
    abstract void render();
}
//background displaying rain as a background
class Rain extends Background{
    Drop[]rain;
    public Rain(){
        super();
    }
    void init(){
        rain = new Drop[1000];
        for(int i = 0; i < rain.length; i++){
            rain[i] = new Drop(random(width), -2*random(height));
        }
    }
    void render(){
        background(0);
        //loop through all the raindrops
        for(int i = 0; i < rain.length; i++){
            strokeWeight(1);

            fill(new col((int)random(255),(int)random(255),(int)random(255), 255).encode());
            rect(rain[i].x, rain[i].y, 4,20);

            //apply acceleration
            rain[i].v += .961;
            rain[i].y += rain[i].v;
            //reset drops
            if(rain[i].y >= height){
                rain[i].v = 0;
                rain[i].x = random(width);
                rain[i].y = -random(height);
            }
        }
    
    }

    //stores x y and velocity of rain
    class Drop{
        float x,y,v;
        //constructor
        public Drop(float x, float y){
            this.x = x;
            this.y = y;
            v = 0;
        }
    }



}
//draws a vaporwave styled background
class Vaporwave extends Background{
    //constructor
    public Vaporwave(){
        super();
    }
    //a color gradient for day-night cycle
    col[]grad;
    //an array storing the y cordinate of the road lines
    int[]rLines;  
    void init(){
        //initialise variables
        rLines = new int[20];
        grad = new col[1500];
        int n = grad.length/4;
        col night = new col(#280637);//sky color night
        col day = new col(#3cbbdc);//sky color day
        col evening = new col(#e6a949);//sky color eventing
        col[][]grads = new col[4][1];//temporary storage matrix
        grads[0] = night.grad(day,n); //night to day
        grads[1] = day.grad(evening,n);//day to eventing
        grads[2] = evening.grad(night,n); //evening to night
        grads[3] = night.grad(night,n);//more night cause night looks good
        //copy the storage matrix into the gradient array
        for(int i = 0; i < 4; i++){
            for(int j = 0; j < n; j++){
                col c = grads[i][j];
                grad[i*n + j] = c;
            }
        }
        //set up a spacing of 20 between all road lines
        for(int i = 0; i < 20; i++){
            rLines[i] = i * (height/20);
        }
    }

    void render(){ 
        //use current time to determine sky color
        int cphase = (int)((now/100f) % 1500);
        col cur = grad[cphase];
        background(cur.encode());

        //find the position of and draw the sun
        fill(new col(255,255,0,255).encode());
        float suny = 1.5*(cphase/(float)grad.length)*height - height/2 + 100;
        ellipse(width/2, suny, 200,200);
        //draw the ground based on the sky color
        fill(new col(cur.g/4,cur.g/4,0,255).encode());
        rect(0,height*(1/2f),width,height);
        
        //draw road
        strokeWeight(1);
        stroke(new col(255,0,255,255).encode());
        line(width*(15/32f), height*(1/2f), width*(1/4f), height);
        line(width*(17/32f), height*(1/2f), width*(3/4f), height);
        //render road lines
        for(int i = 0; i < rLines.length; i++){
            rLines[i] +=2;
            //scale so road lines appear to be heading towards the user
            float s = 4*pow(rLines[i]/(float)height,5);
            if(rLines[i] > height/2){
                fill(new col(255,0,255,255).encode());
                //set up the indices for the road line
                float[]indices = {
                    width*(510/1024f), rLines[i],
                    width*(514/1024f), rLines[i],
                    width*(514/1024f), rLines[i] + 20,
                    width*(510/1024f), rLines[i] + 20,
                };
                //create scale matrix by a factor of s
                float[][]matrix = createTMatrix();   
                scale(s, s, matrix);
                //render based on indices and scale matrix
                renderShape(indices, matrix);
            }
            //reset road lines
            if(rLines[i] > height){
                rLines[i] = 0;
            }
        }
        
        
    }

    //return a transformation matrix based on the current time
    float[][] getMatrix(long now){
        float phase = sin(radians(now/10f));
        float[][]matrix = createTMatrix();   
        rotate(5*phase, matrix);
        translate( 50*phase, phase, matrix);
        scale(1,1, matrix);
        return matrix;
    }


}