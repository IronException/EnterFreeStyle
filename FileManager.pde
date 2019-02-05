
import android.os.Environment;
// permission: WRITE_EXTERNAL_STORAGE
public String getPath(){
  return android.os.Environment.getExternalStoragePublicDirectory(android.os.Environment.DIRECTORY_DCIM).getParentFile().getAbsolutePath() + "/CODING/static";
}

/*
NEWEST FILE HAS TO BE FIRST!!!

*/

boolean logDaily = false;

String[] nullInfo = new String[]{
        //"infos: 1, 10",
        "version: 1",
        "filesStart: 10",
        "logStart: 11",
        "desc: 10, 0",
        "daily: 0", // in files: only first, breaks and last
        "saveToday: 0",
        "file: 1",
        "name: ", // null = name = id
        "superPointer: ", // 1. is main rest is additional
        "fileEndung: txt", // not needed
        "c " + new Time().toDate(true, false) // c = creation; p = copy; n = new
        //""
        
      };
      
      /*
        for save:
          -act files + daily;
          -filePointer + log
          -keep creation + 1x log(moved)
      */


public class FileManager {
  /*
  public FileManager(){
    source = new Time();
    
  }*/
  
  public FileManager(Time creation, String name){
    this.source = creation;
    this.name = name;
    
    initSettings(source, name);
  }
  
  public FileManager(String[] path){
    if(isDiaLog(path)){
      source = new Time(29, 6, 2017);
    } else if(isAppInfo(path)){
      source = new Time(30, 6, 2017);
    } else if(isAccInfo(path)){
      source = new Time(30, 6, 2017);
    } else 
    
    {
      source = new Time();
    }
    name = path[path.length - 1];
    
    
    initSettings(source, name);
  }
  
  public void initSettings(Time creation, String name){
    createPath = toPath(creation) + "/created/" + name;
    //println("in " + createPath);
    isNev = false;
    String[] info;// = getStringData(toPath(creation) + "/created/" + name);
    try{
      info = loadStrings(createPath);
      //println(createPath + " loaded");
    } catch(Exception e){
      info = null;
    }
    if(info == null){
      info = nullInfo;
      
      
      isNev = true;
      // TODO creationFiles
      logger(new Time().toTime() + " SAVED(initSettings): " + info.length + " " + createPath);
      addCreation(source.toDate(true, false) + preName + " " + name);
      saveStrings(createPath, info);
    }
    
    int version = Integer.parseInt(info[0].split(": ")[1]);
    if(version != 1){
      
      String[] old = info;
      info = new String[old.length + 1];
      
      int ind = 3;
      
      info[0] = "version: 1";
      info[1] = "filesPos: " + (Integer.parseInt(old[1].split(": ")[1]) + 1);
      info[2] = "logPos: " + (Integer.parseInt(old[2].split(": ")[1]) + 1);
      
      for(int i = 3; i < ind; i ++){
        info[i] = old[i];
      }
      
      info[ind] = "desc: " + Integer.parseInt(old[1].split(": ")[1]) + ", 0";
      
      for(int i = ind; i < old.length; i ++){
        info[i + 1] = old[i];
      }
      
      logger(new Time().toTime() + " SAVED(initSettings): " + info.length + " " + createPath);
      saveStrings(createPath, info);
    }
    
    //try{
      println("initInfo: null cuz addFil()?");
      initInfoOptions(info);
    /*} catch(Exception e){
      e.printStackTrace();
      println(creation.toDate() + " " + name);
    }*/
    
    preName = "files/";
    if(saveToday){
      act = new Time();
      
      if(!act.equalsDate(fils[0].time)){
        addFil(new Fil("n " + act.toDate(true, false)));
      }
      
    } else {
      act = fils[0].time;
    }
    
    if(daily){
      act = new Time(); // cuz today
      preName += "daily/";
      //println("dale " + act.toDate());
      
      /*
        today? -> Idc
        e? -> yest? -> reset / add start
        s/c? -> yest? -> add end / rename n
        
      */
      
      boolean yest = false;
      if(fils[0].time.equalsDate(new Time().addTime(new Time(-1, 0, 0)))){
        yest = true;
      }
      
      if(act.equalsDate(fils[0].time)){
        // nothing
        //addFil(new Fil("e " + act.toDate(true, false)));
      } else if(yest){
        if(fils[0].type == 3){
          addFil(new Fil("e " + act.toDate(true, false)));
        } else if(fils[0].type == 4){
          renameFil(0, new Fil("e " + act.toDate(true, false)));
        }
        
      } else {
        addFil(new Fil("s " + act.toDate(true, false)));
      }
      //println("still " + act.toDate());
      /*if(fils[0].type == 3){ // s?
        if(yest){
          addFil(new Fil("e " + act.toDate(true, false)));
        } else {
          
          addFil(new Fil("s " + act.toDate(true, false)));
        }
      } else if(fils[0].type == 4){ // e?
        if(yest){
          
        } else {
          addFil(new Fil("s " + act.toDate(true, false)));
        }
      }*/
      
    }
    //println(act.toDate());
    filePath = toPath(act) + "/" + preName + name;
    
  }
  
