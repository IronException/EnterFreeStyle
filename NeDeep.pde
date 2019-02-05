public class NeDeep extends UseProc{
  
  public NeDeep(){
    super();
    
    buts = new Button[]{
      
      new Button().setTxt("^"),
      new Button().setTxt("v"),
      new Button().setTxt("<"),
      new Button().setTxt(">")
      
      
    };
    
    ySize = height / 4.0;
    //yPos = 2.0 * ySize;
    float xSize = width / 2.0;
    
    buts[0].setPosSize(0, 0, width, ySize);
    buts[1].setPosSize(0, 2.0 * ySize, width, ySize);
    buts[2].setPosSize(0, height - ySize, xSize, ySize);
    buts[3].setPosSize(xSize, height - ySize, xSize, ySize);
    
  }
  
  
  float ySize;
  
  Button[] buts;
  
  
  public void render(){
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
    fill(255);
    rect(0, ySize, width, ySize);
    new TextPanel(neDeep + "", 0, ySize, width, ySize).render();
    
  }
  
  
  public void tickButtons(){
    
    for(int i = 0; i < buts.length; i ++){
      if(buts[i].tickButton()){
        if(buts[i].getTxt().equals("^")){
          neDeep += 0.5;
        } else if(buts[i].getTxt().equals("v")){
          neDeep -= 0.5;
        } else {
          backScreen();
        }
        
      }
    }
    doRender();
    
    //backScreen();
  }
  
  
    
  
}