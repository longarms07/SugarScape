import java.util.List;
import java.util.HashMap;

public class ReplacementRule{
  
  int minA;
  int maxA;
  AgentFactory af;
  //List<Helper> list = new LinkedList<Helper>();
  HashMap<Agent,Integer> list = new HashMap<Agent,Integer>(); 
  
  ReplacementRule(int minAge, int maxAge, AgentFactory fac){
    this.minA = minAge;
    this.maxA = maxAge;
    this.af = fac;
  }
  
  public boolean replaceThisOne(Agent a){
   //check if a is in list
   if(list.containsKey(a) == false){ //if a is not in the list add it
    int life = round(random(minA, maxA));
    //Helper temp = new Helper(a, life); 
    //list.add(temp);
    list.put(a, life);
   }
   //int i = 0;
   if(a.isAlive() == false){
     return true;
   }
   //check if lifespan is less than age
   if(list.get(a) < a.getAge()){ //if it is, set the age +1 and return true
     a.setAge(a.getAge() + 1);
     return true;
   }
   return false;
  }
   
   /*
   Helper current;
   Helper thisOne;
   while(i < list.size()){
    current = list.get(i);
    i= i+1;
    if(current.getAgent() == a){
      thisOne = current;
      if(thisOne.getLifespan() < a.getAge()){
         a.setAge(a.getAge() + 1);
         return true;
      }else{
        return false;
      }
    }
   }*/
  
  
  
  public Agent replace(Agent a, List<Agent> others){
    Agent newA = af.makeAgent();
    return newA;
  }
  
  
  
  
}



public class Helper{
 int lifespan;
 Agent a;
  
 Helper(Agent aa, int life){
   this.lifespan = life;
   this.a = aa;
 }
 
 public Agent getAgent(){
   return a;
 }
 
 public int getLifespan(){
   return lifespan;
 }
 
 
  
}