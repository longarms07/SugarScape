import java.util.LinkedList;
import java.util.Collections;

interface MovementRule{
 public Square move(LinkedList<Square> n, SugarGrid g, Square middle); 
  
}


class SugarSeekingMovementRule implements MovementRule{
  /* The default constructor. For now, does nothing.
  *
  */
  public SugarSeekingMovementRule() {
  }
  
  /* For now, returns the Square containing the most sugar. 
  *  In case of a tie, use the Square that is closest to the middle according 
  *  to g.euclidianDistance(). 
  *  Squares should be considered in a random order (use Collections.shuffle()). 
  */
  public Square move(LinkedList<Square> n, SugarGrid g, Square middle) {
  if(n != null){
    Collections.shuffle(n);
     Square tempMax = null;
     int tmax = -1;
     
     //stay still if all sugar levels are the same
     int sl = -1;
     boolean same = true;
     for(int j = 0; j < n.size(); j++){
      Square current = n.get(j);
      if(sl == -1){
        sl = current.getSugar();
      }else if(current.getSugar() != sl){
        same = false;
      }
     }
     if(same == true){
       return middle;
     }
      
      
    for(int i = 0; i < n.size(); i++){
      Square current = n.get(i);
      int currents = current.getSugar();
      if(tempMax == null){
        tempMax = current;
        tmax = current.getSugar();
      }else if(tmax < currents){
        tempMax = current;
        tmax = currents;
      }else if(tmax == currents){
        double temped = g.euclidianDistance(middle, tempMax);
        double currented = g.euclidianDistance(middle, current);
        if(temped <= currented){
          tempMax = current;
        }
      }
      
      
    }
    return tempMax;
  } 
  assert(0 == 1);
  return null;
  }

}



public class PollutionMovementRule implements MovementRule{
  
 public PollutionMovementRule(){
 }
 
 public Square move(LinkedList<Square> n, SugarGrid g, Square middle) {
  if(n != null){
    Collections.shuffle(n);
     Square tempMax = null;
     int tmax = -1;
     int tempp = -1;
     
     
     int sl = -1;
     boolean same = true;
     for(int j = 0; j < n.size(); j++){
      Square current = n.get(j);
      if(sl == -1){
        sl = current.getSugar();
      }else if(current.getSugar() != sl){
        same = false;
      }
     }
     if(same == true){
       return middle;
     }
     
    for(int i = 0; i < n.size(); i++){
      Square current = n.get(i);
      int currents = current.getSugar();
      int currentp = current.getPollution();
      if(tempMax == null){
        tempMax = current;
        tmax = current.getSugar();
        tempp = current.getPollution();
        //println("start " +tmax + " "+tempp+" "+currents+" "+currentp);
      }//else if((tmax != 0 && currents != 0 && tempp/tmax < currentp/currents) 
                //|| (tempp == 0 && currentp != 0)){
        else if(tempp != 0 && currentp== 0 || tempp != 0 &&(
                    tempp > currentp && tmax <= currents ||  tmax < tempp && currents > currentp 
                   ||tmax >= tempp  && currents >= currentp && tmax-tempp < currents-currentp)){ 
        //println("new current = "+tmax + " "+tempp+" "+currents+" "+currentp);
        tempMax = current;
        tmax = currents;
        tempp = currentp;
      }//else if(tmax != 0 && currents != 0 && tempp/tmax == currentp/currents){
        else if(tempp != 0 && (tmax > tempp && currents > currentp && tmax-tempp == currents-currentp)){
        double temped = g.euclidianDistance(middle, tempMax);
        double currented = g.euclidianDistance(middle, current);
        //println("new current = "+tmax + " "+tempp+" "+currents+" "+currentp);
        if(temped <= currented){
          tempMax = current;
          tmax = currents;
          tempp = currentp;
        }
      }else{
      //println(tmax + " "+tempp+" "+currents+" "+currentp);
      }
      
    }
    return tempMax;
  } 
  assert(0 == 1);
  return null;
  }
  
}




class CombatMovementRule extends SugarSeekingMovementRule{
  
  int alpha;
  
  public CombatMovementRule(int alf){
    this.alpha = alf;
  }
  
  
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle){
    Agent midAgent = middle.getAgent();
    boolean midTribe = midAgent.getTribe();
    LinkedList<Integer> toRemove = new LinkedList<Integer>();
    boolean seesAgent = false;
    
    //remove squares from neighbourhood if they have the >= sl or same tribe
    for(int i = 0; i<neighbourhood.size();i++){
      Square current = neighbourhood.get(i);
      if(current.getAgent() != null){
        seesAgent = true;
        Agent currentA = current.getAgent();
        if(currentA.getTribe() == midTribe){
          toRemove.add(i);
        }else if(currentA.getSugarLevel() >= midAgent.getSugarLevel()){
         toRemove.add(i); 
        }
      }
    }
    
    if(seesAgent == false){
     return super.move(neighbourhood, g, middle);
    }
    
    while(toRemove.size() > 0){
      neighbourhood.remove(toRemove.remove());
    }
    if(neighbourhood.size() == 0){ //just in case
      return middle;
    }
    
    
    //get the vision for the Agent on middle if it had moved to that square. If the vision contains any agent with more sugar than the middle on the opposite tribe remove it
    for(int j = 0; j < neighbourhood.size();j++){
      Square current = neighbourhood.get(j);
      LinkedList<Square> temp = g.generateVision(current.getX(), current.getY(), midAgent.getVision());
      
      for(int k = 0; k<temp.size(); k++){
        Square current2 = temp.get(k);
        if(current2.getAgent() != null){
          Agent currentA = current2.getAgent();
            if(currentA.getTribe() != midTribe){
               if(currentA.getSugarLevel() > midAgent.getSugarLevel()){
               toRemove.add(j); 
               k = temp.size();
            }
          }
        }
      }
    }
    
    while(toRemove.size() > 0){
      neighbourhood.remove(toRemove.remove());
    }
    
    
    if(neighbourhood.size() == 0){ //just in case
      return middle;
    }
    
    //replace the square with a new one
    LinkedList<Square> nClone = new LinkedList<Square>();
    for(int l = 0; l<neighbourhood.size();l++){
      Square current = neighbourhood.get(l);
      if(current.getAgent() == null){
        nClone.add(current);
      }else{
        Square sClone = new Square((current.getSugar()+alpha+current.getAgent().getSugarLevel()), current.getMaxSugar()+alpha+current.getAgent().getSugarLevel(), current.getX(), current.getY());
        nClone.add(sClone);
      }
    }
    
    
    Square tempTarget = super.move(nClone, g, middle);
    if(tempTarget.getX() == middle.getX() && tempTarget.getY() == middle.getY()){
      
      return middle;
    }
    
    Square target = null;
    for(int m = 0; m<neighbourhood.size(); m++){
      Square current = neighbourhood.get(m);
      if(tempTarget.getX() == current.getX() && tempTarget.getY() == current.getY()){
        target = current;
        m = neighbourhood.size();
      }
    }
      
      if(target.getAgent() == null){
        
        return target;
      }
    
      
      Agent casualty = target.getAgent();
      midAgent.setSugarLevel(midAgent.getSugarLevel()+alpha+casualty.getSugarLevel());
      g.killAgent(target.getX(), target.getY());
      //midAgent.sugarLevel = (midAgent.getSugarLevel()+alpha+casualty.getSugarLevel());
      //g.killAgent(casualty);
      ///println("Attack!!!");
      return target;
  }
  
  
  
}