  public void initInfoOptions(String[] info){
    //println("initInfoOptions-");
    
    daily = false;
    //println(info[3]);
    if(info[4].split(": ")[1].equals("1")){
      daily = true;
    }
    //println("daily " + daily);
    
    
    
    saveToday = false;
    if(info[5].split(": ")[1].equals("1") && !daily){
      saveToday = true;
      
    }
    
    //println("saveToday: " + saveToday);
    
    String[] sp = info[3].split(": ")[1].split(", ");
    int descPointer = Integer.parseInt(sp[0]);
    int descLen = Integer.parseInt(sp[1]);
    
    desc = new String[descLen];
    for(int i = 0; i < descLen; i ++){
      desc[i] = info[descPointer + i];
    }
    
    //println("descDome");
    
    int filPos = Integer.parseInt(info[1].split(": ")[1]);
    int logPos = Integer.parseInt(info[2].split(": ")[1]);
    
    //println(filPos + " " + logPos);
    
    fils = new Fil[logPos - filPos];
    //println(fils.length + " fils & info " + info.length);
    for(int i = filPos; i < logPos; i ++){
      //println("start: " + (i - filPos) + " " + i + ": " + info[i]);
      Fil cur = new Fil(info[i]);
      //println("its cur");
      fils[i - filPos] = cur;
      //println("finished");
    }
    
    //println("-initInfoOptions");
  }
  
  
  boolean isNev;
  
  
  Time source;
  String name;
  
  // options:
  boolean daily;
  boolean saveToday;
  Fil[] fils;
  String[] desc;
  boolean logI, logC;
  
  
  // file to edit
  String preName;
  Time act;
  
  //Folder folder;
  String createPath;
  String filePath;
  
  
  
  public void setDaily(boolean d){
    if(daily != d){
      daily = d;
      // setFile
    }
  }
  
  private void addFil(Fil nevF){
    Fil[] old = fils;
    fils = new Fil[old.length + 1];
    for(int i = 0; i < old.length; i ++){
      fils[i + 1] = old[i];
    }
    fils[0] = nevF;
    
    String[] info = getStringData(createPath);
    
    int filPos = Integer.parseInt(info[1].split(": ")[1]);
    int logPos = Integer.parseInt(info[2].split(": ")[1]);
    
    
    String[] nev = new String[info.length + 1];
    for(int i = 0; i < filPos; i ++){
      nev[i] = info[i];
    }
    
    nev[filPos] = nevF.getString();
    logger("saved Time: " + nevF.getString());
    
    for(int i = filPos; i < info.length; i ++){
      nev[i + 1] = info[i];
    }
    
    logPos ++;
    nev[2] = "logPos: " + logPos;
    
    
    logger(new Time().toTime() + " SAVED(addFil): " + nev.length + " " + createPath);
      
    saveStrings(createPath, nev);
  }
  
  public void renameFil(int ind, Fil f){
    fils[ind] = f;
    
    String[] info = getStringData(createPath);
    int filPos = Integer.parseInt(info[1].split(": ")[1]);
    info[filPos + ind] = f.getString();
    
    
    logger(new Time().toTime() + " SAVED(renameFil): " + info.length + " " + createPath);
      
    saveStrings(createPath, info);
  }
  
  public void setStringsIfNev(String[] data){
    if(isNev){
      setStrings(data);
    }
  }
  
  public String[] getStrings(){
    //println(filePath);
    String[] rV = getStringData(filePath);
    
    addInfo("openFileS(" + act.toDate(true, false) + preName + " " + name + ")", "");
    //addInfo(inf);
    //inf += ": (" + posAdd + " pos:size " + toAdd.length + ")";
    //addLog(inf);
    return rV;
  }
  
