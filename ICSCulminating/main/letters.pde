/*
    Everything pretaining to rendering letters
*/


//abstract letter class
abstract class Letter{
    //cordinates
    float x,y;
    //width and height of letters
    final static int w = 100;
    final static int h = 100;
    
    //constuctor
    public Letter(float x, float y){
        this.x =x;
        this.y = y;
    }

    //render the letter
    abstract void render(int c, float[][]transform);
}

//factory method hardcoded
Letter createLetter(int n, int x, int y){
    switch(n){
        case 0:
            return new a(x,y);           
        case 1:
            return new a(x,y);
        case 2:
            return new r(x,y);
        case 3:
            return new o(x,y);
        case 4:
            return new n(x,y);
    }
    return null;
}

//uppercase A
class a extends Letter{
    
    public a(int x, int y){
        super(x,y);
    }
    void render(int c, float[][]transform){
        fill(c);

        //values for the vertexes of name
        float[]ind1 = {
            x + w*(12/32f), y + h*(0/32f), 
            x + w*(20/32f), y + h*(0/32f), 
            x + w*(32/32f), y + h*(32/32f),
            x + w*(26/32f), y + h*(32/32f),
            x + w*(16/32f), y + h*(6/32f),
            x + w*(6/32f), y + h*(32/32f),
            x + w*(0/32f), y + h*(32/32f),
        };
        float[]ind2 = {
            x + w*(8/32f), y + h*(20/32f),
            x + w*(24/32f), y + h*(20/32f),    
            x + w*(24/32f), y + h*(16/32f),
            x + w*(8/32f), y + h*(16/32f),

        };
        //render the polygons besed on the indices
        renderShape(ind1, transform);
        renderShape(ind2, transform);
    }
}
//uppercase r
class r extends Letter{
    public r(float x, float y){
         super(x,y);
    }
    void render(int c, float[][]transform){
        fill(c);
        //values for the vertexes of name
        float[]ind = {
            x + w*(0/32f), y + h*(0/32f), 
            x + w*(6/32f), y + h*(0/32f),
            x + w*(6/32f), y + h*(32/32f),
            x + w*(0/32f), y + h*(32/32f),
        };
        float[]ind1 = {
            x + w*(10/32f), y + h*(18/32f), 
            x + w*(18/32f), y + h*(18/32f),
            x + w*(32/32f), y + h*(32/32f),
            x + w*(24/32f), y + h*(32/32f),
        };
        float[]ind2 = {
            x + w*(0/32f), y + h*(0/32f), 
            x + w*(20/32f), y + h*(0/32f),
            x + w*(26/32f), y + h*(4/32f),
            x + w*(26/32f), y + h*(16/32f),
            x + w*(20/32f), y + h*(20/32f),
            x + w*(0/32f), y + h*(20/32f),
        };    
  
        float[]cind2 = {
            x + w*(6/32f), y + h*(6/32f), 
            x + w*(18/32f), y + h*(6/32f),
            x + w*(18/32f), y + h*(14/32f),
            x + w*(6/32f), y + h*(14/32f),
        };
        //render the polygons based on indices
        renderShape(ind, transform);    
        renderShape(ind1, transform);
        renderShape(ind2, cind2, transform);
    }
}
//uppercase o
class o extends Letter{
    public o(float x, float y){
        super(x,y);
    }
    void render(int c, float[][]transform){
        fill(c);
        //values for the vertexes of name
        float[]ind = {
            x + w*(0/32f), y + h*(4/32f),
            x + w*(4/32f), y + h*(0/32f),
            x + w*(26/32f), y + h*(0/32f),
            x + w*(30/32f), y + h*(4/32f),
            x + w*(30/32f), y + h*(28/32f),
            x + w*(26/32f), y + h*(32/32f),
            x + w*(4/32f), y + h*(32/32f),
            x + w*(0/32f), y + h*(28/32f),
        };
        float[]cind = {
            x + w*(6/32f), y + h*(6/32f), 
            x + w*(24/32f), y + h*(6/32f), 
            x + w*(24/32f), y + h*(26/32f), 
            x + w*(6/32f), y + h*(26/32f), 
        };
        //render the polygons
        renderShape(ind, cind, transform);
    }
}
//uppercase n
class n extends Letter{
    public n(float x, float y){
         super(x,y);
    }
    void render(int c, float[][]transform){
        fill(c);
        //values for the vertexes of name
        float[]ind1 = {
            x + w*(6/32f), y + h*(32/32f),
            x + w*(0/32f), y+ h*(32/32f),

            x + w*(0/32f), y + h*(0/32f),
            x + w*(6/32f), y + h*(0/32f),
            
            x + w*(27/32f), y + h*(24/32f),
            x + w*(26/32f), y + h*(32/32f),
            x + w*(6/32f), y + h*(8/32f),
        };
        float[]ind2 = {
            x + w*(26/32f), y + h*(0/32f),
            x + w*(32/32f), y + h*(0/32f),
            x + w*(32/32f), y + h*(32/32f),
            x + w*(26/32f), y + h*(32/32f),

        };
        //render the polygons
        renderShape(ind1, transform);
        renderShape(ind2, transform);
    }
}