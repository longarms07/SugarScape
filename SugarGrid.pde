
import java.util.LinkedList;
import java.util.ArrayList;


class SugarGrid {

  /* Initializes a new SugarGrid object with a w*h grid of Squares, 
  *  a sideLength for the squares (used for drawing purposes only) 
  *  of the specified value, and 
  *  a sugar growback rule g. 
  *  Initialize the Squares in the grid to have 0 initial and 0 maximum sugar.
  *
  */
  
  
  int w;
  int h;
  int sl;
  int rows;
  int columns;
  int total;
  GrowthRule gbr;
  ArrayList<Square> grid;
  int turn = 0;
  PollutionRule pr;
  MovementRule mr;
  
  
  public SugarGrid(int widthh, int heightt, int sideLength, GrowthRule g, PollutionRule p, MovementRule m) {
    this.w = widthh;
    this.h = heightt;
    this.sl = sideLength;
    this.gbr = g;
    this.pr = p;
    this.mr = m;
    //make squares
    grid = new ArrayList<Square>();
    
    rows = w;
    columns = h;
    int rowCount = 0;
    int columnCount = 0;
    total = (rows*columns);
    for(int i = 0; i < total; i++){
      Square s = new Square(0,0, rowCount, columnCount);
      grid.add(s);
      rowCount = rowCount+1;
      if(rowCount == rows){
        rowCount = 0;
        columnCount = columnCount+1;
      }
    }
    
  }

  /* Accessor methods for the named variables.
  *
  */
  public int getWidth() {
    return w;
  }
  
  public int getHeight() {
    return h;
  }
  
  public int getSquareSize() {
    return sl;
  }
  
  /* returns respectively the initial or maximum sugar at the Square 
  *  in row i, column j of the grid.
  *
  */
  public int getSugarAt(int i, int j) {
    //find the index
    if(i < rows && j < columns){
    int index = (i + (rows*j)); 
    Square current = grid.get(index);
    //print(current.xPos + " , " + current.yPos);
    return current.getSugar();
    }
    return -1;
  }
 
 
 
 
 
  public int getMaxSugarAt(int i, int j) {
    //find the index
    if(i < rows && j < columns){
    int index = (i + (rows*j)); 
    Square current = grid.get(index);
    //print(current.xPos + " , " + current.yPos);
    return current.getMaxSugar();
    }
    return -1;
  }

  /* returns the Agent occupying the square at position (i,j) in the grid, 
  *  or null if no agent is present there.
  *
  */
  public Agent getAgentAt(int i, int j) {
    if(i < rows && j < columns){
    int index = (i + (rows*j)); 
    Square current = grid.get(index);
    //print(current.xPos + " , " + current.yPos);
    return current.getAgent();
    }
    return null;
  }

  /* places Agent a at Square(x,y), provided that the square is empty. 
  *  If the square is not empty, the program should crash with an assertion failure.
  *
  */
  public void placeAgent(Agent a, int x, int y) {
    if(x < rows && y < columns){
    int index = (x + (rows*y)); 
    Square current = grid.get(index);
    if(current.getAgent() == null){
    current.setAgent(a);
    }
    }
    //print(current.xPos + " , " + current.yPos);
  }
  
  

  

  /* A method that computes the Euclidian distance between two squares on the grid 
  *  at (x1,y1) and (x2,y2). 
  *  Points are indexed from (0,0) up to (width-1, height-1) for the grid. 
  *  The formula for Euclidean distance is normally sqrt( (x2-x1)2 + (y2-y1)2 ) However...
  *  
  *  As in the book, the grid is a torus. 
  *  This means that an Agent that moves off the top of the grid ends up at the bottom 
  *  (and vice versa), and 
  *  an Agent that moves off the left hand side of the grid ends up on the right hand 
  *  side (and vice versa). 
  *
  *  You should return the minimum euclidian distance between the two points. 
  *  For example, euclidianDistance((1,1), (19,19)) on a 20x20 grid would be 
  *  sqrt(2*2 + 2*2) = sqrt(8) ~ 3, and not sqrt(18*18 + 18*18) = sqrt(648) ~ 25. 
  *
  *  The built-in Java method Math.sqrt() may be useful.
  *
  */
  public double euclidianDistance(Square s1, Square s2) {
    int x1 = s1.getX();
    int y1 = s1.getY();
    int x2 = s2.getX();
    int y2 = s2.getY();
    
    int xtry1 = abs(x1 - x2); 
    int xtry2 = w-abs(x1-x2); //wrap around, converse of getting to it normally
    int minx = min( xtry1, xtry2); //find the minimum of the two
    int ytry1 = abs(y1 - y2);
    int ytry2 = h-abs(y1-y2);
    int miny = min( ytry1, ytry2);
    
    double d = sqrt( (minx*minx) + (miny*miny));
     
    return d;
  }
  
  
  
 
  
  public void addSugarBlob(int x, int y, int radius, int max) {
  // Creates a circular blob of sugar on the gird. 
  //  The center of the blob is at position (x,y), and 
  //  that Square is updated to store a maximum of max sugar or 
  //  its current maximum value, whichever is greater.
  if(x < rows && y < columns){
  int centerX = x;
  int centerY = y;
  int index = (centerX + (rows*centerY)); 
  Square center = grid.get(index);
  center.setMaxSugar(max);
  center.setSugar(max);
  
  //  Then, every square within euclidian distance of radius is updated 
  //  to store a maximum of (max-1) sugar, or its current maximum value, 
  //  whichever is greater. 
  //  Then, every square within euclidian distance of 2*radius is updated 
  //  to store a maximum of (max-2) sugar, or its current maximum value, 
  //  whichever is greater. 
  //  This process continues until every square has been updated. 
  //  Any Square that has a new maximum value 
  //  should also have its Sugar level set to this maximum.
  for(int i = 0; i < total; i++){
    //get the current square
    Square current = grid.get(i);
    if(i != index){ //if not the base square
    double ed = (this.euclidianDistance(center, current)); //get the euclidean distance
      for(int j = max; j > 0; j--){ //J will be the amount of sugar added
        double r = (j*radius); //ed from center by radius
        if( r == Math.round(ed)){ //if the two are equal
        current.setMaxSugar(max-j);
         current.setSugar(max-j); 
        
        }
      }
    }
  }
  }
  }
  
  
 
