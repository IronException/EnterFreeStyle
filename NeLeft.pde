public class NeLeft extends UseProc{
  
  public NeLeft(){
    super();
    
    
    arrowButs = 1;
    
    yButtonSize = yKeyBoardPos / 3.0;
    
    //neCh = true;
    
    rawData = true;
    refreshValue(neLeft);
    
    texts = new TextPanel[2];
    texts[0] = new TextPanel("^", 0, 0, width/arrowButs, yButtonSize, yButtonSize/12);
    texts[1] = new TextPanel("v", 0, 0, width/arrowButs, yButtonSize, yButtonSize/12);
    
    
    
    
  }
  
  
  int arrowButs;
  
  int value;
  TextPanel valText;
  
  float yButtonSize;
  TextPanel[] texts;
  //PImage[] arrows;
  
  String lastValue;
  
  boolean rawData;
  
  
  
  public void tickButtons(){
    tickKeyBoard();
    tickAddButton();
    //tickChangeButton();
  }
  
  public void tickAddButton(){
    //boolean condition = false;
    if(mouseY < yButtonSize * 3){
      int add = 1;
      
      // its all y
      
      if(mouseY > yButtonSize){
        if(mouseY > 2 * yButtonSize){
          add *= -1;
        } else {
          add = 0;
        }
      }
      
      
      
      vibrate(25);
      // y 2x?
      rawData = false;
      refreshValue();
      refreshValue(addToValue(add));
      renderValue();
      coolActivate();
    }
  }
  
  
  
  public void postKeyPress(){
    String val = valueInd;
    
    
    val = makeValid(val);
    
    vibrate(50);
    rawData = false;// ?
    refreshValue(val);
    
    renderValue();
  }
  
  
  public int addToValue(int add){
    value += add;
    return value;
  }
  
  
  
  
  
  
  public void setValText(String txt){
    String val = "needleNum: " + txt;
    //val = makeValid(val);
    /*
    if(setVal){
      values = val;
    }*/
    //
    
    valText = new TextPanel(val, 0, yButtonSize, width, yButtonSize, width/12);
  }
  
  public String makeValid(String val){
    int pPos = 4;
    //String val = value + "";
    pPos = val.split("\\.")[0].length();
    
    
    
    try{
      val = val.substring(0, pPos);
      //values[valInd] = values[valInd].substring(0, pPos);
    } catch(Exception e){}
    return val;
  }
  
  
  public void keyNumber(int a){
    super.keyNumber(a);
    //println("rawData: " + rawData);
    if(rawData){
      super.valueInd = a + "";
      
    }
    
    //rawData = false;
  }
  
  
  public void keyBack(){
    //boolean condition = true; // if u need to go back
    //if(condition){
      //isAlright();
      sace();
      vibrate(100);
      //useProc = new Device();
      backScreen();
    //}
  }
  
  
  public void keyEnter(){
    //if(isAlright()){
      refreshValue();
      sace();
      backScreen();
      /*
    } else {
      valText = new TextPanel("0 is unacceptable", 0, yButtonSize, width, yButtonSize, width/12);
    }*/
    vibrate(100);
  }
  
  public void sace(){
    
    neLeft = value;
  }
  
  public void refreshValue(String valu){
    //if(
    //rawData = true;
    super.valueInd = valu;
    
    setValText(valu);
  }
  
  public void refreshValue(){
    if(!lastValue.equals(valueInd)){
      try{
        value = Integer.parseInt(valueInd.split("\\.")[0]);
      } catch(Exception e){
        value = 0;
      }
    }
  }
  
  public void refreshValue(int valu){
    value = valu;
    //rawData = true;
    super.valueInd = makeValid(valu + "");
    lastValue = valueInd;
    setValText(valueInd);
    
  }
  
  
  public void render(){
    renderKeyBoard();
    renderButton();
    renderValue();
  }
  
  public void renderButton(){
    float x, y, xS, yS;
    y = 0;
    xS = width/arrowButs;
    yS = yButtonSize;
    // have to do this fsr
    texts[0].render(0, y, xS, yS);
    for(int i = 0; i < 3; i ++){
      x = i * xS;
      fill(225);
      rect(x, y, xS, yS);
      texts[0].render(x, y, xS, yS);
    }
    y = yButtonSize * 2;
    for(int i = 0; i < 3; i ++){
      x = i * xS;
      fill(225);
      rect(x, y, xS, yS);
      texts[1].render(x, y, xS, yS);
    }
  }
  
  public void renderValue(){
    fill(250);
    rect(0, yButtonSize, width, yButtonSize);
    valText.render();
  }
    
  
}