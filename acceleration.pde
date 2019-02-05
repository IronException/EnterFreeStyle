

public byte[] int2b(int value){
  return java.nio.ByteBuffer.allocate(4).putInt(value).array();
}
import java.nio.ByteBuffer;


class AccSens implements SensorEventListener {  
  public void onSensorChanged(SensorEvent event) {   
    acc[0] = event.values[0]; 
    acc[1] = event.values[1];  
    acc[2] = event.values[2];
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) {
    acc[3] = accuracy;
  }
}

public byte[] float2b(float[] values){
  ByteBuffer buffer = ByteBuffer.allocate(4 * values.length);
  for (float value : values){
    buffer.putFloat(value);
  }
  return buffer.array();
}



float[] acc;

import android.content.Context;
import android.hardware.Sensor; 
import android.hardware.SensorManager; 
import android.hardware.SensorEvent; 
import android.hardware.SensorEventListener;


//SystemClock
import android.os.SystemClock;




public void addAccSave(byte[] data){
  if(acI == null){
  String[] path = new String[]{
    "", // root
    "home",
    "else",
    "sensors",
    "accInfo.txt"
    
  };
  //Time act = new Time();
  //return getPath() + "/files/year" + year() + "/week" + act.toWeek() + "/" + act.toDate(true, false) + "/appInfo.txt";
    acI = new FileManager(path);
    acI.setDaily(true);
    
    
    
  }
  
  //println("save Acc: " + acI);
  
  
  acI.addBytes(data, false);
  
  
}

FileManager apI, acI;

public void addAppInfo(byte[] data){
  if(apI == null){
    String[] path = new String[]{
      "", // root
      "home",
      "else",
      "appInfo.txt"
      
    };
    
    
    apI = new FileManager(path);
  }
  
  
  apI.addBytes(data, false);
}

public String[] getSettings(){
  //println("get");
  FileManager f = new FileManager(new Time(30, 6, 2018), "appInfoSet.txt");
  //println("loaded");
  String[] rV; // = f.getStrings();
  //if(rV == null || 
  rV = loadStrings(getPath() + "/files/year2018/week27/20180706-27FRFR/files/appInfoSet.txt");
  println("getSettings() WARNING: using absolute Path!!!");
  
  //println(rV.length);
  return rV; //getPath() + "/else/appInfo.txt";
}

public void saveSettings(String[] info){
  println("CHANGED APP-INFO-SETTINGS: " + info.length);
  // UNDO THIS COMMENT new FileManager(new Time(30, 6, 2018), "appInfoSet.txt").setStrings(info);
  println("used AbsolutePath !!!! WARNING");
  saveStrings(getPath() + "/files/year2018/week27/20180706-27FRFR/files/appInfoSet.txt", info);
}



public void initAcc(){
  SensorManager manager;
  Sensor sensor;
  AccSens listener;
  
  saves = new ArrayList<byte[]>();
  acc = new float[4];
  appName = getAppConverter();
  //len = 4;
  
  
  
  manager = (SensorManager) getActivity().getSystemService(Context.SENSOR_SERVICE); 
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  listener = new AccSens();
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
}

// shhdgdgdhdhdhdhdhdhdhddhdhhd
// warzondhdhdhfhjdjdjdhdhdhdhdhdhdh



public void autoAcc(){
  while(true){
    saveAcc();
    //println("autoAcc: " + new Time().toTime());
    SystemClock.sleep(pauseAcc);
  }
  //println("ended AutoAcc");
}

public void autoSave(){
  while(true){
    //addSave(-1);
    flush("autoSave");
    //println("autoSave: " + new Time().toTime());
    SystemClock.sleep(pauseSave);
  }
  //println("ended AutoSave");
}

// nextLayer dhdhdhdhdhdhdhdhdhdhdhdhdhdhd

public void saveAcc(){
  byte[] rV = new byte[12];
  byte[] val;
  if(last != acc[3]){
    val = float2b(new float[]{acc[3]});
    for(int j = 0; j < val.length; j ++){
      rV[j] = val[j];
    }
    addSave(rV, event.get("sensor"));
    last = acc[3];
  }
  
  
  for(int i = 0; i < 3; i ++){
    val = float2b(new float[]{acc[i]});
    for(int j = 0; j < val.length; j ++){
      rV[i * val.length + j] = val[j];
    }
  }
  // time : data
  
  addSave(rV, event.get("acc"));
}


public void addSave(byte[] values, byte id){
  byte[] rV = new byte[dataLength];
  byte[] cur = new Time().getByteTime(id);
  for(int i = 0; i < cur.length; i ++){
    rV[i] = cur[i];
  }
  
  for(int i = 0; i < values.length; i ++){
    rV[cur.length + i] = values[i];
  }
  
  //println("addSave: " + rV.length);
  saves.add(rV);
}


