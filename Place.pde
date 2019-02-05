
public class Place extends UseProc{
  
  public Place(){
    
    actPp = "";
    state = 0;
    
    
    ySize = height / 6;
    yPos = height - ySize;
    
    yPlaceSize = yPos - ySize / 2;
    
    img = new HashMap<String, PImage>();
    
    setImg("hand.png");
    //println(width + " " + yPlaceSize);
    
  }
  
  int state;
  
  HashMap<String, PImage> img;
  PImage cur;
  
  float yPos, ySize, yPlaceSize;
  boolean renderPos;
  
  public void render(){
    renderPlace();
    renderButs();
    if(renderPos){
      renderPos();
      renderPos = false;
    }
  }
  
  public void renderButs(){
    float xSize = width / 2;
    fill(225);
    rect(0, yPos, xSize, ySize);
    rect(xSize, yPos, xSize, ySize);
    //fill(255, 0, 0);
    rect(0, yPlaceSize, width, ySize / 2);
    new TextPanel("<", 0, yPos, xSize, ySize).render();
    new TextPanel(">", xSize, yPos, xSize, ySize).render();
    new TextPanel("<^", 0, yPlaceSize, width, ySize / 2).render();
    
    
  }
  
  public void renderPos(){
    stroke(255, 0, 0);
    
    float spriX = mouseX;
    float spriY = mouseY;
    float spriS = width / 60;
    line(spriX - spriS, spriY - spriS, spriX + spriS, spriY + spriS);
    line(spriX - spriS, spriY + spriS, spriX + spriS, spriY - spriS);
    
    
    stroke(0);
  }
  
  public void renderPlace(){
    image(cur, 0, 0, width, yPlaceSize);
    
    new TextPanel(actPp, 0, 0, width, ySize).render();
    
    
  }
  
  
  
  public void tickPress(){
    
    if(state == 2 && mouseY < yPlaceSize){
      tickPoke();
    }
  }
  
  
  public void tickButtons(){
    if(mouseY > yPlaceSize){
      if(mouseY > yPos){
        if(mouseX < width / 2){
          backScreen();
        } else {
          nextScreen(new Times2());
        }
      } else {
        tickBack();
      }
    } else{
      switch(state){
        case 0:
          tickHand();
          break;
        case 1:
          tickFinger();
          break;
        case 2:
          //tickPoke();
          break;
        default:
        
      }
      //state ++;
    }
    
  }
  
  public void tickBack(){
    String nev = "hand.png";
    
    switch(state){
      case 0:
        // nev stays
        actPp = "";
        
        //state --;
        break;
      case 1:
        actPp = actPp.substring(0, 1);
        nev = actPp + "finger.jpg";
        
        state --;
        break;
      case 2:
        
        try{
          Integer.parseInt(actPp.substring(actPp.length() - 1, actPp.length()));
          // if we r still in try there was a int that we have to remove
          //nev = nev.substring(0, nev.length() - 1);
          println("does as suppoed?");
          nev = actPp.substring(0, actPp.length() - 1);
          //nev = actPp.substring(0, 1);
          println("still");
          
          actPp = nev;
          
          nev += ".jpg";
          
        } catch(Exception e){
          println("exception: " + e);
          //nev = actPp.substring(0, actPp.length() - 1);
          nev = actPp.substring(0, 1);
          
          actPp = nev;
          
          nev += "finger.jpg";
          state --;
        }
        
        //state --;
        break;
    }
    
    /*state --;
    if(state < 0){
      state = 0;
    }*/
    setImg(nev);
    doRender();
  }
  
  public void tickHand(){
    String nev = "R";
    if(mouseX < width / 2){
      nev = "L";
    }
    
    actPp = nev;
    
    nev += "finger.jpg";
    setImg(nev);
    state ++;
    doRender();
  }
  
  public void tickFinger(){
    String nev = actPp;
    int x = (int) (3 * mouseX / width);
    if(actPp.equals("R")){
      x = 2 - x;
    }
    switch(x){
      case 0:
        nev += "stink";
        break;
      case 1:
        nev += "ring";
        break;
      case 2:
        nev += "klein";
        break;
      default:
      
    }
    
    actPp = nev;
    
    nev += ".jpg";
    state ++;
    //img = loadImage(getRes(nev));
    setImg(nev);
    doRender();
  }
  
  public void tickPoke(){
    String nev = actPp;
    int y = (int) (ppAcc * mouseY / yPlaceSize);
    
    try{
      Integer.parseInt(nev.substring(nev.length() - 1, nev.length()));
      // if we r still in try there was a int that we have to remove
      nev = nev.substring(0, nev.length() - 1);
    } catch(Exception e){
      println("exception: " + e);
    }
       
    
    
    /*if(actPp.equals("R")){
      x = 2 - x;
    }*/
    /*switch(x){
      case 0:
        nev += "stink";
        break;
      case 1:
        nev += "ring";
        break;
      case 2:
        nev += "klein";
        break;
      default:
      
    }*/
    nev += 3 - y;
    
    actPp = nev;
    renderPos = true;
    
    //nev += ".jpg";
    //state ++;
    //img = loadImage(getRes(nev));
    doRender();
    
    
    //nextScreen(new Times(true));
  }
  
  
  
  public void setImg(String name){
    //=cur = img.get(name);
    if(img.get(name) == null){
      img.put(name, loadImage(getRes(name)));
      
    }
    cur = img.get(name);
    
  }
  
}