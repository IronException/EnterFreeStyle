

/*
public class Panel{
  
  int col;
  
  float xPos, yPos, xSize, ySize;
  
  public void setPosSize(float xPos, float yPos, float xSize, float ySize){
    this.xPos = xPos;
    this.yPos = yPos;
    this.xSize = xSize;
    this.ySize = ySize;
  }
  
  public void setCol(int col){
    this.col = col;
  }
  
  public void render(){
    fill(col);
    rect(xPos, yPos, xSize, ySize);
    
  }
  
}
*/

/*
public class Event extends Panel{
  
  public Event(String name){
    
    this.name = name;
  }
  
  String name;
  Time time;
  
  public void render(){
    fill(250);
    rect(xPos, yPos, xSize, ySize);
    new TextPanel(name, xPos, yPos, xSize, ySize).render();
    
    if(time != null){
      new TextPanel(time.toDate(), xPos, yPos + 2 * ySize / 3, xSize, ySize / 3).render();
    }
  }
  
  public void tick(){
    time = new Time();
    render();
    //useProc.doRender();
  }
  
  public String getIfActivated(){
    String rV = "";
    if(time != null){
      rV += ":" + name + " " + time.toTime();
    }
    return rV;
  }
  
  
}*/


public class Panel /*extends UseProc*/{
  
  public Panel(){
    col = 255;
    img = null;
    
    setPosSize(0, width, 0, height / 2);
    
  }
  
  public Panel setImg(PImage img){
    this.img = img;
    return this;
  }
  
  public Panel setCol(int col){
    this.col = col;
    return this;
  }
  
  public Panel setPosSize(float xPos, float yPos, float xSize, float ySize){
    setX(xPos, xSize).setY(yPos, ySize);
    nevPosSize(0);
    return this;
  }
  
  public void nevPosSize(int i){}
  
  public Panel setPos(float xPos, float yPos){
    setXPos(xPos).setYPos(yPos);
    return this;
  }
  
  public Panel setSize(float xSize, float ySize){
    setXSize(xSize).setYSize(ySize);
    return this;
  }
  
  public Panel setX(float xPos, float xSize){
    setXPos(xPos).setXSize(xSize);
    return this;
  }
  
  public Panel setY(float yPos, float ySize){
    
    setYPos(yPos).setYSize(ySize);
    
    return this;
  }
  
  public Panel setXPos(float xPos){
    this.xPos = xPos;
    return this;
  }
  
  public Panel setYPos(float yPos){
    
    this.yPos = yPos;
    return this;
  }
  
  public Panel setXSize(float xSize){
    this.xSize = xSize;
    return this;
  }
  
  public Panel setYSize(float ySize){
    this.ySize = ySize;
    return this;
  }
  
  
  
  
  int col;
  
  PImage img;
  
  float xPos, yPos, xSize, ySize;
  
  
  
  public void render(){
    if(img == null){
      fill(col);
      rect(xPos, yPos, xSize, ySize);
    } else {
      image(img, xPos, yPos, xSize, ySize);
    }
  }
  
}

public class Button extends Panel {
  
  public Button(){
    super();
    this.txt = "";
    this.txtCol = 0;
  }
  
  public Button setTxt(String txt){
    this.txt = txt;
    return this;
  }
  
  public Button setPressImg(PImage img){
    this.press = img;
    return this;
  }
  
  public Button setTxtCol(int col){
    this.txtCol = col;
    return this;
  }
  
  public String getTxt(){
    return txt;
  }
  
  String txt;
  int txtCol;
  
  int active;
  PImage press;
  
  
  public void render(){
    super.render();
    new TextPanel(txt, xPos, yPos, xSize, ySize).render();//setCol(txtCol).render();
    
  }
  
  public boolean tickButton(){
    boolean rV = false;
    if(isMouseOnButton()){
      exeTickButton((mouseX - xPos) / xSize, (mouseY - yPos) / ySize);
      rV = true;
    }
    return rV;
  }
  
  public boolean isMouseOnButton(){
    if(isMouseXOnButton()){
      if(isMouseYOnButton()){
        return true;
      }
    }
    return false;
  }
  
  public boolean isMouseXOnButton(){
    if(mouseX > xPos && mouseX < xPos + xSize){
      return true;
    }
    return false;
  }
  
  public boolean isMouseYOnButton(){
      if(mouseY > yPos && mouseY < yPos + ySize){
        return true;
      }
    return false;
  }
  
  public void exeTickButton(float x, float y){}
  
  
}

//public class 





