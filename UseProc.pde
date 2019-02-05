public abstract class UseProc{
  
  // TODO maybe an int state with HashMap -> doSubRender/Tick
  
  
  public UseProc(){
    doRender = true;
    fill(0);
    //subRender = new Runnable[0];
    
    middlePos = height/2 - width/2;
    middleMaxPos = middlePos + width;
    //init();
    setupKeyBoard();
    
    coolActivate();// = new Cooldown();
  }
  
  float middlePos;
  float middleMaxPos;
  
  protected boolean doAfterRender;
  protected boolean doRender;
  
  boolean lastPress;
  
  
  public void tick(){}
  public void tickPressStart(){}
  public void tickPress(){}
  public void tickButtons(){}
  public void tickRelease(){}
  public void render(){}
  
  public void doRender(){
    setDoRender(true);
  }
  
  public void setDoRender(boolean render){
    this.doRender = render;
  }
  
  public void setAfterNextRender(boolean state){
    doAfterRender = state;
  }
  
  
  Cooldown starter;
  //boolean first;
  
  public void drawHelper(){
    tick();
    //println(cool);
    cool.update();
    try{
      starter.update();
    } catch(Exception e){}
    
    if(mousePressed){
      
      if(!lastPress){
        tickPressStart();
        starter = new Cooldown(start);
        //coolActivate();
      }
      
      tickPress();
      
      if(cool.isExpired() && starter.isExpired()){
        tickButtons();
        coolActivate();
      }
      
      //first = true;
    } else if(lastPress){
      //if(!starter.isExpired()){
        tickButtons();
      //}
      
      tickRelease();
      //lastPress
    }
    
    if(doRender){
      render();
      doRender = doAfterRender;
    }
    
    lastPress = mousePressed;
    
//    try{
//      println(starter.timer);
//    } catch(Exception e){
//      
//    }
  }
  
  
  // #############################################
  // extra 
  // #############################################
  
  public void setupKeyBoard(){
    keySize = width/4;
    keys = new TextPanel[4 * 4];
    setKey(0, 0, "1");
    setKey(0, 1, "2");
    setKey(0, 2, "3");
    setKey(0, 3, "<{]");
    setKey(1, 0, "4");
    setKey(1, 1, "5");
    setKey(1, 2, "6");
    setKey(1, 3, "^");
    setKey(2, 0, "7");
    setKey(2, 1, "8");
    setKey(2, 2, "9");
    setKey(2, 3, "v");
    setKey(3, 0, "<");
    setKey(3, 1, "0");
    setKey(3, 2, ".");
    setKey(3, 3, ">");
    
    //cool = new Cooldown();
    coolActivate();
    
    yKeyBoardPos = height - width;
    
    //valInd = 0;
    
    valueInd = "";//new String[]{""};
  }
  
  protected void setKey(int y, int x, String text){
    keys[x + y * 4] = new TextPanel(text, x * width/4, height - width + y * width/4, width/4, width/4, width/12);
  }
  protected float keySize;
  
  protected Cooldown cool;
  protected TextPanel[] keys;
  //public int valInd;
  public String valueInd;
  
  public void tickKeyBoard(){
    /*if(!cool.update()){
      return;
    }*/
    
    //String txt = values[selec];
    
    int x = mouseX * 4/width;
    int y = (mouseY - (height - width)) * 4/width;
    
    int psi = x + y * 4;
    if(mouseY < height - width){
      psi = -1;
    }
    
    switch(psi){
      case 0:
        valueInd += "1";
        keyNumber(1);
        break;
      case 1:
        valueInd += "2";
        keyNumber(2);
        break;
      case 2:
        valueInd += "3";
        keyNumber(3);
        break;
      case 3:
      
       try{
         String txt = valueInd;
         valueInd = txt.substring(0, txt.length() - 1); // TODo
        } catch(StringIndexOutOfBoundsException e){
          
        }
        break;
      case 4:
        valueInd += "4";
        keyNumber(4);
        break;
      case 5:
        valueInd += "5";
        keyNumber(5);
        break;
      case 6:
        valueInd += "6";
        keyNumber(6);
        break;
      case 7:
        keyUp();
       /* valInd --;
        if(valInd < 0){
          valInd = values.length - 1;
        }*/
        break;
      case 8:
        valueInd += "7";
        keyNumber(7);
        break;
      case 9:
        valueInd += "8";
        keyNumber(8);
        break;
      case 10:
        valueInd += "9";
        keyNumber(9);
        break;
      case 11:
        //values[selec] += "";
        keyDown();
       // valInd ++;
        //valInd %= values.length;
        break;
      case 12:
        //values[selec] += "0";
        keyBack();
        break;
      case 13:
//        String[] sp = values[selec].split("");
//        for(int i = 0; i < sp.length; i ++){
//          if(sp[i].equals(".")){
//            break;
//          }
//        }
        valueInd += "0";
        keyNumber(0);
        break;
      case 14:
        boolean out = false;
        String[] sp = valueInd.split("");
        for(int i = 0; i < sp.length; i ++){
          if(sp[i].equals(".") && !out){
            out = true;
            break;
          }
        }
        if(!out){
          valueInd += ".";
        }
        break;
      case 15:
        keyEnter();
        break;
      default:
      
    }
    /*if(psi != 7 && psi != 11){
      values[selec] = txt;
    }*/
    if(psi != -1){
      coolActivate();
    //cool = new Cooldown
      postKeyPress();
    }
  }
  
  public void keyNumber(int num){
    
  }
  public void keyBack(){}
  public void keyEnter(){}
  public void keyUp(){}
  public void keyDown(){}
  public void postKeyPress(){}
  
  public float yKeyBoardPos;
  
  public void renderKeyBoard(){
    fill(255);
    rect(0, yKeyBoardPos, width, width);
    for(int y = 0; y < 4; y ++){
      for(int x = 0; x < 4; x ++){
        fill(255);
        rect(x * width/4, height - width + y * width/4, width/4, width/4);
        keys[x + y * 4].render();
        
      }
    }
    
  }
  
  
  public void coolActivate(){
    cool = new Cooldown();
  }
  
  public boolean isExpired(){
    return cool.isExpired();
  }
  
}

