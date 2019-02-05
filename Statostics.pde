public class Done extends UseProc {
  
  public Done(){
    super();
    
    
    //String[] info = loadStrings(getValues());
    Time toWait = new Time(0, 0, 0, 6, 15, 30);
    float ySize = height / 4;
    
    
    lastFreeStyle = new Time();
    lastPhone = new Time();
    
    nextFreeStyle = new Time(lastFreeStyle).addTime(toWait);
    nextPhone = new Time(lastPhone).addTime(toWait);
    
    fs = new TimeCounter();
    fs.setToWait(toWait);
    //fs.start();
    fs.setStart(lastFreeStyle);
    fs.setPosSize(0, 1 * ySize, width, ySize);
    
    p = new TimeCounter();
    //fs = new Countdown();
    p.setToWait(toWait);
    //fs.start();
    p.setStart(lastPhone);
    p.setPosSize(0, 3 * ySize, width, ySize);
    
    
    thread("setTimes");
    
    
  }
  
  int dayLength;
  
  int[] xPos;
  int[] yPos;
  
 // Countdown fs, p;
  
  
  public void tick(){
    fs.tick();
    
    p.tick();
    //doRender();
  }
  
  public void render(){
    background(225);
    
    
    float ySize = height / 4;
    String txt;
    
    fs.render();
    p.render();
    
    try{
    txt = "lastFS: " + lastFreeStyle.toDate();
    new TextPanel(txt, 0, 0 * ySize, width, ySize).render();
    
    //txt = nextFreeStyle.subTime(new Time()).toDate();
   // new TextPanel(txt, 0, 1 * ySize, width, ySize).render();
    
    txt = "lastP: " + lastPhone.toDate();
    new TextPanel(txt, 0, 2 * ySize, width, ySize).render();
    
    //txt = nextPhone.subTime(new Time()).toDate();
    //new TextPanel(txt, 0, 3 * ySize, width, ySize).render();
    } catch(Exception e){
      // nullpointer cuz nebenthread
    }
    
    
  }
  
  public void tickButtons(){
    
    //initEvents();
    nextScreen(new BgValue());
  }
}


Time lastFreeStyle, lastPhone;
Time nextFreeStyle, nextPhone;
TimeCounter fs, p;

Time a, b;

public void setTimes(){
  
  String[] info = loadStrings(getValues());// new FileManager(new String[]{"Dia", "bg", "freeStyle.txt"}).getStrings();
  
  a = null;
  b = null;
  
  
  
  int i = 0;
  boolean running = i < info.length;
  //println(info.length);
  //println(new Time().toDate());
  
  while(running){
    
    setIf(info[i]);
    
    
    i ++;
    running = i < info.length;
    running = running && ((a == null) || (b == null));
  }
  
  if(a == null){
    a = new Time();
  }
  
  
  if(b == null){
    b = new Time();
  }
  
  lastFreeStyle = a;
  lastPhone = b;
  
  fs.setStart(lastFreeStyle);
  p.setStart(lastPhone);
  
  nextFreeStyle = new Time(lastFreeStyle).addTime(new Time(0, 0, 0, 8, 0, 0));
  nextPhone = new Time(lastPhone).addTime(new Time(0, 0, 0, 8, 0, 0));
  
  //println("setTimes done");
  
  
  
}


public void setIf(String info){
  String[] sp = info.split(":");
  for(int i = 0; i < sp.length; i ++){
    //println(sp[i]);
    if(sp[i].split(" ")[0].equals("dev")){
      //println("finds");
      try{
        String dev = sp[i].split(" ")[1];
        
        if(dev.equals("freeStyleLibre") && a == null){
          a = getTime(sp[0]);
        } else if((dev.equals("phone")
         || dev.equals("pphone")
         || dev.equals("phoneLib")
         || dev.equals("pphoneLib"))
         && b == null){
          b = getTime(sp[0]);
        }
        
        
      } catch(Exception e){
        
      }
    }
    
  }
  
  
  
}

public Time getTime(String data){
  //println("and getTime");
  Time rV = new Time();
  //println(data);
  rV.setDate(data, "normal");
  //println(rV.toDate());
  
  return rV;
}