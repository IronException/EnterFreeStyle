public class Times1 extends UseProc{
  
  
  // neCh = wether leftNeedles r eingetragen...
  
  
  public Times1(){
    
    
    initMeter(device);
    
    
    events = new EventManager();
    
    
    eves = new Button[]{
      events.get("getStuff"),
      events.get("getTs"),
      events.get("insertTs"),
      events.get("changeNeedle").setPoint(true), // ?
      events.get("changeDeep").setPoint(true), // ?
      events.get("poke"),
      events.get("apply"),
      events.get("read").setPoint(true),
      
      
      new Button().setTxt("<"),
      new Button().setTxt(">")
      
    };
    
    float ySize = height / (eves.length - 1);
    
    for(int i = 0; i < eves.length; i ++){
      eves[i].setPosSize(0, i * ySize, width, ySize);
      //ind ++;
    }
    
    int len = eves.length;
    float xSize = width / 2.0;
    
    eves[len - 2].setPosSize(0, (len - 2) * ySize, xSize, ySize);
    eves[len - 1].setPosSize(xSize, (len - 2) * ySize, xSize, ySize);
    
    
    
    
    
    
  }
  
  EventManager events;
  
  Button[] eves;
  
  
  
  
  public void render(){
    
    for(int i = 0; i < eves.length; i ++){
      eves[i].render();
      //ind ++;
    }
    
    
    float ySi = eves[0].ySize / 2.0;
    new TextPanel("depf: " + neDeep, 0, height - ySi, width, ySi).render();
    
    //f(neCh){
      
      new TextPanel("neLeft: " + neLeft, 0, height - 2.0 * ySi, width, ySi).render();
      
    //}
    
  }
  
  public void tickButtons(){
    for(int i = 0; i < eves.length; i ++){
      if(eves[i].tickButton()){
        if(eves[i].getTxt().equals("read") || eves[i].getTxt().equals(">")){
          events1 = events.getData();
          
          nextScreen(new BgValue());
        } else if(eves[i].getTxt().equals("<")){
          nextScreen(new Device());
        } else if(eves[i].getTxt().equals("changeNeedle")){
          nextScreen(new NeLeft());
        } else if(eves[i].getTxt().equals("changeDeep")){
          nextScreen(new NeDeep());
        }
        
        
        
        
      }
      //ind ++;
    }
    
    
  }
  
  
}


public void initMeter(String dev){
  String path = getPath() + "/Dia/bg/meters.txt";
  String[] info = null;
  try{
    info = loadStrings(path);
  } catch(Exception e){}
  if(info == null){
    info = new String[0];
  }
  
  String[] sp;
  // dev -> things
  HashMap<String, String> things = new HashMap<String, String>();
  for(int i = 0; i < info.length; i ++){
    sp = info[i].split(": ");
    things.put(sp[0], sp[1]);
  }
  
  String sth = things.get(dev);
  if(sth == null){
    sth = "3:2";
  }
  
  sp = sth.split(":");
  
  neLeft = Integer.parseInt(sp[0]);
  neDeep = Float.parseFloat(sp[1]);
  
  
  
  
}


