

/*
  
  plan()
  
  
  
  
  
*/


public class EventManager {
  
  public EventManager(){
    events = new HashMap<String, Event>();
    
  }
  
  HashMap<String, Event> events;
  
  public Event get(String eName){
    Event rV = events.get(eName);
    if(rV == null){
      rV = new Event();
      rV.setTxt(eName);
      
      
      events.put(eName, rV);
    }
    
    
    return rV;
  }
  
  
  
  public String getData(){
    String rV = "[";
    String start = "";
    
    //HashMap<String, String> test = new HashMap<>();
    //Set<String> e = events.keySet();
    String[] entr = events.keySet().toArray(new String[0]);
    
    
    for(int i = 0; i < entr.length; i ++){
      
      rV += events.get(entr[i]).getIfActivated(start);
      if(start.length() == 0){
        if(rV.length() > 1){
          start = ", ";
        }
      }
      
    }
    
    rV += "]";
    
    
    return rV;
  }
  
  public String autoSave(){
    // :name time, name time:
    /*String rV = "";
    
    String[] entr = events.keySet().toArray(new String[0]);
    for(int i = 0; i < entr.length; i ++){
      
      rV += events.get(entr[i]).getIfActivated(start);
      if(start.length() == 0){
        if(rV.length() > 1){
          start = ", ";
        }
      }
      
    }*/
    
    return getData();
  }
  
  public void loadAutoSave(String info){
    try{
      
      
      
      info = info.split("\\[")[1];
      info = info.split("]")[0];
      
      //println("IG " + info.length());
      String[] sp = info.split(", ");
      
      Event eve;
      for(int i = 0; i < sp.length; i ++){
        eve = new Event();
        println("load: " + sp[i]);
        eve.loadAutoSave(sp[i]);
        
        events.put(eve.getTxt(), eve);
      }
      
      
      
      
    } catch(Exception e){
      //println("EventException: " + e);
    }
    
  }
  
  
}


// events, test, spri

public class Event extends Button{
  
  String eBar = "&";
  
  public Event(){
    super();
   // this.name = name;
   
   // new
   init();
  }
  
  public Event(String txt){
    this();
    
    setTxt(txt);
    
  }
  
  
  public void loadAutoSave(String info){
    //println("try");
    String[] sp = info.split("\\(");
    setTxt(sp[0]);
    //println(sp[0] + sp[1]);
    try{
      sp = sp[1].split("\\)")[0].split(eBar);
      String[] ts;
      for(int i = 0; i < sp.length; i ++){
        //println("loadE: " + sp[i]);
        ts = sp[i].split(" ");
        getE(ts[0]).time = new Time().setStringTime(ts[1]);
        undoActive = true;
      }
      
      
    } catch(Exception e){
      println("load event: " + e);
    }
  }
  
  
  
  
  public boolean tickButton(){
    boolean rV = super.tickButton();
    if(rV){
      tick();
    }
    
    return rV;
  }
  
  //#^#^#&#&&#&#&#&#&#&#&&#&&#
  //#^#&#&#&&#&##&&#&#&#&#
  // copy .........hssjdjdhhdjdjdhdhdhdhdhdhddh
  public void init(){
    times = new HashMap<String, E>();
    
    setUndoSize(width / 12);
    
    setPoint(false);
    
    refreshS();
  }
  
  public void nevPosSize(int id){
    refreshS();
  }
  
  public Event setUndoSize(float size){
    this.undoSize = size;
    return this;
  }
  /*
  public void addE(String keyy){
    times.put(keyy, new E(this, keyy));
  }*/
  
  public E getE(String keyy){
    E rV = times.get(keyy);
    if (rV == null) {
      rV = new E(this, keyy);
      times.put(keyy, rV);
    }
    return rV;
  }
  
  public Event setPoint(boolean p){
    this.point = p;
    return this;
  }
  
  public void refreshS(){
    float div = 4;
    if(point){
      div = 2;
    }
    xSizeS = xSize / div;
    if(undoActive){
      xSizeS -= undoSize / div;
    }
    
    
    
  }
  
  boolean point;
  
  float undoSize;
  float xSizeS;
  
