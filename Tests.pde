import java.util.LinkedList;
import java.util.List;


class SquareTester {
  void test() {
    Square s = new Square(5, 9, 50, 50); // square with sugarLevel 5, maxSugarLevel 9, position (x, y) = (50, 50)
    assert (s.getSugar() <= s.getMaxSugar());
    assert (s.getSugar() == 5);
  }
}


  
  
class GRBTest{
  void test(){
    Square s = new Square(5, 9, 50, 50);
    GrowbackRule g = new GrowbackRule(3);
    g.growBack(s);
    assert(s.getSugar() == 8);
    g.growBack(s);
    assert(s.getSugar() == 9);
    g.growBack(s);
    assert(s.getSugar() == 9);
    
    
    SeasonalGrowbackRule sg = new SeasonalGrowbackRule(3,1,1, 2, 6);  
    Square s1 = new Square(1, 9, 1, 1);
    Square s2 = new Square(1, 9, 2, 1);
    Square s3 = new Square(1, 9, 1, 2);
    Square s4 = new Square(1, 9, 2, 2);
    Square s5 = new Square(1, 9, 1, 3);
    Square s6 = new Square(1, 9, 2, 3);
    assert(sg.isNorthSummer() == true);
    sg.growBack(s1);
    sg.growBack(s2);
    sg.growBack(s3);
    sg.growBack(s4);
    sg.growBack(s5);
    sg.growBack(s6);
    assert(s1.getSugar() == 4);
    assert(s2.getSugar() == 4);
    assert(s3.getSugar() == 4);
    assert(s4.getSugar() == 4);
    assert(s5.getSugar() == 2);
    assert(s6.getSugar() == 2);
    assert(sg.isNorthSummer() == false);
    sg.growBack(s1);
    sg.growBack(s2);
    sg.growBack(s3);
    sg.growBack(s4);
    sg.growBack(s5);
    sg.growBack(s6);
    assert(s1.getSugar() == 5);
    assert(s2.getSugar() == 5);
    assert(s3.getSugar() == 5);
    assert(s4.getSugar() == 5);
    assert(s5.getSugar() == 5);
    assert(s6.getSugar() == 5);
    assert(sg.isNorthSummer() == true);
  }
  
  
  
  
}


class SGTest{
  
 void test(){
   GrowthRule g = new GrowbackRule(1);
 
  SugarGrid sg = new SugarGrid(10,10,1,g, new PollutionRule(0,0), new SugarSeekingMovementRule()); 
   assert(sg.grid.size() == 100);
   assert(sg.getWidth() == 10);
   assert(sg.getHeight() == 10);
   assert(sg.getSquareSize() == 1);
   assert(sg.getSugarAt(3,9) == 0);
   assert(sg.getMaxSugarAt(1,5) == 0);
   assert(sg.getAgentAt(8,4) == null);
   
   assert(sg.euclidianDistance(sg.grid.get(1),sg.grid.get(2)) == 1);
   assert(sg.euclidianDistance(sg.grid.get(9),sg.grid.get(99)) == 1);
     
   sg.addSugarBlob(4,4, 1, 3);
   assert(sg.grid.get(44).getMaxSugar() == 3);
   assert(sg.grid.get(44).getSugar() == 3);
   assert(sg.grid.get(34).getMaxSugar() == 2);
   assert(sg.grid.get(54).getSugar() == 2);
   assert(sg.grid.get(33).getMaxSugar() == 2);
   assert(sg.grid.get(56).getMaxSugar() == 1);
   assert(sg.grid.get(42).getMaxSugar() == 1);
   assert(sg.grid.get(46).getSugar() == 1);
   
   
   LinkedList<Square> o = sg.generateVision(5,5,2);
   println(o);
   LinkedList<Square> n = sg.generateVision(5,11,2);
   println(n);
   LinkedList<Square> q = sg.generateVision(5,5,0);
   println(q);
  
   
     
 }
}

class MRTest{
  void test(){
  GrowthRule g = new GrowbackRule(1);
  SugarGrid sg = new SugarGrid(10,10,1,g,new PollutionRule(0,0), new SugarSeekingMovementRule()); 
  LinkedList<Square> q = sg.generateVision(5,5,2);
  Square h = sg.grid.get(55);   
  MovementRule m = new SugarSeekingMovementRule();
  Square mm = m.move(q, sg, h);
  println(mm);
  LinkedList<Square> z = sg.generateVision(5,5,0);
  Square mn = m.move(z, sg, h);
  println(mn);
}
}

