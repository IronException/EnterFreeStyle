

public class Countdown extends Button{
  
  public Countdown(){
    super();
    
    setCountCol(color(255, 0, 0));
    setState(1);
    setMax(2);
    
    setTimeFormat(format_state_max);
    setTimePos(timePos_middle);
    
  }
  
  
  public Countdown setCountCol(int col){
    this.countCol = col;
    return this;
  }
  
  public Countdown setState(float state){
    this.state = state;
    return this;
  }
  
  public Countdown setMax(float max){
    this.max = max;
    return this;
  }
  
  
  public Countdown setTimeFormat(String format){
    this.timeFormat = format;
    return this;
  }
  
  public Countdown setTimePos(int timePos){
    this.timePos = timePos;
    return this;
  }
  
  public String format_state = "num";
  public String format_state_max = "num / max";
  public int timePos_full = 0;
  public int timePos_middle = 1;
  
  int countCol;
  
  float state, max;
  
  String timeFormat;
  
  int timePos;
  
  //float xFormatPos, yFormatPos, xFormatSize, yFormatSize;
  
  public void render(){
    renderSuper();
    renderBar();
    renderTime();
    
    
  }
  
  public void renderSuper(){
    super.render();
  }
  
  public void renderBar(){
    float size = state * xSize / max;
    if(size < 0){
      size = 0;
    } else if(size > xSize){
      size = xSize;
    }
    
    fill(countCol);
    rect(xPos, yPos, size, ySize);
    
  }
  
  
  public void renderTime(){
    String txt = "";
    if(timeFormat.equals(format_state)){
      txt = state + "";
    } else if(timeFormat.equals(format_state_max)){
      txt = state + " / " + max;
    }
    
    float xFPos, yFPos, xFSize, yFSize;
    xFPos = xPos;
    yFPos = yPos;
    xFSize = xSize;
    yFSize = ySize;
    
    switch(timePos){
      case 0:
        
        break;
      case 1:
        yFSize /= 3;
        yFPos += yFSize;
        break;
      default:
      
    }
    
    new TextPanel(txt, xFPos, yFPos, xFSize, yFSize).render();
    
  }
  
  
  
  
  
  
}

public class TimeCounter extends Countdown{
  
  
  public TimeCounter(){
    super();
    
    setToWait(new Time(0, 0, 0, 1, 0, 0));
    
    
    
    counting = false;
  }
  
  
  public TimeCounter setToWait(Time toWait){
    this.toWait = toWait;
    setMax(toWait.getSecs());
    return this;
  }
  
  public TimeCounter setStart(Time desiredStart){
    start();
    this.start = desiredStart;
    //counting = true;
    end = new Time(start).addTime(toWait);
    return this;
  }
  
  public boolean tickButton(){
    boolean rV = super.tickButton();
    if(rV){
      start();
    }
    return rV;
  }
  
  public void start(){
    start = new Time();
    counting = true;
    end = new Time(start).addTime(toWait);
  }
  
  Time start;
  Time toWait;
  Time end;
  
  boolean counting;
  public void tick(){
    if(counting){
      
      Time toSub = new Time();
      Time erg = toSub.subTime(start);
      long cur = erg.getSecs();
      
      println(toSub.toDate() + " - " + start.toDate());
      println(" = " + erg.toDate() + " -> " + cur);
      
      setState(cur);
      useProc.doRender();
      
      if(state >= max){
        counting = false;
        useProc.doRender();
      }
    }
  }
  
  public void render(){
    super.render();
    
    try{
      float ySmSize = ySize / 3;
      new TextPanel(start.toDate(), xPos, yPos, xSize, ySmSize).render();
      new TextPanel(end.toDate(), xPos, yPos + 2 * ySmSize, xSize, ySmSize).render();
    } catch(Exception e){}
    
    
  }
  
  
}