  boolean undoActive;
  HashMap<String, E> times;
  
  public void render(){
    fill(250);
    rect(xPos, yPos, xSize, ySize);
    
    //float xSizeS = xSize / 2.0;
    float halfY = ySize / 2.0;
    //
    
    E cur;
    
    if(point){
      // 0 0 rn : after
      // 1 0 rn: after U
      // 1 1 rn : after U
      // 0 1 after U
      
      rect(xPos, yPos, xSizeS, ySize);
      new TextPanel("rn", xPos, yPos, xSizeS, halfY).setCol(128).render();
      cur = getE("rn");
      if(cur.isTimeSet()){
        new TextPanel(cur.time.toDate(), xPos, yPos + halfY, xSizeS, halfY).render();
      }
      
      fill(255);
      rect(xPos + xSizeS, yPos, xSizeS, ySize);
      new TextPanel("after", xPos + xSizeS, yPos, xSizeS, halfY).setCol(128).render();
      cur = getE("after");
      if(cur.isTimeSet()){
        new TextPanel(cur.time.toDate(), xPos + xSizeS, yPos + halfY, xSizeS, halfY).render();
      }
      /*
      if(undoActive){
        fill(250, 0, 0);
        rect(xPos + xSize - undoSize, yPos, undoSize, ySize);
      }*/
      
      
    } else {
      // room
      
      // start rn end after
      
      
      fill(255);
      rect(xPos, yPos, xSizeS, ySize);
      new TextPanel("start", xPos, yPos, xSizeS, halfY).setCol(128).render();
      cur = getE("start");
      if(cur.isTimeSet()){
        new TextPanel(cur.time.toDate(), xPos, yPos + halfY, xSizeS, halfY).render();
      }
      
      fill(255);
      rect(xPos + xSizeS, yPos, xSizeS, ySize);
      new TextPanel("rn", xPos + xSizeS, yPos, xSizeS, halfY).setCol(128).render();
      cur = getE("rn");
      if(cur.isTimeSet()){
        new TextPanel(cur.time.toDate(), xPos + xSizeS, yPos + halfY, xSizeS, halfY).render();
      }
      
      fill(255);
      rect(xPos + 2.0 * xSizeS, yPos, xSizeS, ySize);
      new TextPanel("end", xPos + 2.0 * xSizeS, yPos, xSizeS, halfY).setCol(128).render();
      cur = getE("end");
      if(cur.isTimeSet()){
        new TextPanel(cur.time.toDate(), xPos + 2.0 * xSizeS, yPos + halfY, xSizeS, halfY).render();
      }
      
      fill(255);
      rect(xPos + 3.0 * xSizeS, yPos, xSizeS, ySize);
      new TextPanel("after", xPos + 3.0 * xSizeS, yPos, xSizeS, halfY).setCol(128).render();
      cur = getE("after");
      if(cur.isTimeSet()){
        new TextPanel(cur.time.toDate(), xPos + 3.0 * xSizeS, yPos + halfY, xSizeS, halfY).render();
      }
      
      
      
      //new TextPanel(txt, xPos, yPos, xSize, ySize).render();
      
      
    }
    
    if(undoActive){
      fill(250, 0, 0);
      rect(xPos + xSize - undoSize, yPos, undoSize, ySize);
    }
    
    new TextPanel(txt, xPos, yPos, xSize, ySize).render();
    
    
  }
  
  public String getIfActivated(String start){
    //println("getIf " + txt);
    String rV = "";
    //if(tim != null){
      //rV += start + txt + "(";
    String[] entr = times.keySet().toArray(new String[0]);
    ArrayList<String> ts = new ArrayList<String>();
    for(int i = 0; i < entr.length; i ++){
      if(times.get(entr[i]).isTimeSet()){
        ts.add(entr[i]);
      }
    }
    
    if(ts.size() > 0){
      rV += start + txt + "(";
      for(int i = 0; i < ts.size(); i ++){
        rV += ts.get(i) + " " + times.get(ts.get(i)).time.toTime();
        if(i < ts.size() - 1){
          rV += eBar;
        }
      }
      rV += ")";
    }
      // + time.toTime() + ")";
    
    return rV;
  }
  