  public LinkedList<Square> generateVision(int x, int y, int radius) {
    // Returns a linked list containing radius squares in each cardinal direction, 
  // centered on (x,y). 
  LinkedList<Square> gv = new LinkedList<Square>();
  if( x >= 0 && x < rows && y >= 0 && y<columns && radius >= 0){
  int centerX = x;
  int centerY = y;
  int index = (centerX + (rows*centerY)); 
  Square center = grid.get(index);
  if(radius == 0){
    gv.add(center);
    return gv;
  }
  
   for(int i = 0; i < total; i++){
    //get the current square
    Square current = grid.get(i);
    if(i != index){ //if not the base square
    double ed = (this.euclidianDistance(center, current)); //get the euclidean distance
      
        double r = radius; 
        for(double j = r; j > 0; j--){
        if( ed == j){ //if the two are equal
          gv.add(current);
        }
        }
    }
  }
  
  
  
  
  
  
  
  
  return gv;
  }
  
  //  For example, generateVision(5,5,2) should return the squares 
  //   (5,5), (4,5), (3,5), (6,5), (7,5), (5,4), (5,3), (5,6), and (5,7). 
  
  //  Your program may do whatever it likes if (x,y) is not a point on the grid, 
  //  or radius is negative. 
  
  // When radius is 0, it should return a list containing only (x,y). 
    return null; 
  }
  
  
  
  public void update(){
    turn = turn+1;
    Square current;
    LinkedList<Square> move = new LinkedList<Square>();
    
    //boolean go = true;
    
     
    
    
    
    
    for(int i = 0; i < total; i++){
      //go = true;
      current = grid.get(i);
      gbr.growBack(current);
     
      
      //for(int z = 0; z < moved.size(); z++){
      //   Agent c = moved.get(z);
      //   if(c == current.getAgent()){
      //     go = false;
       //  }
        //}
      if(current.getAgent() != null /*&& go == true*/){
         //check if agent moved
        move.add(current);
      }
      //do pollution flux
      LinkedList<Square> neighbors = this.generateVision(current.getX(), current.getY(), 1);
      
      float flux = current.getPollution();
      Square cn = current;
      for(int k = 0; k<neighbors.size(); k++){
        cn = neighbors.get(k);
        flux = flux + cn.getOldPollution();
      }
      //print(ceil(flux/(neighbors.size()+1)));
      flux = round(flux/(neighbors.size()+1));
      current.setOldPollution();
      current.setPollution(int(flux));
      //println(flux);
    }
      
      for(int j = 0; j < move.size(); j++){ 
        Square current2 = move.get(j);
        Square Asquare = current2;
        Agent currentA = current2.getAgent();
        
        LinkedList<Square> vision = this.generateVision(current2.getX(), current2.getY(), currentA.getVision());
        
        Square target = mr.move(vision, this, current2);
        if(target.getAgent() == null){
          currentA.move(current2, target);
          Asquare = target;
        }
        currentA.step();
        if(currentA.isAlive() == false){
         Asquare.setAgent(null); 
        }else{
          pr.pollute(Asquare);
          currentA.eat(Asquare);
        }
      //}
      }
      
    }
    
  
 
  
  
  
  public void display(){
    for(int i = 0; i < total; i++){
     Square current = grid.get(i);
     current.display(sl);
     if(current.getAgent() != null){
     }
     
    }
    }
    
    public void killAgent(int x, int y){
      if( x >= 0 && x < rows && y >= 0 && y<columns){
      int centerX = x;
      int centerY = y;
      int index = (centerX + (rows*centerY)); 
      grid.get(index).getAgent().setSugarLevel(0);
      grid.get(index).setAgent(null);
      }
    }
    
    public void addAgentAtRandom(Agent a){
      
      LinkedList<Square> list = new LinkedList<Square>();
      
      for(int i = 0; i < total; i++){
        Square current = grid.get(i);
        if(current.getAgent() == null){
          list.add(current);
        }
      }
      
        int index = int(random(0, list.size()-1)); 
        Square current = list.get(index);
          current.setAgent(a);
        
    }
    
    
    public ArrayList<Agent>getAgents(){
      ArrayList<Agent> ga = new ArrayList<Agent>();
      Square current;
      for(int i = 0; i<grid.size(); i++){
        current = grid.get(i);
        if(current.getAgent() != null){
          ga.add(current.getAgent());
        }
      }
      return ga;
    }
    /*
    public void drawLine(Agent a, Agent b){
      Square aa = null;
      Square bb = null;
      Square current = null;
      for(int i = 0; i < grid.size(); i++){
        current = grid.get(i);
        if(current.getAgent() == a){
          aa = current;
        }
        if(current.getAgent() == b){
          bb = current;
        }
      }
      if(aa != null && bb != null){
        fill(0,0,0);
        stroke(5);
        line(sl*aa.getX()+sl/2, sl*aa.getY()+sl/2, 
          sl*bb.getX()+sl/2, sl*bb.getY()+sl/2);
        println("line made");
    }
    } */
}