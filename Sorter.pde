abstract class Sorter{
 
  public Sorter(){
    }  
  
  public abstract void sort(ArrayList<Agent>al);
  
  public boolean lessThan(Agent a, Agent b){
   if(a.getSugarLevel() < b.getSugarLevel()){ 
     return true;
   }
   return false;
  }
  
}

public class BubbleSorter extends Sorter{
  
  public BubbleSorter(){
    super();
  }
  
  public void sort(ArrayList<Agent>al){
    if(al.size() > 1){
    boolean passCheck = true;
    boolean check = false;
    Agent current = al.get(0);
    Agent temp;
    
    while(check == false){
     passCheck = true; 
     
      //debug
      
     /* print("Before: (");
      for(int j = 0; j < al.size(); j++){
        Agent c = al.get(j);
         print(c.getSugarLevel());
         if(j < al.size()-1){
           print(",");
         }
      }
      print(") ");*/
     
     
      for(int i = 0; i < al.size(); i++){
        if(i == 0){
          current = al.get(i);
        }
        else{
         temp = current;
         current = al.get(i);
         if(this.lessThan(temp, current) == false){
          al.set(i-1, current);
          al.set(i, temp);
          //print("Swapped " + temp.getSugarLevel() + " with " + current.getSugarLevel() + " ");
          current = al.get(i);
          passCheck = false;
          
         }
        } 
      }
      
      
     /* print("After: (");
      for(int j = 0; j < al.size(); j++){
        Agent c = al.get(j);
         print(c.getSugarLevel());
         if(j < al.size()-1){
           print(",");
         }
      }
      println(") ");*/
      
      
      
      
      if(passCheck == true){
        check = true;
      }
    }
    
    
    
  }
  }
  
  
}

public class InsertionSorter extends Sorter{
  public InsertionSorter(){
    super();
  }
  
  public void sort(ArrayList<Agent>al){
    
    //boolean pass = false;
    //println("Start: " + al+ "to ");
    if(al.size() > 1){
    for(int i = 0; i<al.size(); i++){
      Agent current = al.get(i);
      if(i >0){
        
        int j = i-1;
        Agent prev = al.get(j);
        while(j>=0 && this.lessThan(prev,current) == false){
          al.set(j+1, prev);
          al.set(j, current);
          assert(al.get(j) == current);
          j=j-1;
          if(j>=0){
          prev = al.get(j);
          }
          //print(al+ "to ");
        }
      }
    }//println("end: "+al);
  }
  }
  
  
  
}


public class MergeSorter extends Sorter{
  public MergeSorter(){
    super();
  }
  
 
  //public void merge(Agent arr[], int left, int mid, int right){
    //int sizeL = mid-left
    
  //}
  
  public void sort(ArrayList<Agent>al){
    //print("Start" + al + " ");
    //size 1 is already sorted
    if(al.size() > 1){
      int left = al.size()/2;
      int right = al.size()-left;
    
      //split
      ArrayList<Agent> l = new ArrayList<Agent>();
        for(int i = 0; i<left; i++){
          l.add(al.get(i));
        }
      ArrayList<Agent> r = new ArrayList<Agent>();
        for(int j = left; j<al.size(); j++){
          r.add(al.get(j));
        }
      //print("left: "+l+" right: "+ r+ " ");
      
      //call left if left isn't 1
      if(l.size() > 1){
      this.sort(l);
      }
      
      //call right
      if(r.size() > 1){
      this.sort(r);
      }
      
      //when the two lists equal one or are sorted or however this stupid crap works, merge
      //ArrayList<Agent> merged = new ArrayList<Agent>();
      al.clear();
     // print("l = "+l+" ");
     // print("r = "+r+" ");
      while(l.size() > 0 || r.size() > 0){
        if(l.size() == 0){
          al.add(r.get(0));
          r.remove(0);
         // print("merged: "+al+" ");
        }else if(r.size() == 0){
          al.add(l.get(0));
          l.remove(0);
         // print("merged: "+al+" ");
        }else{
          if(this.lessThan(l.get(0), r.get(0)) == true){
            al.add(l.get(0));
            l.remove(0);
          //  print("merged: "+al+" ");
          }else{
            al.add(r.get(0));
            r.remove(0);
         //   print("merged: "+al+" ");
          }
        }
      }
        
       // println("end: "+al);
      }
      
      
      
      
      
    }
    
}


public class QuickSorter extends Sorter{
  
  public QuickSorter(){
    super();
  }
  
  
  public void quickSort(ArrayList<Agent>al, int listStart, int listEnd){
    if(listStart < listEnd){
      int pivotIndex = placePivot(al, listStart, listEnd);
      
      //sort the sides
      quickSort(al, listStart, pivotIndex-1);
      quickSort(al,pivotIndex+1,listEnd);
    }
  }
  
  public int placePivot(ArrayList<Agent>al, int listStart, int listEnd){
   int pi = listEnd; //pivot is the end of the list
   Agent pivot = al.get(pi);
   
   int i = (listStart-1); //i is where the smaller ones go. It will always be one lessthan the pivot
   Agent current;
   Agent temp;
   
   for(int j = listStart; j< listEnd; j++){
     //if the current is smaller than the pivot
     current = al.get(j);
     if(this.lessThan(al.get(j), pivot)){
       //increase the smaller index(don't wanna be out of bounds)
       i=i+1;
       temp = al.get(i);
       //swap them
       al.set(i, current);
       al.set(j, temp);
     }
   }
   //when all is said and done, the pivot will be swapped to i+1;
   temp = al.get(i+1);
   al.set(listEnd, temp);
   al.set(i+1, pivot);
   pi = i+1;
   return pi;
  }
    
  
  
  public void sort(ArrayList<Agent>al){
    if(al.size() > 1){
      //print("start:"+al);
      quickSort(al, 0, (al.size())-1);
      //println("done:" + al);
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
}


    
    
    
    
    
   