/*
public class TextPanel extends Panel{
  
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
    setCol(0);
    this.accuracy = accuracy;
    this.textSize = getTextSize(text, xSize, ySize);
    textSize(this.textSize);
    this.xPos = xPos + xSize/2 - textWidth(text)/2;
    this.yPos = yPos + ySize/2 + textAscent()/2;
    
  }
  
  public TextPanel setCol(int colour){
    this.colour = colour;
    this.colorSet = true;
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
  
}*/


public class RadioButton extends Button{
  
  public RadioButton(){
    super();
    //tested = true;
    
    
    
    //yPos = width / 2;//width / testSizes.length + height / 16;
    //ySize = height - 2 * yPos;
    
    //xPos = width / 8;
    //x2Pos = width - xPos;
    
    //lec = x2Pos;
    
    setOffset(xSize / 8);
    setTxtHeight(ySize / 4.0);
    setLine(50);
    setLineCol(color(39, 76, 148));
    
  }
  
  public RadioButton setXSize(float xSize){
    super.setXSize(xSize);
    //refreshLine();
    setOffset(xSize / 8);
    return this;
  }
  
  public RadioButton setYSize(float ySize){
    super.setYSize(ySize);
    //refreshLine();
    setTxtHeight(ySize / 4.0);
    return this;
  }
  /*
  private void refreshLine(){
   // line = xPos + (x2Pos - xPos) / 2;
    setLine(50);
  }*/
  
  /**
    0 - 100.0
  */
  public RadioButton setLine(float size){
    line = size; //xPos + size * xSize / 100.0;
    return this;
  }
  
  
  public RadioButton setOffset(float off){
    this.offset = off;
    return this;
  }
  
  public RadioButton setTxtHeight(float txtHeight){
    this.txtHeight = txtHeight;
    return this;
  }
  
  public RadioButton setLineCol(int lCol){
    this.lineCol = lCol;
    return this;
  }
  
  float txtHeight;
  
  float line;
  float offset;
  
  int lineCol;
  
  //float yPos, ySize, xPos, x2Pos;
  
  public void render(){
    //l
    fill(col);
    rect(xPos, yPos, xSize, ySize);
    // txt
    new TextPanel(txt, xPos, yPos, xSize, txtHeight).render();//setCol(txtCol).render();
    
    
    
    
    float size = (ySize - txtHeight) / 4.0;
    
   // float difS = ySize / 3;
    float pos = yPos + txtHeight + (ySize - txtHeight) / 2.0;
    
    fill(lineCol);
    stroke(lineCol);
    line(xPos + offset, pos, xPos + xSize - offset, pos);
    ellipse(xPos + offset + line * (xSize - 2 * offset) / 100, pos, size, size);
    
   // pos += difS;
    /*
    float difL = getDif();
    float xStart = width / 3;
    float x = xStart + difL / 2;
    boolean ins = true;
    if(difL == 0){
      ins = false;
      difL = width;
    }
    
    while(x > 0){
      if(ins){
        stroke(0);
      } else {
        stroke(255);
      }
      line(x, pos, x - difL, pos);
      x -= difL;
    }
    
    ins = true;
    if(getDif() == 0){
      ins = false;
      //difL = width;
    }
    
    while(x > 0){
      if(ins){
        stroke(0);
      } else {
        stroke(255);
      }
      line(x, pos, x + difL, pos);
      x += difL;
    }
    
    */
  }
  /*
  public void tickButton(){
    
    
    if(super.tickButton()){
      
    }
    /*
    if(mouseY < yPos){
      //time.put("test", new Time());
     // value = testSizes[(int) (testSizes.length * mouseX / width)];
      //spris.add(new Spri(new Time(), 
     // doRender();
    } else if(mouseY > yPos + ySize){
      //if(value > 0 && !added){
        //added = true;
        
     //   time.put("got", new Time());
      //  spris.add(this);
      //}
      backScreen();
    /*  if(getLine() > 0.5){
        ((Times) useProc).testWasSucces = true;
      }
    }*
    
  }*/
  
  /*
  public float getDif(){
    return getLine();
  }*/
  
  
  public float getLine(){
    return line;
  }
  /*
  public String getData(){
    String rV = value + ", ";
    //rV += getTimeData();
    
    rV += "t(" + getLine() + ")";
    return rV;
  }*/
  
  public void tickPress(){
    if(mouseY > yPos && mouseY < yPos + ySize){
     // int y = (int) (2 * (mouseY - yPos) / ySize);
      //println(y);
     // if(y == 0){
        line = 100 * (mouseX - (xPos + offset)) / (xSize - 2 * offset);
        
        if(line < 0){
          line = 0;
       // } else if(mouseX > x2Pos){
          //line = x2Pos;
        } else if(line > 100){
          line = 100;
        }
      //}
     useProc.doRender();
    }
  }
  
  
}





