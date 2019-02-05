public class Device extends UseProc{
  
  public Device(){
    super();
    
    String[] info = loadStrings(getBasalValues());
    devices = info[Integer.parseInt(info[0].split(": ")[1].split(", ")[3])].split(": ")[1].split(", ");
    
    ySize = height / (devices.length + 1);
  }
  
  String[] devices;
  
  float ySize;
  
  public void render(){
    for(int i = 0; i < devices.length; i ++){
      fill(250);
      rect(0, i * ySize, width, ySize);
      //println(devices[i]);
      new TextPanel(devices[i], 0, i * ySize, width, ySize).render();
    }
    
    fill(250);
    rect(0, height - ySize, width, ySize);
    new TextPanel(">", 0, height - ySize, width, ySize).render();
    
  }
  
  public void tickButtons(){
    int y = (int) (mouseY / ySize);
    try{
      device = devices[y];
    } catch (Exception e){
      
    }
    if(isMeter(device)){
      nextScreen(new Times1());
    } else {
      nextScreen(new BgValue());
    }
  }
  
  
}