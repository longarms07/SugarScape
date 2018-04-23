import java.util.LinkedList;
import java.util.Map;

/*
SugarGrid sg;
LinkedList<Agent> agents = new LinkedList<Agent>();
FertilityRule fr;
  
void setup(){
  size(200,200);
  sg = new SugarGrid(10,10,10, new GrowbackRule(1), new PollutionRule(0,0), new SugarSeekingMovementRule()); 
  Agent a = new Agent(1,0,50000, new SugarSeekingMovementRule(), 'X');
  Agent b = new Agent(1,0,50000, new SugarSeekingMovementRule(), 'Y');
  agents.add(a);
  agents.add(b);
  sg.placeAgent(a, 2,2);
  sg.placeAgent(b, 2,3);
  //sg.addSugarBlob(2,2, 5,50000);
  
  Map<Character,Integer[]> chilO = new HashMap<Character,Integer[]>();
   Map<Character,Integer[]> climO = new HashMap<Character,Integer[]>();
   
   
   
   Integer[] chilOX = new Integer[2];
   chilOX[0] = 0;
   chilOX[1] = 0;
   chilO.put('X', chilOX);
   Integer[] chilOY = new Integer[2];
   chilOY[0] = 0;
   chilOY[1] = 0;
   chilO.put('Y', chilOY);
   
   
   Integer[] climOX = new Integer[2];
   climOX[0] = 30000;
   climOX[1] = 40;
   climO.put('X', climOX);
   Integer[] climOY = new Integer[2];
   climOY[0] = 40;
   climOY[1] = 50000;
   climO.put('Y', climOY);
  
   fr = new FertilityRule(chilO, climO);
   
   sg.display();
   frameRate(2);
}

void draw(){
 background(255);
 //print("go");
 for(int o = 0; o<agents.size(); o++){
  agents.get(o).setSugarLevel(500000);
 }
 for(int i = 0; i < agents.size()-1; i++){
   //print("here");
   
   Agent a = agents.get(i);
   Agent b = agents.get(i+1);
   //println(a + "," + b);
   LinkedList<Square> visionA = new LinkedList<Square>();
   LinkedList<Square> visionB = new LinkedList<Square>();
   int rowCount = 0;
   int columnCount = 0;
   for(int j = 0; j < 100; j++){
     if(sg.getAgentAt(rowCount,columnCount) != null){
       Agent current = sg.getAgentAt(rowCount,columnCount);
       if(current.equals(a)){
         visionA = sg.generateVision(rowCount,columnCount,1);
       }
       if(current.equals(b)){
         visionB = sg.generateVision(rowCount,columnCount,1);
       }
     }
     rowCount = rowCount+1;
     if(rowCount == 10){
       rowCount = 0;
       columnCount = columnCount+1;
   }
   }
  //println(a + "," + b +  "breed");
   Agent baby = fr.breed(a,b, visionA, visionB);
   
   if(baby != null){
     println(baby);
   agents.add(baby);
   }
 }
  
  sg.display();
  println(agents.size());
  //print(sg.getAgents());
  
}*/



Mode m;
SugarGrid sg;
Button one;
Button two;
Button three;
String state;
Graph ag;

void setup(){
  

  size(1000,600);
    background(255);
    one = new Button(0,500,150,100, "III-3");
    one.display();
    two = new Button(150,500,150,100, "III-4");
    two.display();
    three = new Button(300,500,150,100, "III-5");
    three.display();
    ag = new Graph(525,0,450,275, "", "");
    state = "wait";
  frameRate(2);
  
}

void draw(){
  if(state != "wait"){
  m.replace();
  sg.update();
  
  //background(255);
  
  sg.display();
  
  one.display();
  two.display();
  three.display();
  ag.update(sg);
  //println(sg.getAgents().size());
  }
}

