import java.util.LinkedList;
import java.util.ArrayList;
import java.util.Queue;

public class SocialNetwork{
  
  private SugarGrid sg;
  private LinkedList<SocialNetworkNode>[] adj; //the social network, array of LinkedLists of Social Network Nodes
  private SocialNetworkNode[] masterList;
  private int w;
  private int h;
  private int size;
  
  //based on diagraph and dps
  //each LinkedList contains a reference to the neighbors
  
  
  
 public SocialNetwork(SugarGrid g){
   if(g != null){
   this.sg = g;
   this.w = sg.getWidth();
   this.h = sg.getHeight();
   this.size = w*h;
   this.adj = new LinkedList[size];
   this.masterList = new SocialNetworkNode[size];
   
   
   this.update();
 }
 }
 
 
 public void update(){
   //empty masterList and adj
   for(int i = 0; i<size; i++){
     masterList[i] = null;
     adj[i] = null;
   }
   //println(adj);
   
   
   //fill adj
    int rowCount = 0;
    int columnCount = 0;
    for(int i = 0; i < size; i++){
      //make a master list of social etwork nodes, to ensure they all exist
      if(sg.getAgentAt(rowCount, columnCount) != null){
        Agent current = sg.getAgentAt(rowCount, columnCount);
        SocialNetworkNode node = new SocialNetworkNode(current);
        node.setID(i);
        masterList[i] = node;
      }
       
      //handle the math of figuring out positioning
      rowCount = rowCount+1;
      if(rowCount == w){
        rowCount = 0;
        columnCount = columnCount+1;
      }
    }
    //make the adj lists
    rowCount = 0;
    columnCount = 0;
    for(int j = 0; j < size; j++){
       if(masterList[j] != null){
         Agent currenta = masterList[j].getAgent();
         //println(rowCount, columnCount);
         LinkedList<Square> vision = sg.generateVision(rowCount, columnCount, currenta.getVision());
         LinkedList<SocialNetworkNode> neighbors = new LinkedList();
           //println(vision);
         for(int k = 0; k<vision.size();k++){
           //println(vision.get(k) + " Agent: "+vision.get(k).getAgent());
           if(vision.get(k).getAgent() != null && vision.get(k).getAgent().equals(currenta) == false){
            //find the square index
            Square squ = vision.get(k);
            int squX = squ.getX();
            int squY = squ.getY();
            int squIndex = (squX + (w*squY)); 
            //println(" add" + masterList[squIndex]);
            neighbors.add(masterList[squIndex]); 
           }
         }adj[j] = neighbors;
       }
       
      
      rowCount = rowCount+1;
      if(rowCount == w){
        rowCount = 0;
        columnCount = columnCount+1;
      }
    }
    //println(masterList);
    //println(adj);
 }
 
 
  
 public boolean adjacent(SocialNetworkNode x, SocialNetworkNode y){
   this.update();
   //check if x and y are present
   int xPos = -1;
   boolean present = false;
   for(int q = 0; q<size;q++){
     if(masterList[q] != null && masterList[q].equals(x) == true){
       present = true;
       xPos = q;
     }
   }if(present != true){
     return false;
   }
     present = false;
     for(int u = 0; u<size;u++){
       if(masterList[u] != null && masterList[u].equals(y) == true){
         present = true;
       }
     }if(present == false){
       return false;
     }
   
     //check if adjacent;
     LinkedList<SocialNetworkNode> xNode = adj[xPos];
     /*print(xNode);
     print(y);
     print(adj[xPos].contains(y));*/
     //if(xNode.contains(y) == true){
     for(int k = 0; k<xNode.size(); k++){
       if(xNode.get(k).getAgent().equals(y.getAgent())){
         return true;
       }
     }
   return false;
 }
 
 public List<SocialNetworkNode> seenBy(SocialNetworkNode x){
   this.update();
   boolean containsSomething = false;
   List<SocialNetworkNode> stub = new LinkedList<SocialNetworkNode>(); 
   //go through adj, run contains on each linkedList, if contains=true add the masterlist value
   for(int z = 0; z<size;z++){
     LinkedList<SocialNetworkNode> current = adj[z];
     if(current != null && current.contains(x) == true){
       stub.add(masterList[z]);
     }
   }
   
   if(containsSomething == false){
     return null;
   }
   return stub;
 }
 
 public List<SocialNetworkNode> sees(SocialNetworkNode y){
   this.update();
   List<SocialNetworkNode> stub = null;
   for(int q = 0; q<size;q++){
     if(masterList[q] != null && masterList[q].equals(y) == true){
       stub = adj[q];
     }
   }
   return stub;
 }
  
