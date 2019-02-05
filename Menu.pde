

public class Menu extends UseProc{
  
  public Menu(){
    super();
    
    // does this even get called?
    
    
    buts = new Button[4];
    float ySize = height / buts.length;
    
    buts[0] = new Button();
    buts[0].setTxt(device);
    buts[0].setCol(180);
    buts[0].setPosSize(0, 0, width, ySize);
    
    buts[1] = new Button();
    buts[1].setTxt("device");
    //buts[0].setCol(180);
    buts[1].setPosSize(0, ySize, width, ySize);
    
    buts[2] = new Button();
    buts[2].setTxt("enter BG");
    //buts[0].setCol(180);
    buts[2].setPosSize(0, 2 * ySize, width, ySize);
    
    buts[3] = new Button();
    buts[3].setTxt("timesMessed");
    //buts[0].setCol(180);
    buts[3].setPosSize(0, 3 * ySize, width, ySize);
    
    
  }
  
  
  public void render(){
    background(225);
    
    //renderKeyBoard();
    
    for(int i = 0; i < buts.length; i ++){
      buts[i].render();
    }
    
  }
  
  /*
    device name
    enter
    timesMeassured
    
  */
  
  Button[] buts;
  
  public void tickButtons(){
    //tickKeyBoard();
    if(buts[1].tickButton()){
      nextScreen(new Device());
    } else if(buts[2].tickButton()){
      if(isMeter(device)){
      nextScreen(new Times1());
    } else {
      nextScreen(new BgValue());
    }
     // nextScreen(new BgValue());
    } else if(buts[3].tickButton()){
      nextScreen(new Done());
    }
    
    
  }
  
  
  
  
}