public class TextPanel{
  
  float accuracy;
  
  protected String text;
  protected float textSize;
  protected boolean colorSet;
  protected int colour;
  protected float xPos;
  protected float yPos;
  protected float xSize;
  protected float ySize;
  
  
  
  public TextPanel(String text, float xPos, float yPos, float xSize, float ySize){
    this(text, xPos, yPos, xSize, ySize, 0, ySize / 16);
  }
  
  public TextPanel(String text, float xPos, float yPos, float xSize, float ySize, float offset){
    this(text, xPos, yPos, xSize, ySize, 0, offset);
  }
  
  public TextPanel(String text, float xPos, float yPos, float xSize, float ySize, float accuracy, float offset){
    xPos += offset;
    yPos += offset;
    this.xSize = xSize -=  offset * 2;
    this.ySize = ySize -=  offset * 2;
    
    this.text = text;
    //this.colour = 0;
    //this.colorSet = true;
    setColor(0);
    this.accuracy = accuracy;
    this.textSize = getTextSize(text, xSize, ySize);
    textSize(this.textSize);
    this.xPos = xPos + xSize/2 - textWidth(text)/2;
    this.yPos = yPos + ySize/2 + textAscent()/2;
    
  }
  
  public void setColor(int colour){
    this.colour = colour;
    this.colorSet = true;
  }
  
  public TextPanel setCol(int col){
    setColor(col);
    return this;
  }
  
  public float getTextSize(String text, float xSize, float ySize){
    float below = 0;
    float above = ySize;
    
    // init above
    while(doesTextSizeFit(above, xSize, ySize)){
      above += ySize;
    }
    
    // 
    float current = getAverage(new float[]{below, above});
    while((above - below > accuracy) && ((current != below) && (current != above))){
      if(doesTextSizeFit(current, xSize, ySize)){
        below = current;
      } else{
        above = current;
      }
      current = getAverage(new float[]{below, above});
    }
    
    return below;
  }
  
  public float getAverage(float[] values){
    float sum = 0;
    for(int i = 0; i < values.length; i ++){
      sum += values[i];
    }
    return sum/values.length;
  }
  
  public boolean doesTextSizeFit(float size, float xSize, float ySize){
    textSize(size);
    return (textFitsX(xSize) >= 0) && (textFitsY(ySize) > 0);
  }
  
  public float textFitsX(float xSize){
    return (xSize - textWidth(text))/2;
  }
  
  public float textFitsY(float ySize){
    return (ySize - textAscent())/2;
  }
  
  public void render(){
    textSize(textSize);
    if(colorSet){
      fill(colour);
    }
    text(text, xPos, yPos);
  }
  
  public void render(float xPos, float yPos, float xSize, float ySize){
    this.xPos = xPos + xSize/2 - textWidth(text)/2;
    this.yPos = yPos + ySize/2 + textAscent()/2;
    
    render();
  }
  
}



public class Cooldown{
  
  public Cooldown(){
    this(2.5);
  }
  
  public Cooldown(float tps){
    this((int) (frameRate/tps));
  }
  
  public Cooldown(int cooldown){
    this.timer = cooldown;
  }
  
  protected int timer;
  
  public void update(){
    timer --;
  }
  
  public boolean isExpired(){
    if(timer < 1){
      return true;
    }
    return false;
  }
  
}

