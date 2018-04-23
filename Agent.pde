class Agent {
  /* Agent fields:
  *    metabolism - int? float?
  *    vision - int, right? measured in grid steps
  *    stored sugar - int, right?
  *    movement rule - a reference to a MovementRule object
  *     (should all Agents have the same movement rule?)
  */
  private int m;
  private int v;
  private int sl;
  private int age;
  private MovementRule mr;
  private int colors = 0;
  private char sex;
  private boolean[] culture;
 // private int lastTurn = -1;
  
  /* initializes a new Agent with the specified values for its 
  *  metabolism, vision, stored sugar, and movement rule.
  *
  */
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m) {
    this.m = metabolism;
    this.v = vision;
    this.sl = initialSugar;
    this.mr = m;
    this.age = 0;
    int coin = round(random(1,2));
    if(coin == 1){
      this.sex = 'X';
    }else{
      this.sex = 'Y';
    }
    
    this.culture = new boolean[11];
    for(int i = 0; i<11; i++){
      coin = round(random(1,2));
      if(coin == 1){
        this.culture[i] = true;
      }else{
        this.culture[i] = false;
      }
    }
    
    
  }
  
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m, char gender) {
    if(gender == 'X' || gender == 'Y'){
    this.m = metabolism;
    this.v = vision;
    this.sl = initialSugar;
    this.mr = m;
    this.age = 0;
    this.sex = gender;
    }else{
      assert(1 == 0);
    }
    this.culture = new boolean[11];
    for(int i = 0; i<11; i++){
      int coin = round(random(1,2));
      if(coin == 1){
        this.culture[i] = true;
      }else{
        this.culture[i] = false;
      }
    }
  }
  
  /* returns the amount of food the agent needs to eat each turn to survive. 
  *
  */
  public int getMetabolism(){
    
    return m;
  } 
  
  /* returns the agent's vision radius.
  *
  */
  public int getVision(){
    return v;
  } 
  
  /* returns the amount of stored sugar the agent has right now.
  *
  */
  public int getSugarLevel() {
    return sl;
  } 
  
  public void setSugarLevel(int amount){
    this.sl = amount;
  }
  
  /* returns the Agent's movement rule.
  *
  */
  public MovementRule getMovementRule() {
    return mr;
  } 
  
  
  public int getAge(){
    return age;
  }
  
  public void setAge(int howOld){
    if(howOld<0){
      assert(1 == 0);
    }
   this.age = howOld; 
  }
  
  public char getSex(){
    return this.sex;
  }
  
  public void gift(Agent other, int amount){
    if(this.sl < amount){
      assert(1 == 0);
    }
    this.sl = sl-amount;
    other.setSugarLevel(other.getSugarLevel()+amount);
  }
  
  public void influence(Agent other){
    int argue = round(random(0,10));
    if(this.culture[argue] != other.culture[argue]){
      other.culture[argue] = this.culture[argue];
      //print("One of us, one of us. Gooba-gobble, gooba-gobble")
    }
    }
    
    public void nuture(Agent parent1, Agent parent2){
      for(int i = 0; i<11; i++){
        int coin = round(random(1,2));
        if(coin == 1){
          this.culture[i] = parent1.culture[i];
        }else{
          this.culture[i] = parent2.culture[i];
        }
      }
    }
    
    public boolean getTribe(){
      int trueCount = 0;
      int falseCount = 0;
      for(int i =0; i<11; i++){
        if(this.culture[i] == true){
          trueCount = trueCount+1;
        }
        else if(this.culture[i] == false){
          falseCount = falseCount+1;
        }
      }
      if(trueCount > falseCount){
        return true;
      }
      return false;
    }
    
    
    
    
  
  
  
  /* Moves the agent from source to destination. If the destination is already occupied, the program should crash with an assertion error instead, unless the destination is the same as the source.
  *
  */
  public void move(Square source, Square destination) {
    
    
    if(source != destination){
    if(destination.getAgent() != null){
     assert(0==1); 
    }
    destination.setAgent(this);
    
    source.setAgent(null);
    
  }
    
  }
  
  /* Reduces the agent's stored sugar level by its metabolic rate, to a minimum value of 0.
  *
  */
  public void step() {
    age = age+1;
    sl = sl-m;
    if(sl < 0){
      sl = 0;
    }
  } 
  
  /* returns true if the agent's stored sugar level is greater than 0, false otherwise. 
  * 
  */
  public boolean isAlive() {
    if(sl > 0){
      return true;
    }else{
    return false;
    }
  } 
  
  /* The agent eats all the sugar at Square s. The agents sugar level is increased by that amount, and the amount of sugar on the square is set to 0.
  *
  */
  public void eat(Square s) {
    this.sl = sl + s.getSugar();
    s.setSugar(0);
  } 
  
  /* returns true if this Agent passes all the tests I can think of
  *
  */
  public boolean test() {
    if (getSugarLevel() < 0) return false;
    if (isAlive() && getSugarLevel() == 0) return false;
    // is having no sugar the only way to die?
    
    return true;
  }
  
  
  public void display(int x, int y, int scale){
    fill(0,colors,0);
    ellipse(x, y, (3*scale/4), (3*scale/4));
    
  }
  
  
  public String toString(){
    //String s = Integer.toString(this.getSugarLevel());
    String s = Character.toString(this.sex);
    return s;
  }
  
  public void setColor(int newColor){
    this.colors = newColor;
  }
  //public int getTurn(){
    //return lastTurn;
  //}
  
  //public void setTurn(int turn){
 //   lastTurn = turn;
 // }
  
  
  
  
}