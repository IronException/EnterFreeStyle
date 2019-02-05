public class Value extends UseProc{
  
  public Value(){
    super();
    
   // valInd = "";
    
  }
  
  
  public void render(){
    background(225);
    String txt = "";//valInd;
    new TextPanel(txt, 0, 0, width, yKeyBoardPos);
    
    renderKeyBoard();
    
  }
  
  
  public void tickButtons(){
    tickKeyBoard();
    
  }
  
  public void keyBack(){
    
    useProc = new Menu();
  }
  
  
  
  
}