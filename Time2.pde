public class Times2 extends UseProc{
  
  
  // neCh = wether leftNeedles r eingetragen...
  
  
  public Times2(){
    
    
    events = new EventManager();
    
    
    eves = new Button[]{
      events.get("changeNeedle"),
      events.get("removeTs"),
      events.get("shutDown"),
      
      new Button().setTxt("<"),
      new Button().setTxt(">")
      
    };
    
    float ySize = height / (eves.length - 1);
    
    for(int i = 0; i < eves.length; i ++){
      eves[i].setPosSize(0, i * ySize, width, ySize);
      //ind ++;
    }
    
    int len = eves.length;
    float xSize = width / 2.0;
    
    eves[len - 2].setPosSize(0, (len - 2) * ySize, xSize, ySize);
    eves[len - 1].setPosSize(xSize, (len - 2) * ySize, xSize, ySize);
    
    
    
    
    
    
  }
  
  EventManager events;
  
  Button[] eves;
  
  
  
  
  public void render(){
    
    for(int i = 0; i < eves.length; i ++){
      eves[i].render();
      //ind ++;
    }
    
    
    //if(neCh){
      
      new TextPanel(neLeft + "", 0, height - eves[0].ySize, width, eves[0].ySize).render();
      
    //}
    
  }
  
  public void tickButtons(){
    for(int i = 0; i < eves.length; i ++){
      if(eves[i].tickButton()){
        if(eves[i].getTxt().equals(">")){
          events2 = events.getData();
          nextScreen(new ComTag());
        } else if(eves[i].getTxt().equals("<")){
          //nextScreen(new Device());
          backScreen();
        } else if(eves[i].getTxt().equals("changeNeedle")){
          nextScreen(new NeLeft());
        }
        
        
        
        
      }
      //ind ++;
    }
    
    
  }
  
  
}


