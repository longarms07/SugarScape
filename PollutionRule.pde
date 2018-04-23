

public class PollutionRule{
  
  int gp;
  int ep;
  
  
  public PollutionRule(int gatheringPollution, int eatingPollution){
    this.gp = gatheringPollution;
    this.ep = eatingPollution;
  }
  
  public void pollute(Square s){
    if(s.getAgent() != null){
      s.setPollution(s.getPollution() + s.getAgent().getMetabolism()*ep /*+ s.getSugar()*gp*/);                 
      s.setOldPollution();
  }
    
  }
  
  
  
  
  
  
  
  
}