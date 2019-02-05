public class Arrow extends UseProc{
  
  
  public Arrow(){
    super();
    
    arrow = 3;
    
    ySize = height / 4;
    yButtonsPos = height - ySize;
    
    xButSize = width / 3;
    
    
    texts = new TextPanel[4];
    texts[0] = new TextPanel("->", 0, 1 * ySize, width, ySize);
    texts[1] = new TextPanel("<", 0, 3 * ySize, xButSize, ySize);
    texts[2] = new TextPanel("-3", xButSize, 3 * ySize, xButSize, ySize);
    texts[3] = new TextPanel("save", 2 * xButSize, 3 * ySize, xButSize, ySize);
    
    xSize = width / 2;
    
    timer = -1;
    
    arrows = new PImage[4];
    arrows[0] = loadImage(getRes("dropping.png"));
    arrows[1] = loadImage(getRes("falling.png"));
    arrows[2] = loadImage(getRes("rising.png"));
    arrows[3] = loadImage(getRes("shooting.png"));
    
  }
  
  float ySize;
  float xSize, xButSize;
  float yButtonsPos;
  
  TextPanel[] texts;
  PImage[] arrows;
  
  int timer;
  
  public void render(){
    background(0);
    fill(255);
    rect(0, 3 * ySize, xButSize, ySize);
    rect(xButSize, 3 * ySize, xButSize, ySize);
    rect(2 * xButSize, 3 * ySize, xButSize, ySize);
    
    
    if(timer > 0){
      //timer --;
      fill(250);
      rect(0, 0, width, 3 * ySize);
      
      switch(arrow){
        case -2:
          image(arrows[0], 0, 2 * ySize, xSize, ySize);
          break;
        case -1:
          image(arrows[1], xSize, 2 * ySize, xSize, ySize);
          
          break;
        case 0:
          texts[0].render();
          break;
        case 1:
          image(arrows[2], xSize, 0, xSize, ySize);
          
          break;
        case 2:
          image(arrows[3], 0, 0, xSize, ySize);
          
          break;
        case 3:
          stroke(255, 0, 0);
          
          line(0, 0, width, width);
          line(0, width, width, 0);
          
          stroke(0);
          break;
        
      }
      
    } else {
      fill(255);
      rect(0, ySize, width, ySize);
      
      fill(230);
      rect(xSize, 0, xSize, ySize);
      rect(xSize, 2 * ySize, xSize, ySize);
      
      
      fill(205);
      rect(0, 0, xSize, ySize);
      rect(0, 2 * ySize, xSize, ySize);
      
      texts[0].render();
      image(arrows[0], 0, 2 * ySize, xSize, ySize);
      image(arrows[1], xSize, 2 * ySize, xSize, ySize);
      image(arrows[2], xSize, 0, xSize, ySize);
      image(arrows[3], 0, 0, xSize, ySize);
      
    }
    
    
    texts[2] = new TextPanel(arrow + "", width / 3, 3 * ySize, width / 3, ySize);
    
    
    // imgs
    for(int i = 1; i < texts.length; i ++){
      texts[i].render();
    }
    
  }
  
  public void tickButtons(){
    
    /*if(chosen){
      
      
    }*/
    if(mouseY < 3 * ySize){
      if(mouseY < 2 * ySize){
        if(mouseY < ySize){
          if(mouseX < xSize){
            arrow = 2;
          } else {
            arrow = 1;
          }
        } else {
          arrow = 0;
        }
      } else {
        if(mouseX < xSize){
          arrow = -2;
        } else {
          arrow = -1;
        }
      }
      //next(24);
      doRender();
    } else {
      if(mouseX < xButSize){
        backScreen();
      } else if(mouseX < 2 * xButSize){
        arrow = -3;
        doRender();
      } else {
        //arrow = -3;
        next(10);
      }
    }
    
    
  }
  
  public void tick(){
    if(timer > 0){
      timer --;
    } else if(timer == 0){
      timer --;
      nextScreen(new ComTag());
    }
  }
  
  public void next(int wait){
    timer = wait;
    setDoRender(true);
    //nextScreen(new ComTag();
  }
  
  
}