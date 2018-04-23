import java.util.LinkedList;

public interface Mode{
 public SugarGrid build();
 public void replace();
}

public class MigrationDemo implements Mode{
   SugarGrid sg;
   AgentFactory ag;
   MovementRule mr;
   LinkedList<Agent> a;
   ReplacementRule r;
   
   public MigrationDemo(){
   }
   
   public SugarGrid build(){
     
     mr = new SugarSeekingMovementRule();
     sg = new SugarGrid(25,25,20, new SeasonalGrowbackRule(3,0, 50, 12, (25*25)), new PollutionRule(0,0), new SugarSeekingMovementRule());
     sg.addSugarBlob(5,20,1,9);
     sg.addSugarBlob(20,5,1,9);
     ag = new AgentFactory(1, 5, 1, 5, 10, 50, mr);
     a= new LinkedList<Agent>();
     r = new ReplacementRule(5,50, ag);
     
     while(a.size() < 25){
       Agent tempa = ag.makeAgent();
       sg.addAgentAtRandom(tempa);
       a.add(tempa);
     }
     return sg;
     
   }
 
   
   public void replace(){
     for(int i = 0; i<a.size(); i++){
       Agent current = a.get(i);
       if(r.replaceThisOne(current) == true){
         r.replace(current, a);
       }
     }
   }
  
  
  
}




public class PollutionDemo implements Mode{
   SugarGrid sg;
   AgentFactory ag;
   MovementRule mr;
   LinkedList<Agent> a;
   ReplacementRule r;
   
   public PollutionDemo(){
   }
   
   public SugarGrid build(){
     
     mr = new SugarSeekingMovementRule();
     sg = new SugarGrid(25,25,20, new GrowbackRule(1), new PollutionRule(1,1), new PollutionMovementRule());
     sg.addSugarBlob(5,20,1,5);
     sg.addSugarBlob(20,5,1,9);
     ag = new AgentFactory(1, 5, 1, 5, 10, 50, mr);
     a= new LinkedList<Agent>();
     r = new ReplacementRule(5,50, ag);
     
     while(a.size() < 25){
       Agent tempa = ag.makeAgent();
       sg.addAgentAtRandom(tempa);
       a.add(tempa);
     }
     return sg;
     
   }
 
   
   public void replace(){
     for(int i = 0; i<a.size(); i++){
       Agent current = a.get(i);
       if(r.replaceThisOne(current) == true){
         r.replace(current, a);
       }
     }
   }
  
  
  
}


public class FertilityDemo implements Mode{
   SugarGrid sg;
   AgentFactory ag;
   MovementRule mr;
   LinkedList<Agent> a;
   ReplacementRule r;
   FertilityRule fr;
   Map<Character,Integer[]> chilO;
   Map<Character,Integer[]> climO;
   
   
   public FertilityDemo(Map<Character,Integer[]> childbearingOnset, Map<Character,Integer[]> climactericOnset){
     this.chilO = childbearingOnset;
     this.climO = climactericOnset;
   }
   
   public FertilityRule getFR(){
     return fr;
   }
   