public void addAppSave(byte[] values, byte id){
  byte[] rV = new byte[dataAppLength];
  byte[] cur = new Time().getByteTime(id);
  for(int i = 0; i < cur.length; i ++){
    rV[i] = cur[i];
  }
  
  for(int i = 0; i < values.length; i ++){
    rV[cur.length + i] = values[i];
  }
  
  addAppInfo(rV);
  
  //saves.add(rV);
}

float last;
int dataAppLength;

ArrayList<byte[]> saves;
HashMap<String, Byte> event;

// gghhffghjehdhdhdhrhrjrururururur

public void addSave(String eventName){
  String appN = this + "";
  byte[] rV = appName.get(appN); // = appName
  if(rV == null){
    String[] info = getSettings();
    int ind = Integer.parseInt(info[0].split(": ")[1]);
    
    int id = info.length - ind;
    String[] nev = new String[info.length + 1];
    for(int i = 0; i < info.length; i ++){
      nev[i] = info[i];
    }
    
    rV = int2b(id);
    appName.put(appN, rV);
    nev[nev.length - 1] = appN + ":%: " + rV[0];
    for(int i = 1; i < rV.length; i ++){
      nev[nev.length - 1] += ":" + rV[i];
    }
    saveSettings(nev);
    
  }
  
  byte ev = event.get(eventName);
  rV[0] = ev;
  
  addAppSave(rV, ev);
}

public HashMap<String, byte[]> getAppConverter(){
  HashMap<String, byte[]> appName = new HashMap<String, byte[]>();
  String[] info = getSettings();
  //println(info.length);
  //println(info[0]);
  int ind = Integer.parseInt(info[0].split(": ")[1]);
  String[] sp;
  String[] bu;
  byte[] byt;
  for(int i = ind; i < info.length; i ++){
    //println("here: " + info[i]);
    sp = info[i].split(":%: ");
    bu = sp[1].split(":");
    byt = new byte[bu.length];
    for(int j = 0; j < bu.length; j ++){
      byt[j] = Byte.parseByte(bu[j]);
    }
    appName.put(sp[0], byt);
  }
  //rV.put(this + "", null);
  
  pauseSave = Integer.parseInt(info[1].split(": ")[1]);
  pauseAcc = Integer.parseInt(info[2].split(": ")[1]);
  last = Float.parseFloat(info[3].split(": ")[1]);
  
  // also times + events
  initImportant();
  return appName;
}

HashMap<String, byte[]> appName;

int pauseSave, pauseAcc;

public void initImportant(){
  //pauseSave = 60000;
  //pauseAcc = 30000;
  
  event = new HashMap<String, Byte>();
  event.put("resume", (byte) 3); // app
  event.put("setup", (byte) 4); // app
  event.put("autoSave", (byte) 1); // app
  event.put("acc", (byte) 0); // data
  event.put("pause", (byte) 2); // app
  event.put("sensor", (byte) 5); // data + app?
  
  dataLength = 15; // 3 Time + 3x 4 acc
  
  dataAppLength = 3 + 4; // Time + appName (but first bye is id again)
}

int dataLength;

// dhhdhdhddhhdjdjddjjdjfhfjfjfjfjfjf

public void flush(String eventName){
  //println("flush.start()");
  addSave(eventName);
  // time : eventName : appName
  
  // id : time : 4 : 4 : 4
  
  /*byte[] info;
  try{
    info = loadBytes(getAccSave());
  } catch(Exception e){
    info = new byte[0];
  }
  
  byte[] nev = new byte[info.length + saves.size() * dataLength];*/
  
  //println("toAdd.start()");
  
  byte[] cur;
  byte[] toAdd = new byte[saves.size() * dataLength];
  for(int i = 0; i < saves.size(); i ++){
    cur = saves.get(saves.size() - 1 - i);
    //println("cur (" + i + "): " + cur.length);
    for(int j = 0; j < dataLength; j ++){
      //nev[i * dataLength + j] = cur[j];
      toAdd[i * dataLength + j] = cur[j];
    }
  }
  
  //println("toAdd done: " + toAdd.length);
  /*
  for(int i = 0; i < info.length; i ++){
    nev[saves.size() * dataLength + i] = info[i];
  }*/
  
  //saveBytes(getAccSave(), nev);
  saves = new ArrayList<byte[]>();
  
  addAccSave(toAdd);
}


public void accSetup(){
  initAcc();
  addSave("setup");
  thread("autoAcc");
  thread("autoSave");
}

public void accResume(){
  try{
    addSave("resume");
    saveAcc();
  }catch(Exception e){}
}



public void accPause(){
  //println("pause " + new Time().toTime(true));
  saveAcc();
  //addSave("pause");
  flush("pause");
}


