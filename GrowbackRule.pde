public interface GrowthRule{
  public void growBack(Square s);
  
}





class GrowbackRule implements GrowthRule{
 private int rate;
 
 public GrowbackRule(int r){
   this.rate = r;
   
   
  
 }
  
  public void growBack(Square s){
    int max = s.getMaxSugar();
    int current = s.getSugar();
    if((current + rate) <= max){ //if the current sugar + the rate is less than or equal to the max
      s.setSugar(current+rate);
    }else if(current == max){ //if current = the max don't do anything
      s.setSugar(current);
    }else{ //else make the sugar equal to the max
     s.setSugar(current + (max-current)); 
    }
    
    
  }
  
}



public class SeasonalGrowbackRule implements GrowthRule{
  int summerS;
  int winterS;
  int seasonLength;
  int equator;
  String currentSummer = "north";
  int counter = 0;
  
  
  
  public SeasonalGrowbackRule(int alpha, int beta, int gamma, int equatorz, int numSquares){
    this.summerS = alpha;
    this.winterS = beta;
    this.seasonLength = gamma*numSquares;
    this.equator = equatorz;
  }
  
  
  public void growBack(Square s){
    String pos;
    if(s.getY() <= equator){
      pos = "north";
    }else{
      pos = "south";
    }
    if(currentSummer.equals(pos)){
      s.setSugar(s.getSugar() + summerS);
    }else{
      s.setSugar(s.getSugar() + winterS);
    }
    counter = counter+1;
    //println(counter);
    if(counter == seasonLength){
      counter = 0;
      if(currentSummer == "north"){
        currentSummer = "south";
      }else if(currentSummer == "south"){
        currentSummer = "north";
      }
    }
    
    
    
    
    
  }
  
  public boolean isNorthSummer(){
    if(currentSummer == "north"){
      return true;
    }
    return false;
  }
  
  
  
  
  
  
}