void mousePressed(){
  //print(one.pressed(mouseX,mouseY));
  if(one.pressed(mouseX, mouseY) == true){
    state = "wait";
    
    Map<Character,Integer[]> chilO = new HashMap<Character,Integer[]>();
   Map<Character,Integer[]> climO = new HashMap<Character,Integer[]>();
   
   
   
   Integer[] chilOX = new Integer[2];
   chilOX[0] = 12;
   chilOX[1] = 15;
   chilO.put('X', chilOX);
   Integer[] chilOY = new Integer[2];
   chilOY[0] = 12;
   chilOY[1] = 15;
   chilO.put('Y', chilOY);
   
   
   Integer[] climOX = new Integer[2];
   climOX[0] = 30;
   climOX[1] = 40;
   climO.put('X', climOX);
   Integer[] climOY = new Integer[2];
   climOY[0] = 40;
   climOY[1] = 50;
   climO.put('Y', climOY);
   //println(climO);
    m = new FertilityDemo(chilO,climO);
    
    
    
    
    sg = m.build();
    sg.display();
    ag = new AgentGraph(525,0,450,275, "time", "Agents Alive");
    
    ag.update(sg);
    state = "one";
  }
  if(two.pressed(mouseX, mouseY) == true){
    state = "wait";
    
    
    
    
    
    
    Map<Character,Integer[]> chilO = new HashMap<Character,Integer[]>();
   Map<Character,Integer[]> climO = new HashMap<Character,Integer[]>();
   
   
   
   Integer[] chilOX = new Integer[2];
   chilOX[0] = 12;
   chilOX[1] = 15;
   chilO.put('X', chilOX);
   Integer[] chilOY = new Integer[2];
   chilOY[0] = 12;
   chilOY[1] = 15;
   chilO.put('Y', chilOY);
   
   
   Integer[] climOX = new Integer[2];
   climOX[0] = 50;
   climOX[1] = 60;
   climO.put('X', climOX);
   Integer[] climOY = new Integer[2];
   climOY[0] = 50;
   climOY[1] = 60;
   climO.put('Y', climOY);
    //println(climO);
    m = new FertilityDemo(chilO,climO);
    
    
    
    sg = m.build();
    sg.display();
    ag = new AgentGraph(525,0,450,275, "time", "Agents Alive");
    
    ag.update(sg);
    state = "two";
  }
   if(three.pressed(mouseX, mouseY) == true){
    state = "wait";
    
    
    
    Map<Character,Integer[]> chilO = new HashMap<Character,Integer[]>();
   Map<Character,Integer[]> climO = new HashMap<Character,Integer[]>();
   
   
   
   Integer[] chilOX = new Integer[2];
   chilOX[0] = 12;
   chilOX[1] = 15;
   chilO.put('X', chilOX);
   Integer[] chilOY = new Integer[2];
   chilOY[0] = 12;
   chilOY[1] = 15;
   chilO.put('Y', chilOY);
   
   
   Integer[] climOX = new Integer[2];
   climOX[0] = 50;
   climOX[1] = 60;
   climO.put('X', climOX);
   Integer[] climOY = new Integer[2];
   climOY[0] = 50;
   climOY[1] = 60;
   climO.put('Y', climOY);
   //println(climO);
    m = new FertilityDemo(chilO,climO);
    
    
    
    
    sg = m.build();
    sg.display();
    ag = new AgentGraph(525,0,450,275, "time", "Agents Alive");
    
    ag.update(sg);
    state = "three";
  }
  
  
}













/*void setup() {
  SquareTester st = new SquareTester();
  st.test();  
  GRBTest gt = new GRBTest();
  gt.test();
  SGTest sg = new SGTest();
  sg.test();
  MRTest mr = new MRTest();
  mr.test();
  ATest a = new ATest();
  a.test();
  AFTest af = new AFTest();
  af.test();
  RRTester rrt = new RRTester();
  rrt.test();
  PRTester prt = new PRTester();
  prt.test();
  fill(0,255,0);
  noStroke();
  ellipse(50, 50, 50,50);
}*/
  /*
  SugarGrid myGrid;
  void setup(){

  size(1000,800);
  myGrid = new SugarGrid(50,40,20, new SeasonalGrowbackRule(3,0, 80, 12, (50*40)), new PollutionRule(0,0), new SugarSeekingMovementRule());
  myGrid.addSugarBlob(10,10,1,8);
  Agent ag = new Agent(1,1,50, new PollutionMovementRule());
  myGrid.addAgentAtRandom(ag);
  myGrid.display();
  frameRate(2);

}

void draw(){
  myGrid.update();
  background(255);
  myGrid.display();
} */