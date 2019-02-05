
import android.os.Vibrator;
import android.content.Context;

// permission: VIBRATE

import android.os.Environment;

// permission: WRITE_EXTERNAL_STORAGE
/*
public String getPath(){
  return Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).getParentFile().getAbsolutePath() + "/CODING";
}*/

public String getValues(){
  return getPath() + "/Dia/bg/freeStyle.txt";
}

public String getRes(String name){
  //return getPath() + "/Dia/pics/" + name;
  return name;
}

public String getBasalValues(){
  return getPath() + "/Dia/baseValues.txt";
}

public void vibrate(int millis){
  ((Vibrator) getActivity().getSystemService(Context.VIBRATOR_SERVICE)).vibrate(millis);
}


void setup(){
  fullScreen();
  accSetup();
  //println("setup()");
  
  //open = new Time();
  //resumed = false;
  
  //initEvents();
  
  // how many events on first page
  //firstEv = 7;
  // where change needle is
  //chNe1 = 3;
  // where on sec page change needle iss
  //chNe2 = 0;
  
  ppAcc = 3;
  
  
  neDeep = 2.0;
  
  neLeft = 3; // TODO load from save.... and then -1 cuz changed
  // TODO also removw neCh then...
  
  //neCh = false;
  // ppAcc > 9 -> change anything in tickPoke() + tickBack()... cuz its eiched for 1Place and not any
  
  // dhdhdjshsgdhdhhdd
  
  bgValue = 150;
  bgMmol = false;
  
  arrow = 3;
  /* 
  2, 1,
  0,
  -2, -1
  */
  device = "phoneLib";
  //device = "freeStyleLibre";
  
  actPp = "!meter";
  
  
  
  nextScreen(new Done());
}






/*
public void initEvents(){
  new Event[]{
    new Event("getStuff"),
    new Event("getTs"),
    new Event("insertTs"),
    new Event("changeNeedle"),
    new Event("poke"),
    new Event("apply"),
    new Event("read"),
    new Event("changeNeedle"),
    new Event("removeTs"),
    new Event("shutDown")
    // removeTs
    
  };
}*/

float neDeep;
//boolean neHalf;


//int firstEv;
//Event[] events;
String events1, events2;

int ppAcc;

//int chNe1, chNe2;

String actPp;


int neLeft;
//boolean neCh;
///^$&&$&$_$&$&;$;$$

UseProc useProc;
float start = 1;


//Time open;
//boolean resumed;

String device;

float bgValue;
boolean bgMmol;

int arrow;

void draw(){
  useProc.drawHelper();
}

ArrayList<UseProc> lastUseProc = new ArrayList<UseProc>();

public void nextScreen(UseProc nev){
  lastUseProc.add(useProc);
  useProc = nev;
}

public void backScreen(){
  useProc = lastUseProc.remove(lastUseProc.size() - 1);
  useProc.doRender();
}

void onResume(){
  //println("onResume()");
  accResume();
  //open = new Time();
  //resumed = true;
  try{
    useProc.setDoRender(true);
  }catch(Exception e){}
  super.onResume();
}

void onPause(){
  super.onPause();
  accPause();
}

public boolean isMeter(String meter){
  if(meter.equals("phone") ||
  meter.equals("freeStyleLibre") ||
  meter.equals("pphone") ||
  meter.equals("phoneLib") ||
  meter.equals("pphoneLib") ||
  
  meter.equals("pfrStL")){
    return false;
  }
  return true;
}