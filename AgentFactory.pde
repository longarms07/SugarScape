class AgentFactory{
  
  int minM;
  int maxM;
  int minV;
  int maxV;
  int minS;
  int maxS;
  MovementRule m;
  
  
  public AgentFactory(int minMetabolism, int maxMetabolism, int minVision, int maxVision, 
                      int minInitialSugar, int maxInitialSugar, MovementRule mr){
          this.minM = minMetabolism;
          this.maxM = maxMetabolism;
          this.minV = minVision;
          this.maxV = maxVision;
          this.minS = minInitialSugar;
          this.maxS = maxInitialSugar;
          this.m = mr;            
    
    
  }
  
  int met;
  int v;
  int is;
  
  
  public Agent makeAgent(){
 
       met = round(random(minM, maxM));
    v = round(random(minV, maxV));
    is = round(random(minS, maxS));
    
    Agent a = new Agent(met, v, is, m);
    return a;
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
}