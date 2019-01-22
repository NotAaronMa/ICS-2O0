/*
    Rendering Backend
*/

class col {
    int r, g, b, a;
    //constructor
    public col(int c) {
        b = c &255; //blue channel
        g = (c >> 8) &255; //green channel
        r = (c >> 16) &255; //red channel
        a = (c >>  24) & 255; //alpha channelE
    }
    // constructor 
    public col(int r, int g, int b, int a) {
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }
    //encode the color
    public int encode() {
        int c = 0;
        c += r<<16; //left shift by 16 for red channel
        c += g<<8; //left shift by 8 for green channel
        c += b;  //blue channel 
        c+= a << 24; //set alpha channel to 255
        return c;
    }
    public col mix(col cl, float ratio) {
        //blend the two alpha channels
        return new col(
            blendChannel(r, cl.r, ratio),
            blendChannel(g, cl.g, ratio), 
            blendChannel(b, cl.b, ratio), 
            blendChannel(a, cl.a, ratio)
        ); 
    }

    private int blendChannel(int a, int b, float ratio) {
        //blend two color channels
        float a1, b1;
        //channels as a fraction of 255
        a1 = a/255f;
        b1 = b/255f;
        //square root of the squares of fractions
        float res = (float)Math.sqrt((1-ratio)*a1*a1 + ratio*b1*b1);
        //multiply by 255 and cast to integer to get a proper color channel
        return (int)(res * 255) ;
    }


    //returns a gradient from this to c1
    public col[]grad(col c1, int n){
        col[]a = new col[n];
        for(int i = 0; i < n; i++){
            a[i] = mix(c1, sq(i/((float)n)));
        }
        return a;
    }
}
//render a shape based on indices
void renderShape(float[]ind, float[][]transform){
    ind = transform(ind,transform);
    beginShape();
    for(int i = 0; i < ind.length; i+=2){
        vertex(ind[i], ind[i+1]);
    }
    endShape();
}
//render a shape based on indices with contours
void renderShape(float[]ind, float[]cind, float[][]transform){
    ind = transform(ind,transform);
    cind = transform(cind, transform);
    beginShape();
    for(int i = 0; i < ind.length; i+=2){
        vertex(ind[i], ind[i+1]);
    }
    beginContour();
    for(int i = cind.length-1; i >= 0; i-=2){
        vertex(cind[i-1], cind[i]);
    }
    endContour();
    endShape();
}

//renders the lines underneath my name
void renderULines(int c, float[][]transform){
    int lw = Letter.w*5;
    int lh = Letter.h;
    float lx = letters[0].x;
    float ly = letters[0].y;
    float[]ind = {
        lx, ly + lh,
        lx + lw, ly + lh,
        lx + lw, ly + lh*(10/9f),
        lx, ly + lh*(10/9f),
    };
    //render 2 underlines 
    for(int i = 0; i < 2; i++){
        renderShape(ind, transform);
        translate(0,20,transform);
    }
    
}

//apply the matrix multiplication
//3x3 matrix to allow multiple transformations to be applied at once
float[]transform(float[]ind, float[][]tf){
    //the transformed indices
    float[]tInd = new float[ind.length];
    for(int i = 0; i < ind.length; i+=2){
        float x,y,s;
        x = ind[i] - width/2;
        y = ind[i+1] - height/2;
        s = 1;
        /*
            [3x3] x [3x1] vector-matrix multiplication

            [x]  [a,b,c]   [ax + dy + zg]
            [y]* [d,e,f] = [by + be + bh]
            [z]  [g,h,i]   [zc + zf + zi]
            res is a 3x1 vector not matrix
            no need for z since 2d transformations
        */
        float nx, ny,ns;
        nx =  x*tf[0][0] + y*tf[1][0] + s*tf[2][0]; 
        ny = x*tf[0][1] + y*tf[1][1] + s*tf[2][1];
        tInd[i] =nx + width/2;
        tInd[i+1] = ny + height/2;
    }

    return tInd;
}

//create a transformation matrix with no transformations
public float[][]createTMatrix(){
    float[][]f = {
        {1, 0, 0},
        {0, 1, 0},
        {0, 0, 1},
    };
    return f;
}
//apply a roation to the matrix
public void rotate(float th, float[][]matrix){
    matrix[0][0] = cos(radians(th));
    matrix[0][1] = -sin(radians(th));
    matrix[1][0] = sin(radians(th));
    matrix[1][1] = cos(radians(th));
}
//apply a translation to the current matrix
public void translate(float xt, float yt, float[][]matrix){
    matrix[2][0] += xt;
    matrix[2][1] += yt;
}
//apply a scale transformation to the given matrix
public void scale(float xs, float ys, float[][]matrix){
    matrix[0][0] *= xs;
    matrix[1][1] *= ys;
}