  /*
  public boolean tickButton(){
    //boolean rV = super.tickButton()
    tick();
    return super.tickButton();
  }*/
  
  public void tick(){
    //boolean rV = false;
    
    if(point) {
      
      
      //if(undoActive){
        
     // } else {
        if(mouseX < xPos + xSizeS){
          if(!getE("after").isTimeSet()){
            getE("rn").setTime();
           // undoActive = true;
          }
          
        } else if(mouseX < xPos + 2.0 * xSizeS){
          getE("after").setTime();
          //undoActive = true;
        } else {
          // well what was set when?
          // could do it logical but I have no test..
          // okay so I implement that too
          
          //if(getE("after").isTimeSet()){
          if(getE("after").undo()){
            // we can ignore that
            //if(!getE("rn").isTimeSet()){
             // undoActive = false;
            //}
          } else if(getE("rn").undo()){
            //undoActive = false;
          } else {
            
            println("sth went wrong in Event.tick(u pressed undo? although u shouldnt be able?)");
          }
          
          //testUndo();
          
        }
      
      
      
      
      
      
    } else {
      
      println("well " + txt);
      
        if(mouseX < xPos + xSizeS){
          if(!getE("rn").isTimeSet() && !getE("end").isTimeSet() && !getE("after").isTimeSet()){
            getE("start").setTime();
           // undoActive = true;
          }
          
        } else if(mouseX < xPos + 2.0 * xSizeS){
          if(!getE("end").isTimeSet() && !getE("after").isTimeSet()){
            getE("rn").setTime();
           // undoActive = true;
          }
        } else if(mouseX < xPos + 3.0 * xSizeS){
          if(!getE("after").isTimeSet()){
            getE("end").setTime();
           // undoActive = true;
          }
        } else if(mouseX < xPos + 4.0 * xSizeS){
          getE("after").setTime();
           // undoActive = true;
          
        } else {
          // well what was set when?
          // could do it logical but I have no test..
          // okay so I implement that too
          
          //if(getE("after").isTimeSet()){
          if(getE("after").undo()){
            // we can ignore that
            //if(!getE("rn").isTimeSet()){
             // undoActive = false;
            //}
          } else if(getE("end").undo()){
            //undoActive = false;
          } else if(getE("rn").undo()){
            //undoActive = false;
          } else if(getE("start").undo()){
            //undoActive = false;
          } else {
            
            println("sth went wrong in Event.tick(u pressed undo? although u shouldnt be able?)");
          }
        }
      
    }
    
    /*if(time == null){
      time = new Time();
      autoSave();
    } else if(mouseX > xPos + xSize - xSize / 12) {
      time = null;
      autoSave();
      
    }*/
    refreshS();
    useProc.doRender();
  }
  
  
  public boolean testUndo(){
    String[] entr = times.keySet().toArray(new String[0]);
    boolean rV = false; // = false
    // if(!false && !false && !false...)
    for(int i = 0; i < entr.length; i ++){
      if(getE(entr[i]).isTimeSet()){
        rV = true;
      }
      //rV = rV && !getE(entr[i]).isTimeSet();
      
      //println(txt + ": " + entr[i] + " " + rV);
    }
    
    //if(!rV){
     undoActive = rV;
     useProc.doRender();
     
   // }
    return undoActive;
  }
  
  
}


public class E {
  
  public E(Event sup, String keyy){
    this.sup = sup;
    this.keyy = keyy;
    
  }
  
  public void setTime(){
    if(!isTimeSet()){
      time = new Time();
      //autoSave();
      sup.undoActive = true;
      //println(sup ".undoAct");
    }
  }
  
  public Event sup;
  public String keyy;
  public Time time;
  
  
  public boolean isTimeSet(){
    return time != null;
  }
  
  public boolean undo(){
    boolean rV = false;
    if(isTimeSet()){
      time = null;
      rV = true;
      //autoSave();
      sup.testUndo();
    }
    return rV;
  }
}

/*ù9
  
  Event(point):
  now, after
  name(now time, after tim)
  
  
  Event(room):
  start, rn(x), end, after
  
  
  
*/

