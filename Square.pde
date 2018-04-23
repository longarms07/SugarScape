class Square{
  
  int xPos =0;
  int yPos=0;
  int slv=0;
  int mslv=0;
  int pollution = 0;
  int oldPollution = 0;
  //MovementRule m = new SugarSeekingMovementRule();
  Agent occupant = null; 
  
  
  public Square(int sugarLevel, int maxSugarLevel, int x, int y){
  this.xPos = x;
  this.yPos = y;
  this.slv = sugarLevel;
  this.mslv = maxSugarLevel;
  

    
  }
  
  public int getX(){
    return xPos; 
  }
  
  public int getY(){
    return yPos; 
  }
  
  public int getSugar(){
  return slv; 
  }
  
  public int getMaxSugar(){
  return mslv; 
  }
  
  public void setSugar(int desiredAmount){
    if(desiredAmount > 0 && desiredAmount <= mslv){
     slv = desiredAmount; 
    }else if(desiredAmount >= mslv){
     slv = mslv; 
    }else{
      slv = 0;
    }
  }
  
  public void setMaxSugar(int desiredAmount){
    if(desiredAmount > 0){
     mslv = desiredAmount; 
    }else{
      mslv = 0;
    }
    if(slv > mslv){
      slv = mslv;
    }
  }

  public Agent getAgent(){
    return occupant; 
    //return null
  }
  
  public void setAgent(Agent a){
    if(this.occupant == null && a == null || occupant == a){
      assert((1==0)); //crash
    }else{
      occupant = a;
    }
  }
  
    public void display(int size){
      //stroke(255,0,0);
      strokeWeight(0);
      fill(255, 255- pollution/3.0*255, 255 - slv/6.0*255);
      rect(size*xPos, size*yPos, size, size);
      
  
     if(this.getAgent() != null){
       this.getAgent().display((size*xPos+size/2), (size*yPos + size/2), size);
     } 
  
    }
    
    public String toString(){
     String temp = ("("+this.xPos+","+this.yPos+")");
     return temp;
    }
  
  
  
  
  public int getPollution(){
    return this.pollution;
  }
  
  public int getOldPollution(){
    return this.oldPollution;
  }
  
  public void setOldPollution(){
    this.oldPollution = pollution;
  }
  
  public void setPollution(int level){
    this.pollution = level;
  }
  
  
  
  
  
  
}