   public SugarGrid build(){
     
     mr = new CombatMovementRule(1);
     sg = new SugarGrid(25,25,20, new GrowbackRule(1), new PollutionRule(0,0), new SugarSeekingMovementRule());
     sg.addSugarBlob(5,20,1,9);
     sg.addSugarBlob(20,5,1,9);
     ag = new AgentFactory(1, 10, 1, 5, 50, 100, mr);
     a= new LinkedList<Agent>();
     r = new ReplacementRule(60,100, ag);
     fr = new FertilityRule(chilO, climO);
     
     while(a.size() < 25){
       Agent tempa = ag.makeAgent();
       //if(tempa.getTribe() == true){
       //  tempa.setColor(50);
       //}
       sg.addAgentAtRandom(tempa);
       a.add(tempa);
     }
     return sg;
     /*
     Agent temp1 = ag.makeAgent();
     Agent temp2 = ag.makeAgent();
     Agent temp3 = ag.makeAgent();
     Agent temp4 = ag.makeAgent();
     Agent temp5 = ag.makeAgent();
     Agent temp6 = ag.makeAgent();
     Agent temp7 = ag.makeAgent();
     Agent temp8 = ag.makeAgent();
     Agent temp9 = ag.makeAgent();
     Agent temp10 = ag.makeAgent();
     Agent temp11 = ag.makeAgent();
     Agent temp12 = ag.makeAgent();
     Agent temp13 = ag.makeAgent();
     Agent temp14 = ag.makeAgent();
     Agent temp15 = ag.makeAgent();
     Agent temp16 = ag.makeAgent();
     
     sg.placeAgent(temp1, 5,20);
     sg.placeAgent(temp2, 3,20);
     sg.placeAgent(temp3, 5,23);
     sg.placeAgent(temp4, 5,17);
     sg.placeAgent(temp5, 7,20);
     sg.placeAgent(temp6, 6,20);
     sg.placeAgent(temp7, 4,20);
     sg.placeAgent(temp8, 4,21);
     
     
     sg.placeAgent(temp9,  20,4);
     sg.placeAgent(temp10, 20,2);
     sg.placeAgent(temp11, 23,5);
     sg.placeAgent(temp12, 17,6);
     sg.placeAgent(temp13, 20,7);
     sg.placeAgent(temp14, 20,6);
     sg.placeAgent(temp15, 20,4);
     sg.placeAgent(temp16, 21,4);
     
     
     return sg;*/
   }
 
   
   public void replace(){
    int rowCount = 0;
    int columnCount = 0;
    for(int i = 0; i < 625; i++){
      if(sg.getAgentAt(rowCount, columnCount) != null){
        Agent current = sg.getAgentAt(rowCount, columnCount);
        LinkedList<Square> vision = sg.generateVision(rowCount, columnCount, 1);
        for(int j = 0; j<vision.size(); j++){
          
          Square currentA = vision.get(j);
          int cx = currentA.getX();
          int cy = currentA.getY();
          Agent ca = currentA.getAgent();
          if(ca != null){
            LinkedList<Square> visiona = sg.generateVision(cx, cy, 1);
            if(fr.isFertile(current) && fr.isFertile(ca) && current.getSex() != ca.getSex()){
            Agent baby = fr.breed(current,ca,vision,visiona);
            //if(baby.getTribe() == true){
             //  baby.setColor(255);
             //}
            a.add(baby);
            //println(baby);
            //println(a.size());
            //println(sg.getAgents().size());
            }
          }
            
          }
          if(r.replaceThisOne(current) == true){
            sg.killAgent(rowCount,columnCount);
          }
        }
      
      //handle the math of figuring out positioning
      rowCount = rowCount+1;
      if(rowCount == 25){
        rowCount = 0;
        columnCount = columnCount+1;
      }
    }
   }
       
       
       
       //if(r.replaceThisOne(current) == true){
       //  r.replace(current, a);
       //}
    
  
  
  
  
}

















public class Button{
  int xPos;
  int yPos;
  int xL;
  int yL;
  String type;
  
  
 public Button(int x, int y, int xLength, int yLength, String WhatToSay){
   this.xPos =x;
   this.yPos = y;
   this.xL = xLength;
   this.yL = yLength;
   this.type = WhatToSay;
   
 }
  
 
  public void display(){
    stroke(0);
    strokeWeight(5);
    fill(255);
    rect(xPos,yPos,xL,yL);
    fill(0);
    textSize(25);
    text(type, xPos+(xL/8), yPos+(yL/2));
  }
  
  public boolean pressed(int MouseX, int MouseY){
  if(MouseX >= xPos && MouseX <= xPos+xL && MouseY >= yPos && MouseY <= yPos+yL){
    return true;
  }
  return false;
  }
  
  
}