class ATest{
 void test(){
  MovementRule m = new SugarSeekingMovementRule();
  Agent a = new Agent(2,3,3, m);
  GrowthRule g = new GrowbackRule(1);
  SugarGrid sg = new SugarGrid(10,10,1,g,new PollutionRule(0,0), new SugarSeekingMovementRule()); 
  assert(a.getMetabolism() == 2);
  assert(a.getVision() == 3);
  assert(a.getSugarLevel() == 3);
  assert(a.getMovementRule() == m);
  
  assert(a.getAge() == 0);
  a.setAge(3);
  assert(a.getAge() == 3);
  a.setAge(0);
  
  sg.grid.get(55).setAgent(a);
  assert(sg.grid.get(55).getAgent() == a);
  a.move(sg.grid.get(55), sg.grid.get(54));
  assert(sg.grid.get(54).getAgent() == a);
  assert(sg.grid.get(55).getAgent() == null); 
   
  a.step();
  assert(a.getSugarLevel() == 1);
  assert(a.isAlive());
  assert(a.getAge() == 1);
  a.step();
  assert(a.getSugarLevel() == 0);
  assert(a.getAge() == 2);
  assert(a.isAlive() == false);
  
  
  a.sl = 3;
  assert(a.isAlive());
  
  sg.grid.get(54).setMaxSugar(5);
  sg.grid.get(54).setSugar(5);
  a.eat(sg.grid.get(54));
  assert(sg.grid.get(54).getSugar() == 0);
  assert(a.getSugarLevel() == 8);
  
 }
  
  
}


class AFTest{
  void test(){
    MovementRule m = new SugarSeekingMovementRule();
    AgentFactory AF = new AgentFactory(1, 5, 1, 3, 1,5, m);
    Agent a = AF.makeAgent();
    assert(a.getMetabolism() >= 1);
    assert(a.getMetabolism() <= 5);
    assert(a.getVision() >= 1);
    assert(a.getVision() <= 3);
    assert(a.getSugarLevel() >= 1);
    assert(a.getSugarLevel() <= 5);
    print(a.getMetabolism() + ",");
    print(a.getVision() + ",");
    println(a.getSugarLevel());
    
     Agent b = AF.makeAgent();
    assert(b.getMetabolism() >= 1);
    assert(b.getMetabolism() <= 5);
    assert(b.getVision() >= 1);
    assert(b.getVision() <= 3);
    assert(b.getSugarLevel() >= 1);
    assert(b.getSugarLevel() <= 5);
    print(b.getMetabolism() + ",");
    print(b.getVision() + ",");
    println(b.getSugarLevel());
    
    
    
    
    
    
    
    
    
    
    
  }
}


/*class RRTester{
  void test(){
    int minAge = 2;
    int maxAge = 10;
    MovementRule m = new SugarSeekingMovementRule();
    AgentFactory fac = new AgentFactory(1, 5, 1, 3, 1,5, m);
    Agent a = fac.makeAgent();
    
    
    ReplacementRule r = new ReplacementRule(minAge, maxAge, fac);
    
    assert(r.replaceThisOne(a) == false);
      //Helper h = r.list.get(0);
      //int deathAge = h.getLifespan();
      a.setAge(deathAge+1);
    assert(r.replaceThisOne(a) == true);
    assert(a.getAge() == deathAge+2);
    List<Agent> others = new LinkedList<Agent>();
    Agent tempA = a;
    a = r.replace(a, others);
    print(tempA.getMetabolism() + ",");
    print(tempA.getVision() + ",");
    println(tempA.getSugarLevel());
    print(a.getMetabolism() + ",");
    print(a.getVision() + ",");
    println(a.getSugarLevel());
  }
}*/


public class PRTester{
  void test(){
    Square s = new Square(1,9,11,11);
    assert(s.getPollution() == 0);
    MovementRule m = new PollutionMovementRule();
    AgentFactory fac = new AgentFactory(1, 1, 1, 1, 2,2, m);
    Agent a = fac.makeAgent();
    s.setAgent(a);
    PollutionRule p = new PollutionRule(1,1);
    
    p.pollute(s);
    println(a.getMetabolism());
    println(s.getPollution());
    assert(s.getPollution() == a.getMetabolism() + s.getSugar());
    int currentP = s.getPollution();
    s.setSugar(5);
    p.pollute(s);
    assert(s.getPollution() == currentP + a.getMetabolism() + s.getSugar());
    
   GrowthRule g = new GrowbackRule(1);
   SugarGrid sg = new SugarGrid(10,10,1,g,new PollutionRule(0,0), new SugarSeekingMovementRule()); 
   s.setAgent(null);
   sg.grid.get(5).setAgent(a);
   sg.grid.get(4).setPollution(5);
   sg.grid.get(6).setPollution(5);
   sg.grid.get(15).setPollution(4);
   sg.grid.get(95).setPollution(89);
   LinkedList<Square> z = sg.generateVision(5,0,1);
   Square mn = m.move(z, sg, s);
   assert(mn == sg.grid.get(15));
   mn = sg.grid.get(5);
   sg.grid.get(4).setMaxSugar(5);
   sg.grid.get(6).setMaxSugar(5);
   sg.grid.get(15).setMaxSugar(0);
   sg.grid.get(95).setMaxSugar(900);
   sg.grid.get(4).setSugar(5);
   sg.grid.get(6).setSugar(5);
   sg.grid.get(15).setSugar(0);
   sg.grid.get(95).setSugar(900);
   LinkedList<Square> z2 = sg.generateVision(5,0,1);
   mn = m.move(z2, sg, s);
   assert(mn == sg.grid.get(95));
   //print(mn);
  } 
}





