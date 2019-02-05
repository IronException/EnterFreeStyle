public class BgValue extends UseProc{
  // kg / m^2
  
  /*
  
  todo:
  -if nothing writen(
    -num: new value
    -next: take it
    -changeMmol: take it
  )
  
  add/sub : getFloatValue(); do(); refreshValue(float); renderValue
  changeMmol : getFloatValue(); do(); refeshValue(float); renderValue()
  
  keyPress : if(){ getStringValue(); do(); refreshValue(String); renderValue()
  DIY (st: makeValid())
  
  save : getStringValue(); do(); (refreshValue(String))
  refreshValue() makeValid()
  
  @all: renderValue()
  
  */
  
  public BgValue(){
    super();
    
    yButtonSize = yKeyBoardPos / 3;
    
    
    mmol = bgMmol;
    rawData = true;
    
    
    
    
    refreshValue(bgValue);
    
    
    
    texts = new TextPanel[2];
    texts[0] = new TextPanel("^", 0, 0, width/3, yButtonSize, yButtonSize/12);
    texts[1] = new TextPanel("v", 0, 0, width/3, yButtonSize, yButtonSize/12);
    
    
    if(bgValue > -4 && bgValue < 1){
      state = (int) abs(bgValue) + 1;
      
      refreshValue();
      refreshValue(state);
      renderValue();
    //coolActivate();
      
      /*refreshValue();
      refreshValue(state);
      renderValue();*/
      //setValText("");
    }
    
  }
  
  int state;
  
  boolean mmol;
  float value;
  TextPanel valText;
  
  float yButtonSize;
  TextPanel[] texts;
  //PImage[] arrows;
  
  String lastValue;
  
  boolean rawData;
  
  
  
  public void tickButtons(){
    tickKeyBoard();
    tickAddButton();
    tickChangeButton();
  }
  
  public void tickAddButton(){
    //boolean condition = false;
    if(mouseY < yButtonSize * 3){
      float add = 0;
      if(mouseX < width/3){
        add = 10;
      } else if(mouseX < 2 * width/3) {
        add = 1;
      } else {
        add = 0.1;
      }
      
      if(mouseY > yButtonSize){
        if(mouseY > 2 * yButtonSize){
          add *= -1;
        } else {
          add = 0;
        }
      }
      
      if(!mmol){
        add *= 10;
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
  
  public void tickChangeButton(){
    if(mouseY > yButtonSize && mouseY < 2 * yButtonSize){
      rawData = false;
      refreshValue();
      refreshValue(changeMmol());
      renderValue();
      coolActivate();
    }
  }
  
  public void postKeyPress(){
    String val = valueInd;
    if(validChange(val, mmol)){
      
      
     // refreshValue(val);
    } else {
      
      val = makeValid(val);
    }
    vibrate(50);
    rawData = false;// ?
    refreshValue(val);
    
    renderValue();
  }
  
  public float changeMmol(){
    // just changing it
    mmol = !mmol;
    float toMuch;
    if(mmol){
     // toMuch = value % 18;
    // println("mmol: " + value);
      value = (int) (value / 18) + convertModulo((int) (value % 18));
      
    } else {
     // println("mmol: " + value);
      value = value * 18.0;
      toMuch = value % 1;
      value -= toMuch;
      
    }
    
    //println("newMmol: " + value);
    return value;
  }
  
  public float addToValue(float add){
    value += add;
    return value;
  }
  
  
  
  public boolean validChange(String val, boolean mmol){
    
    return true;
  }
  
  
  public void setValText(String txt){
    String val = txt;
    //val = makeValid(val);
    /*
    if(setVal){
      values = val;
    }*/
    //
    
    switch(state){
      case 0:
        if(mmol){
          val = "mmol/L: " + val;
        } else {
          val = "mg/dL: " + val;
        }
        break;
      case 1:
        val = "LOW";
        break;
      case 2:
        val = "HIGH";
        break;
      case 3:
        val = "10min wait";
        break;
      case 4:
        val = "retry";
        break;
      }
    
    valText = new TextPanel(val, 0, yButtonSize, width, yButtonSize, width/12);
  }
  
  public String makeValid(String val){
    int pPos = 4;
    //String val = value + "";
    pPos = val.split("\\.")[0].length();
    
    if(mmol){
      pPos += 2;
    }
    
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
  
  
  
  public void keyUp(){
    state ++;
    float nev = 0;
    switch(state){
      case 1:
        nev = 0;
        break;
      case 2:
        nev = -1;
        break;
      case 3:
        nev = -2;
        break;
      case 4:
        nev = -3;
        break;
      case 5:
      
        nev = 150;
        state = 0;
        break;
      
    }
    
    refreshValue();
    refreshValue(nev);
    renderValue();
    coolActivate();
  }
  
  /*
  0 value
  1 low 0
  2 high -1 = 1111111111
  3 10min wait = -2
  4 retry = -3
  */
  
  public void keyDown(){
    state --;
    float nev = 0;
    switch(state){
      case -1:
        nev = -3;
        state = 4;
        break;
      case 0:
        nev = 150;
        break;
      case 1:
        nev = 0;
        break;
      case 2:
        nev = -1;
        break;
      case 3:
        nev = -2;
        break;
      
    }
    
    
    refreshValue();
    refreshValue(nev);
    renderValue();
    coolActivate();
  }
  
  public void keyBack(){
    //boolean condition = true; // if u need to go back
    //if(condition){
      //isAlright();
      sace();
      vibrate(100);
      //useProc = new Device();
      if(isMeter(device)){
        nextScreen(new Times1());
      } else {
        nextScreen(new Device());
      }
      //backScreen();
    //}
  }
  
  
  public void keyEnter(){
    //if(isAlright()){
      refreshValue();
      sace();
      
      if(state != 0){
        nextScreen(new ComTag());
      } else if(isMeter(device)){
        nextScreen(new Place());
      } else {
        nextScreen(new Arrow());
      }
      /*
    } else {
      valText = new TextPanel("0 is unacceptable", 0, yButtonSize, width, yButtonSize, width/12);
    }*/
    vibrate(100);
  }
  
  public void sace(){
    bgMmol = mmol;
    bgValue = value;
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
        value = Float.parseFloat(valueInd);
      } catch(Exception e){
        value = 0;
      }
    }
  }
  
  public void refreshValue(float valu){
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
    
    new TextPanel(device, 0, height / 16, width, height / 16).render();
  }
  
  public void renderButton(){
    float x, y, xS, yS;
    y = 0;
    xS = width/3;
    yS = yButtonSize;
    // have to do this fsr
    texts[0].render(0, y, xS, yS);
    for(int i = 0; i < 3; i ++){
      x = i * width/3;
      fill(225);
      rect(x, y, xS, yS);
      texts[0].render(x, y, xS, yS);
    }
    y = yButtonSize * 2;
    for(int i = 0; i < 3; i ++){
      x = i * width/3;
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
  
  public float convertModulo(int modulo){
    float vale = 0;
    //print(modulo + " ");
    switch(modulo){
        case 1:
          vale += 0.06;
          break;
        case 2:
          vale += 0.12;
          break;
        case 3:
          vale += 0.17;
          break;
        case 4:
          vale += 0.23;
          break;
        case 5:
          vale += 0.3;
          break;
        case 6:
          vale += 0.34;
          break;
        case 7:
          vale += 0.4;
          break;
        case 8:
          vale += 0.45;
          break;
        case 9:
          vale += 0.5;
          break;
        case 10:
          vale += 0.56;
          break;
        case 11:
          vale += 0.62;
          break;
        case 12:
          vale += 0.67;
          break;
        case 13:
          vale += 0.73;
          break;
        case 14:
          vale += 0.8;
          break;
        case 15:
          vale += 0.84;
          break;
        case 16:
          vale += 0.9;
          break;
        case 17:
          vale += 0.95;
          break;
        default:
          
      }
      
      //println(vale);
      return vale;
  }
  
  
  
  
}