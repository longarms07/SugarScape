import java.util.Map;
import java.util.List;

public class FertilityRule{
  
  Map<Character, Integer[]> fertilityStartAges;
  Map<Character, Integer[]> fertilityEndAges;
  Map<Agent, Integer[]> AgentAges;
  
  public FertilityRule(Map<Character, Integer[]> childbearingOnset, 
                      Map<Character, Integer[]> climactericOnset){
        this.fertilityStartAges = childbearingOnset;
        this.fertilityEndAges = climactericOnset;
        this.AgentAges = new HashMap<Agent, Integer[]>();
  }
  
  public boolean isFertile(Agent a){
    //check if a is alive or dead
    if(a == null){  
      return false;
    }
    if(a.isAlive() == false){
      if(AgentAges.containsKey(a) == true){
        AgentAges.remove(a);
      }
      
      return false;
    }
    //check if this is the first time a has been passed to here
    if(AgentAges.containsKey(a) == false){
      char gender = a.getSex();
      Integer[] cbages = fertilityStartAges.get(gender);
      int c = round(random(cbages[0], cbages[1])); //get random childbearing age
      
      Integer[] climages = fertilityEndAges.get(gender);
      int o = round(random(climages[0], climages[1])); //get random climacteric age
      //println(climages[0]);
      Integer[] aAges = new Integer[3]; //store both ages and sugar level for agent
      aAges[0] = c;
      aAges[1] = o;
      aAges[2] = a.getSugarLevel(); //sugar level
      AgentAges.put(a, aAges); //put it in the hash map
    }
    
    //check if fertile
    Integer[] current = AgentAges.get(a);
    if(current[0] <= a.getAge() && a.getAge() < current[1] 
        && a.getSugarLevel() >= current[2]){
      return true;
    }
    //println(a.getAge() + " " + current[0] + " " + current[1] + " " + a.getSugarLevel() + " "+ current[1]);
    return false;
  }
  
  public boolean canBreed(Agent a, Agent b, LinkedList<Square> local){
    if(this.isFertile(a) != true || this.isFertile(b) != true || a.getSex() == b.getSex()){
      
      return false;
    }
    boolean containsB = false;
    boolean empty = false;
    for(int i = 0; i<local.size(); i++){
      Square current = local.get(i);
      if(current.getAgent() != null){
       // println(current.getAgent() +" "+ b);
        //print(current.getAgent().equals(b));
      }
      if(current.getAgent() == null){
        empty = true;
      }
      else if(current.getAgent().equals(b)){
        containsB = true;
      }
    }
    if(containsB == true && empty == true){
      return true;
    }
    //print("here");
    
    return false;
  }
  
  
  public Agent breed(Agent a, Agent b, LinkedList<Square> alocal, LinkedList<Square> blocal){
    if(this.canBreed(a,b,alocal) == false && this.canBreed(b,a,blocal) == false){ //check can breed
      //print("here");
      return null;
    } 
    //println("breeding");
    
    int coin = round(random(1,2));
    int metabolism;
    int vision;
    if(coin == 1){ //set baby metabolism
      metabolism = a.getMetabolism();
    }else{
      metabolism = b.getMetabolism();
    }
    coin = round(random(1,2));
    if(coin == 1){ //set baby vision
      vision = a.getVision();
    }else{
      vision = b.getVision();
    }
    
    MovementRule babyMR = a.getMovementRule();
    char sex;
    
     coin = round(random(1,2));
     //print(coin);
    if(coin == 1){ //set baby gender
      sex = 'X';
    }else{
      sex = 'Y';
    }
    
    
    
    Collections.shuffle(alocal);
    Collections.shuffle(blocal);
    
    LinkedList<Square> toUse = new LinkedList<Square>();
    
      if( this.canBreed(a,b,alocal) == true){ //choose which local
        toUse = alocal;
      }else if( this.canBreed(b,a,blocal) == true){
        toUse = blocal;
      }
        else{
          assert(1 == 0);
      }
    Agent baby = new Agent(metabolism,vision,0,babyMR, sex);
    a.gift(baby, (a.getSugarLevel()/2)); //make the baby and ahve parents give it gifts
    b.gift(baby, (b.getSugarLevel()/2));
    
    for(int i = 0; i<toUse.size(); i++){
      Square current = toUse.get(i);
      //print(current);
      if(current.getAgent() == null){
        //println(current);
        current.setAgent(baby);
        i = toUse.size();
      }
    }
    assert(baby != null);
    //print(baby);
    baby.nuture(a,b);
    return baby;
  }
                        
                        
                        
                        
  
  
  
  
  
  
 
  
  
  
  
  
  
  
  
}