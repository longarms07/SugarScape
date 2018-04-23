public class SocialNetworkNode{
  
  private Agent a;
  private Boolean painted;
  private SocialNetworkNode accessedBy = null;
  private int id;
  
  public SocialNetworkNode(Agent aa){
    this.a = aa;
    this.painted = false;
  }
  
  public boolean painted(){
    return painted;
  }
  
  public void paint(){
    painted = true;
    //this.colorAgent();
  }
  
  public void unpaint(){
    painted = false;
    //this.colorAgent();
  }
  
  public Agent getAgent(){
    return a;
  }
  
  
  public boolean equals(SocialNetworkNode s){
    if(this.getAgent().equals(s.getAgent())){
      return true;
    }return false;
  }
  
  
  public String toString(){
    return this.getAgent().toString();
  }
  
  public void setAccessedBy(SocialNetworkNode s){
    this.accessedBy = s;
  }
  
  
  public SocialNetworkNode getAccessedBy(){
    return this.accessedBy;
  }
  
  public void setID(int i){
    this.id = i;
  }
  
  public int getID(){
    return this.id;
  }
  
  /*
  public void colorAgent(){
    if(this.painted = true){
      this.a.setColor(255);
    }else{
      this.a.setColor(0);
    }
  }*/
  
  
  
  
}