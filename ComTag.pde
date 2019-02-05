

public String getTagInfo(){
  return getTags() + "information.txt";
}

public String getTags(){
  return getPath() + "/Tags/";
}


public class ComTag extends UseProc {
  
  public ComTag(){
    super();
    
    xSize = width / 2;
    
    tagSize = width / 3;
    
    ySaveSize = height / 6;
    ySavePos = height - ySaveSize;
    
    saveTxt = new TextPanel[2];
    saveTxt[0] = new TextPanel("<", 0, ySavePos, xSize, ySaveSize);
    saveTxt[1] = new TextPanel("save", xSize, ySavePos, xSize, ySaveSize);
    
    String[] info = loadStrings(getTagInfo());
    
    tags = new Tag[info.length];
    for(int i = 0; i < tags.length; i ++){
      tags[i] = new Tag(info[i]);
    }
    
    tagInd = 0;
  }
  
  float tagSize;
  
  float xSize;
  
  float ySavePos;
  float ySaveSize;
  TextPanel[] saveTxt;
  
  
  float xTagPos;
  int tagInd;
  Tag[] tags;
  
  float xMousePos;
  
  public void render(){
    background(225);
    renderTags();
    
    renderSave();
  }
  
  public void renderTags(){
    for(int y = 0; y < 3; y ++){
      for(int x = 0; x < 4; x ++){
        fill(255);
        rect(xTagPos + x * tagSize, y * tagSize, tagSize, tagSize);
        //new TextPanel((tagInd * 3 + x * 3 + y) + "", xTagPos + x * tagSize, y * tagSize, tagSize, tagSize).render();
        
        try{
          tags[tagInd * 3 + x * 3 + y].render(xTagPos + x * tagSize, y * tagSize, tagSize);
        } catch(Exception e){
          
        }
      }
    }
    
  }
  
  public void renderSave(){
    fill(225);
    rect(0, ySavePos, xSize, ySaveSize);
    rect(xSize, ySavePos, xSize, ySaveSize);
    
    saveTxt[0].render();
    saveTxt[1].render();
  }
  
  public void tickButtons(){
    if(mouseY < width){
      int x = 3 * mouseX / width;
      int y = 3 * mouseY / width;
      try{
        tags[tagInd * 3 + x * 3 + y].tick();
        
        coolActivate();
      } catch(Exception e){}
      
    }
    
    if(mouseY > ySavePos){
      if(mouseX < xSize){
        back();
      } else {
        sace();
        
      }
    }
  }
  
  public void tickPress(){
    if(mouseX < 3 * tagSize){
      //float change = 
      xTagPos += mouseX - xMousePos;
      if(xTagPos > 0){
        xTagPos -= tagSize;
        tagInd --;
        if(tagInd < 0){
          tagInd ++;
          xTagPos = 0;
        }
      } else if(xTagPos < -tagSize){
        xTagPos += tagSize;
        tagInd ++;
        if(tagInd + 3 > (tags.length - 1) / 3){
          tagInd --;
          xTagPos = -tagSize;
        }
      }
      setDoRender(true);
    
    }
    
    xMousePos = mouseX;
  }
  
  
  public void tickPressStart(){
    xMousePos = mouseX;
  }
  
  public String getTags(){
    String rV = "";
    for(int i = 0; i < tags.length; i ++){
      rV += tags[i].getNameIf(", ");
    }
    return rV;
  }
  
  
  public void tick(){
    
    sace();
  }
  
  
}



public class Tag{
  
  
  public Tag(String info){
    // name:3:2
    //name:disNums:actNums
    int rand;
    
    String[] sp = info.split(":");
    //println(sp.length);
    name = sp[0];
    if(sp[1].length() == 0){
      dis = createImage(2, 2, RGB);
    } else {
      rand = (int) random(Integer.parseInt(sp[1]));
      rand ++;
      dis = loadImage(getTags() + name + "" + rand + ".png");
      //println(dis);
      if(dis == null){
        dis = createImage(2, 2, RGB);
      }
    }
    
    if(sp[2].length() == 0){
      act = createImage(2, 2, RGB);
    } else {
      rand = (int) random(Integer.parseInt(sp[2]));
      rand ++;
      act = loadImage(getTags() + name + "-" + rand + ".png");
      if(act == null){
        act = createImage(2, 2, RGB);
      }
    }
    
  }
  
  //int disNum;
  //int actNum;
  
  String name;
  
  PImage dis;
  PImage act;
  
  boolean active;
  
  public void render(float xPos, float yPos, float size){
    //fill(255);
    //rect(xPos, yPos, size, size);
    
    if(active){
      image(act, xPos, yPos, size, size);
    } else{
      image(dis, xPos, yPos, size, size);
    }
  }
  
  public void tick(){
    active = !active;
  }
  
  public String getNameIf(String betw){
    String rV = "";
    if(active){
      rV = name + betw;
    }
    return rV;
  }
  
  
}



public void sace(){
  String[] info = null;
  try{
    info = loadStrings(getValues());
  } catch(Exception e){}
  if(info == null){
    info = new String[0];
  }
  
  
  String[] nev = new String[info.length + 1];
  for(int i = 0; i < info.length; i ++){
    nev[i + 1] = info[i];
  }
  nev[0] = getData();
  saveStrings(getValues(), nev);
  // TODO reenable that ^
  
  nextScreen(new Done());
  device = "pphoneLib";
  //device = "pfrStL";
}

public void back(){
  //useProc = new Arrow();
  backScreen();
}



public String getData(){
  String bar = ":";
  String rV = "";
  rV += new Time().toDate(true, true);
  /*
  rV += bar;
  if(resumed){
    rV += "resumed ";
  } else {
    rV += "open ";
  }
  rV += open.toDate(true, true, true);
  is in appInfo.txt + more*/
  
  rV += bar;
  rV += "dev " + device;
  
  rV += bar;
  rV += "unit ";
  if(bgMmol){
    rV += "mmol/L";
    rV += bar;
    rV += "bg " + bgValue;
  } else {
    rV += "mg/dL";
    rV += bar;
    rV += "bg " + ((int) bgValue);
  }
  
  if(isMeter(device)){
    //
    rV += bar + events1;
    
    rV += bar + events2;
    
    //if(neCh){
    rV += bar;
    rV += "needlesLeft " + neLeft;
    //}
    
    rV += bar;
    rV += "neDeep " + neDeep;
    
    rV += bar;
    rV += "actPP " + actPp;
    
    
    saveAssets(device);
    
  }
  if(!isMeter(device) || arrow != 3){
    rV += bar;
    rV += "arr " + arrow;
  }
  
  rV += bar;
  rV += ((ComTag) useProc).getTags();
  return rV;
}


public void saveAssets(String dev){
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
  /*
  String sth = things.get(dev);
  if(sth == null){
    sth = "3:2";
  }*/
  
  //sp = sth.split(":");
  
  //neDeep = Float.parsesp[1];
  
  things.put(dev, neLeft + ":" + neDeep);
  
  
  String[] entr = things.keySet().toArray(new String[0]);
  for(int i = 0; i < entr.length; i ++){
    entr[i] += ": " + things.get(entr[i]);//info[i].split(": ");
    //things.put(sp[0], sp[1]);
  }
  saveStrings(path, entr);
}