public class SortTester{
  public void test(){
    Sorter b = new MergeSorter();
    //Sorter b = new InsertionSorter();
    ArrayList<Agent> o = new ArrayList<Agent>();
    b.sort(o);
    ArrayList<Agent> a = new ArrayList<Agent>();
      MovementRule mm = new SugarSeekingMovementRule();
      a.add(new Agent(0,0,4,mm));
      a.add(new Agent(0,0,1,mm));
      a.add(new Agent(0,0,5,mm));
      a.add(new Agent(0,0,2,mm));
      a.add(new Agent(0,0,3,mm));
    b.sort(a);
    ArrayList<Agent> a2 = new ArrayList<Agent>();
      a2.add(new Agent(0,0,1000,mm));
      a2.add(new Agent(0,0,8,mm));
      a2.add(new Agent(0,0,70,mm));
      a2.add(new Agent(0,0,25,mm));
      a2.add(new Agent(0,0,31,mm));
      a2.add(new Agent(0,0,89,mm));
    b.sort(a2);
    ArrayList<Agent> a3 = new ArrayList<Agent>();
      a3.add(new Agent(0,0,100,mm));
    b.sort(a3);
 ArrayList<Agent> a4 = new ArrayList<Agent>();
      a4.add(new Agent(0,0,6,mm));
      a4.add(new Agent(0,0,5,mm));
      a4.add(new Agent(0,0,4,mm));
      a4.add(new Agent(0,0,3,mm));
      a4.add(new Agent(0,0,2,mm));
      a4.add(new Agent(0,0,1,mm));
    b.sort(a4);
  for(int j = 0; j < 901; j++){
  ArrayList<Agent>a5 = new ArrayList<Agent>();
  int i = 40000;
  while(a5.size() <= 4000){
    a5.add(new Agent(0,0,int(random(1,1000000)),mm));
    i--;
    }
  b.sort(a5);
  }
  
  
  
  
  }
}


public class SNTester{
  public void test(){
  SugarGrid sg = new SugarGrid(3,3,50,new GrowbackRule(1), new PollutionRule(1,1), new PollutionMovementRule());
  Agent a = new Agent(1,1,1,new PollutionMovementRule());
  SocialNetwork sn = new SocialNetwork(sg);
  SocialNetworkNode x = new SocialNetworkNode(a);
  SocialNetworkNode y = new SocialNetworkNode(a);
  assert(x.equals(y));
  Agent b = new Agent(1,1,1,new PollutionMovementRule());
  Agent c = new Agent(1,1,2,new PollutionMovementRule());
  Agent d = new Agent(1,1,3,new PollutionMovementRule());
  Agent e = new Agent(1,1,4,new PollutionMovementRule());
  
  sg.placeAgent(b,1,0);
  sg.placeAgent(c,0,2);
  sg.placeAgent(d,1,1);
  sg.placeAgent(e,2,1);
  
  SocialNetworkNode n0 = sn.getNode(c);
  SocialNetworkNode n1 = sn.getNode(b);
  SocialNetworkNode n2 = sn.getNode(d);
  SocialNetworkNode n3 = sn.getNode(a);
  SocialNetworkNode n4 = sn.getNode(e);
  assert(n3 == null);
  assert(sn.adjacent(n1,n2) == true);
  assert(sn.adjacent(n1,n4) == false);
  println("Sees test d:" + sn.sees(n2));
  println("Sees test e:" +sn.sees(n4));
  println("Seen by test d:" + sn.sees(n2));
  println("Seen by test b:" +sn.sees(n1));
  sg.display();
  
  assert(sn.pathExists(b,e) == true);
  assert(sn.pathExists(b,c) == false);
  println("pathExist works");
  
  
  
  Agent f = new Agent(1,1,5,new PollutionMovementRule());
  sg.placeAgent(f,0,1);
  SocialNetworkNode n5 = sn.getNode(f);
  
  println("Bacon: " + sn.bacon(b,e));
  
  sg.display();
  }
}