 public void resetPaint(){
   this.update();
   for(int q = 0; q<size;q++){
     if(masterList[q] != null){
       masterList[q].unpaint();
     }
   }
 }
 
 public SocialNetworkNode getNode(Agent a){
   this.update();
   SocialNetworkNode stub = null; 
   for(int n =0; n<size; n++){
     if(masterList[n] != null && masterList[n].getAgent().equals(a)){
       stub = masterList[n];
     }
   }
   
   return stub;
 }
  
  public boolean pathExists(Agent x, Agent y){
    this.update();
    //get node for x and y;
    LinkedList<SocialNetworkNode> orgin;
    int xPos = -1;
    int yPos = -1;
    
    for(int n =0; n<size; n++){
     if(masterList[n] != null && masterList[n].getAgent().equals(x)){
        orgin = adj[n];
        xPos = n;;
     }if(masterList[n] != null && masterList[n].getAgent().equals(y)){
        yPos = n;
     }
    }
    if(xPos == -1 || yPos == -1){
      return false;
    }
    //check to see if x has any neighbors, and if a neighbor is y
    //println("let's bacon");
    if(this.bacon(x,y) != null){
      //println("bacon done");
      return true;
    }else{
      //println("bacon done");
      return false;
    }
    
  }
  
  
  public List<Agent>bacon(Agent x, Agent y){
    this.update();
    //get node for x and y while ensuring they exist;
    int xPos = -1;
    int yPos = -1;
    
    for(int n =0; n<size; n++){
     if(masterList[n] != null && masterList[n].getAgent().equals(x)){
        xPos = n;
     }if(masterList[n] != null && masterList[n].getAgent().equals(y)){
        yPos = n;
     }
    }
    if(xPos == -1 || yPos == -1){
      return null;
    }
    
    //if x=y, return (x,x);
    if(xPos == yPos){
      LinkedList<Agent> bac = new LinkedList<Agent>();
      bac.add(masterList[xPos].getAgent());
      bac.add(masterList[yPos].getAgent());
      /*for(int d = 1; d<bac.size(); d++){
          this.DisplayPaths(masterList[d-1], masterList[d]);
        }*/
      return bac;
    } 
    
    //unpaint nodes
    this.resetPaint();
    
    //breadth first search for y through queue
    LinkedList<Integer> bfs = new LinkedList<Integer>();
    bfs.add(xPos);
    masterList[xPos].setAccessedBy(null);
    masterList[xPos].paint();
    int current = -1;
    
    //do bfs
    while(bfs.size() > 0 && current != yPos){ //while there is something left in the queue;
      //println("queue: "+bfs);
      current = bfs.poll(); //remove current from the queue
      //println(current);
      
      //check to see if current = y;
      if(current == yPos){
        //print("made it here");
        //create list representing path;
        LinkedList<Agent> sizzlin = new LinkedList<Agent>();
        //while loop to add nodes to it, going backwards using accessedBy
        SocialNetworkNode currentn = masterList[current];
        while(currentn.getAccessedBy() != null){
          sizzlin.addFirst(currentn.getAgent());
          currentn = currentn.getAccessedBy();
          //println(currentn.getAccessedBy());
        }
        sizzlin.addFirst(currentn.getAgent()); //add the original at the end of that
        /*for(int d = 1; d<sizzlin.size(); d++){
          this.DisplayPaths(masterList[d-1], masterList[d]);
          
        }*/
        return sizzlin;
      }
      
      
      if(adj[current] != null){
       for(int z = 0; z<adj[current].size(); z++){
         //add any neighbors to queue that are not already in queue
         SocialNetworkNode cn = adj[current].get(z);
         //println("z="+z);
         if(cn.painted() == false){
           cn.paint();
           //println("painting" + cn.getID());
           cn.setAccessedBy(masterList[current]);
           bfs.addLast(cn.getID());
         }
       }
      }
    }
    return null;
  }
  
  
  /*public void DisplayPaths(SocialNetworkNode a, SocialNetworkNode b){
   sg.drawLine(a.getAgent(), b.getAgent());
  }*/
  
  /*
  public void display(){
    this.update();
    //print(masterList);
    LinkedList<SocialNetworkNode> current;
    for(int i = 0; i<size; i++){
      if(masterList[i] != null){
      current = adj[i];
      masterList[i].paint();
      //println("something is happening");
      for(int j = 0; j<current.size(); j++){
        current.get(j).paint();
        //this.DisplayPaths(masterList[i], current.get(j));
        //println("painted: "+i+ ","+j);
      }
    }
    }
  }*/
  
  
  
}