  public void setStrings(String[] info){
    
    String old;
    
    if(loadStrings(filePath) != null){
      //println("addSec");
      old = loadStrings(filePath).length + "";
      
      //info = new byte[0];
    } else {
      addDesc();
      old = "null";
    }
    
    
    
    //logger(new Time().toTime() + " SAVED(setStrings(filePath)): " + info.length);
      
    saveStrings(filePath, info);
    //println("setStrings");
    addInfo("setFileS(" + act.toDate(true, false) + preName + " " + name + ")", ": (" + old + " -> " + info.length + ")");
  }
  
  public byte[] getBytes(){
    byte[] rV = getByteData(filePath);
    
    if(logDaily && !daily){
      addInfo("openFileB(" + act.toDate(true, false) + preName + " " + name + ")", "");
    }
    
    return rV;
  }
  
  
  public void addBytes(byte[] toAdd, boolean atEnd){
    byte[] info = null;
    String path = filePath;
    /* folders:
          files
          created
          desc
    */
    
    //println(path);
    
    try{
      info = loadBytes(path);
    } catch(Exception e){}
    //println(info.length);
    if(info == null){
      //println("addSec");
      addDesc();
      
      info = new byte[0];
    }
    
    byte[] nev = new byte[info.length + toAdd.length];
    
    int posAdd = 0;
    int posInfo = toAdd.length;
    if(atEnd){
      posInfo = 0;
      posAdd = info.length;
    }
    
    for(int i = 0; i < info.length; i ++){
      nev[posInfo + i] = info[i];
    }
    
    for(int i = 0; i < toAdd.length; i ++){
      nev[posAdd + i] = toAdd[i];
    }
    
    //println(nev.length);
    logger("saveBytes(old: " + info.length + ", nev: " + nev.length);
    saveBytes(path, nev);
    // save in Fil
    
    if(logDaily || !daily){
      addInfo("addFileB(" + act.toDate(true, false) + preName + " " + name + ")", ": (" + posAdd + " pos:size " + toAdd.length + ")");
    }
  }
  
  
  public void addCreation(String path){
    //act.toDate(true, false) + preName + " " + name
    String cPath = getPath() + "/create.txt";
    String[] info = getStringData(cPath);
    if(info == null){
      info = new String[0];
    }
    
    String[] nev = new String[info.length + 1];
    for(int i = 0; i < info.length; i ++){
      nev[i + 1] = info[i];
    }
    nev[0] = path + " (" + new Time().toDate() + ")";
    
    
    saveStrings(cPath, nev);
  }
  
  public void addDesc(){
    String exPath = toPath(act) + "/desc.txt";
    String[] exInfo = getStringData(exPath);
    String[] nevInfo = new String[exInfo.length + 1];
    for(int i = 0; i < exInfo.length; i ++){
      nevInfo[i] = exInfo[i];
    }
    nevInfo[exInfo.length] = name + " " + new Time().toTime() + " " + source.toDate(true, false);
    logger("addSec");
    //logger(new Time().toTime() + " SAVED(addDesc): " + nevInfo.length);
      
    saveStrings(exPath, nevInfo);
  }
  
  
  
  public void addLog(String com){
    if(!logC){
      return;
    }
    
    //Time today = new Time();
    String line = new Time().toDate() + ": " + com;
    
    //String path = toPath(source) + "/created/" + name;
    String[] info = getStringData(createPath);
    //println("addLog(info): " + info.length);
    String[] nev = new String[info.length + 1];
    //nev[0] = line;
    for(int i = 0; i < info.length; i ++){
      nev[i] = info[i];
    }
    nev[nev.length - 1] = line;
    //println("addLog(info): -> " + nev.length + " " + nev[nev.length - 1]);
    logger(new Time().toTime() + " SAVED(addLog): " + nev.length + " " + createPath);
    
    saveStrings(createPath, nev);
  }
  
  
  public void addInfo(String inf, String add){
    if(logI){
      addTodayInfo(inf);
    }
    inf += add;
    addLog(inf);
  }
  
}


public class Fil{
  
  
  
