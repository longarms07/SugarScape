import java.util.ArrayList;

public class Graph{
 
  int xPos;
  int yPos;
  int w;
  int h;
  String xLab;
  String yLab;
  
  
  public Graph(int x, int y, int howWide, int howTall, String xlabel, String ylabel){
    this.xPos = x;
    this.yPos = y;
    this.w = howWide;
    this.h = howTall;
    this.xLab = xlabel;
    this.yLab = ylabel;
  }
  
  public void update(SugarGrid g){
    noStroke();
    fill(255);
    rect(xPos,yPos,w,h);
    fill(0);
    stroke(2);
    line(xPos,yPos+h,xPos+w,yPos+h); //line x
    line(xPos,yPos,xPos,yPos+h); //line y
    textSize(10);
    text(xLab, xPos+w/3,yPos+h+15); //xtext
    pushMatrix();
    translate(xPos+15,yPos+h);
    rotate(-PI/2.0);
    text(yLab,xPos/5,-25); //ytext
    popMatrix();
    
  }
}


abstract class LineGraph extends Graph{
  
  int updateCalls = -1;
  
  
  public LineGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x,y,howWide,howTall,xlab,ylab);
    this.updateCalls = 0;
  }
  
  public abstract int nextPoint(SugarGrid g);
  
  public void update(SugarGrid g){
    if(updateCalls == 0){
      super.update(g);
      updateCalls = updateCalls+1;
    }else{
      //println("updating");
      int yPoint =this.nextPoint(g);
      fill(0,0,255);
      noStroke();
      rect(xPos+updateCalls, (yPos+h)-yPoint, 1,1);
      updateCalls = updateCalls+1;
      if(updateCalls > w){
        updateCalls = 0;
      }
    }
  }
  
  
  
}



public class AgentGraph extends LineGraph{
  
  ArrayList<Agent> ag;
  
  public AgentGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x,y,howWide,howTall,xlab,ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ag = g.getAgents();
    int np = ag.size()*2;
    while(np > h){ //normalize
      float divideBy = float(np)/float(h);
      np = round(float(np)/divideBy);
      //np = round(divideBy);
      //println(np);
    }
    return np;
  }
  
  public void update(SugarGrid g){
    super.update(g);
  }
 
}

public class AgentSLGraph extends LineGraph{
  
  ArrayList<Agent> ag;

  
  public AgentSLGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x,y,howWide,howTall,xlab,ylab);
  }
  
  public int nextPoint(SugarGrid g){
    ag = g.getAgents();
    int avg=0;
    int i;
    for(i = 0; i < ag.size(); i++){
      avg = ag.get(i).getSugarLevel();
    }
    avg = avg/i;
    
    int np = avg*10;
    while(np > h){ //normalize
      float divideBy = float(np)/float(h);
      np = round(float(np)/divideBy);
      //println(np);
    }
    return np;
  }
  
  public void update(SugarGrid g){
    super.update(g);
  }
 
}


public abstract class CDFGraph extends Graph{
  
  int cpv;
  int numUpdates;
  
  public CDFGraph(int x, int y, int howWide, int howTall, String xlab, String ylab, int callsPerValue){
    super(x,y,howWide,howTall,xlab,ylab);
    this.cpv = callsPerValue;
    this.numUpdates = 0;
  }
  
  public abstract void reset(SugarGrid g);
  public abstract int nextPoint(SugarGrid g);
  public abstract int getTotalCalls(SugarGrid g);
  public void update(SugarGrid g){
    numUpdates = 0;
    super.update(g);
    this.reset(g);
    //print(this.getTotalCalls(g));
    int numPerCell = this.w/this.getTotalCalls(g);
    //println(numPerCell + "equals" + w + "/" + this.getTotalCalls(g));
    while(numUpdates < this.getTotalCalls(g)){
      noStroke();
      fill(0,255,0);
      //println(numPerCell);
      //println(numUpdates);
      rect(xPos+(numUpdates)*10, (yPos+h)-this.nextPoint(g), numPerCell, 1);
      numUpdates = numUpdates+1;
      //println(numUpdates);
    }
  }
}


public class WealthCDF extends CDFGraph{
  
  ArrayList<Agent> al;
  int sugarSoFar;
  int totalSugar = 0;
  
  public WealthCDF(int x, int y, int howWide, int howTall, String xlab, String ylab, int callsPerValue){
    super(x,y,howWide,howTall,xlab,ylab,callsPerValue);
  }
  
  public void reset(SugarGrid g){
    sugarSoFar = 0;
    this.al = g.getAgents();
    Sorter s = new QuickSorter();
    s.sort(al);
    totalSugar = 0;
    for(int i = 0; i<al.size(); i++){
     totalSugar = totalSugar + al.get(i).getSugarLevel(); 
    }
  }
  
  public int nextPoint(SugarGrid g){
    int agentsSoFar = this.numUpdates;
    int agentsRemaining = al.size() - agentsSoFar;
    int avgsl = 0;
    int divideBy = 0;
    if(agentsRemaining < cpv){
      for(int j = 0; j<agentsRemaining; j++){
        avgsl = avgsl + al.get(j).getSugarLevel();
        divideBy = divideBy+1;
      }
    }else{
      for(int i = 0; i<cpv; i++){
        avgsl = avgsl + al.get(i).getSugarLevel();
        divideBy = divideBy+1;
      }
    }
    if(divideBy != 0){
    avgsl = avgsl/divideBy;
    }
    this.sugarSoFar = round(float(sugarSoFar)+float(avgsl));
    //println(sugarSoFar);
    //println(totalSugar);
    return int(float(sugarSoFar)/float(totalSugar)*250);
  }
  
  public int getTotalCalls(SugarGrid g){
    int gtc = ceil(float(al.size())/float(cpv));
    //print(al);
    //println(al.size());
    //println(cpv);
    //println((al.size())/float(cpv));
    return gtc;
  }
  
  
  
  
  
  
}