  public Fil(String info){
    String[] sp = info.split(" ");
    
    type = -1;
    if(sp[0].equals("c")){
      type = 0;
    } else if(sp[0].equals("n")){
      type = 1;
    } else if(sp[0].equals("p")){
      type = 2;
    } else if(sp[0].equals("s")){
      type = 3;
    } else if(sp[0].equals("e")){
      type = 4;
    }
    
    time = new Time().setStringDate(sp[1]);
    
  }
  
  public Time time;
  public int type; // 0 = c / created; 1 = n / new; 2 = p / copy+paste
  
  public String getString(){
    String t = "";
    switch(type){
      case 0:
        t = "c";
        break;
      case 1:
        t = "n";
        break;
      case 2:
        t = "p";
        break;
      case 3:
        t = "s";
        break;
      case 4:
        t = "e";
        break;
      
      default:
        t = "?";
    }
    
    return t + " " + time.toDate(true, false);
  }
}


public String toPath(Time time){
  String path = getPath() + "/files/year";
    path += time.year + "/week";
    path += time.toWeek() + "/";
    path += time.toDate(true, false);
  return path;
}

public void addTodayInfo(String com){
  //if(!logI){
    //return;
  //}
  
  Time today = new Time();
  String line = today.toTime() + ": " + com;
  
  String path = toPath(today) + "/info.txt";
  String[] info = getStringData(path);
  String[] nev = new String[info.length + 1];
  nev[0] = line;
  for(int i = 0; i < info.length; i ++){
    nev[i + 1] = info[i];
  }
  //println("addTodayInfo(nev): " + nev.length);
  //logger(new Time().toTime() + " SAVED(addTodayInfo): " + nev.length);
      
  
  saveStrings(path, nev);
}
  
public String[] getStringData(String path){
  String[] rV = null;
  //String[] info = null;
  try{
    rV = loadStrings(path);
  } catch(Exception e){}
  if(rV == null){
    rV = new String[0];
  }
  return rV;
}
  
public byte[] getByteData(String path){
  byte[] rV = null;
  //String[] info = null;
  try{
    rV = loadBytes(path);
  } catch(Exception e){}
  if(rV == null){
    rV = new byte[0];
  }
  return rV;
}
  
  
  public String getName(byte[] info){//int len, int pointer){
    String rV = "";
    //int ind = pointer;
    //pointer.makeNibbleFirst();
    for(int i = 0; i < info.length; i ++){
      rV += (char) info[i];
      //ind ++;
    }
    return rV;
  }
  
  /*
  public int getIntValue(int nibbleNum, Pointer pointer){
    int rV = 0;
    for(int i = 0; i < nibbleNum; i ++){
      rV *= 128;
      rV += getNibble(info[pointer.pointer], pointer.nibbleFirst);
      
      pointer.nibbleAdd();
    }
    
    return rV;
  }
  */

  
public byte getNibble(byte data, boolean first){
    //a = info[ind];
    if(first){
      return (byte) (data >> 4); // test wether this 0x0F is needed
    }
    
    return (byte) (data & 0x0F);
}

public int getNibbleSize(int val){
  
  return val; // TODO
}

public byte[] int2Bytes(int val, int nibbles){
  int len = nibbles / 2;
  if(nibbles % 2 == 1){
    len ++;
  }
  byte[] rV = new byte[len];
  
  
  
  return rV;
}


public boolean isDiaLog(String[] path){
    boolean rV = true;
    String[] desired = new String[]{
      "", // root
      "home",
      "Dia",
      "diaLog.txt"
    };
    if(path.length != desired.length){
      return false;
    }
    for(int i = 0; i < path.length; i ++){
      if(!path[i].equals(desired[i])){
        rV = false;
      }
    }
    return rV;
}


public boolean isAppInfo(String[] path){
    boolean rV = true;
    String[] desired = new String[]{
      "", // root
      "home",
      "else",
      "appInfo.txt"
    };
    if(path.length != desired.length){
      return false;
    }
    for(int i = 0; i < path.length; i ++){
      if(!path[i].equals(desired[i])){
        rV = false;
      }
    }
    return rV;
}

public boolean isAccInfo(String[] path){
    boolean rV = true;
    String[] desired = new String[]{
      "", // root
      "home",
      "else",
      "sensors",
      "accInfo.txt"
    };
    if(path.length != desired.length){
      return false;
    }
    for(int i = 0; i < path.length; i ++){
      if(!path[i].equals(desired[i])){
        rV = false;
      }
    }
    return rV;
}

public void logger(String useless){}





