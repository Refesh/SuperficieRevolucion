PShape figure;
ArrayList<int[]> vertex = new ArrayList<int[]>();
boolean created = false;
boolean freeze = false;

int lastX = 0;
int lastY = 0;
float scale = 0.8;
int nStripes = 40;

boolean menuOn = true;

void setup() {
  size(850, 650,P3D);
  
  initFigure();
  stroke(255, 255, 255);
  strokeWeight(5);
}

void draw() {
  background(0);
  
  if (menuOn){
    menuOnScreen();
    return ;
  }
  
  fill(255, 255, 255);
  textSize(13);
  text("Click R to reset", 20, 20);
  
  if(created) figureScreen();
  else drawScreen();
}

void initFigure(){
  figure=createShape();
  figure.beginShape(TRIANGLE_STRIP);
  figure.fill(102);
  figure.stroke(255);
  figure.strokeWeight(2);
}

void createVertex(){
  for(int j = 0; j < nStripes; j++){
    if(j%2 == 0){
      for(int i = 0; i < vertex.size(); i++){
        figure.vertex(vertex.get(i)[0]*cos((2*PI/nStripes)*j), vertex.get(i)[1], vertex.get(i)[0]*sin((2*PI/nStripes)*j));
        figure.vertex(vertex.get(i)[0]*cos((2*PI/nStripes)*(j + 1)), vertex.get(i)[1], vertex.get(i)[0]*sin((2*PI/nStripes)*(j + 1)));
      }
    }else
      for(int i = vertex.size() - 1; i >= 0; i--){    
        figure.vertex(vertex.get(i)[0]*cos((2*PI/nStripes)*(j+1)), vertex.get(i)[1], vertex.get(i)[0]*sin((2*PI/nStripes)*(j+1)));
        figure.vertex(vertex.get(i)[0]*cos((2*PI/nStripes)*j), vertex.get(i)[1], vertex.get(i)[0]*sin((2*PI/nStripes)*j));
      }
  } 
  figure.endShape();
}

void menuOnScreen(){
  textSize(22);
  fill(255, 255, 255);
  text("Draw a profile (in the right half)", 235, 220);
  text("when you have finished you could show", 205, 250);
  text("the solid of revolution of said profile", 230, 280);
  strokeWeight(2);
  line(200, 305, width-200, 305);
  text("By clicking in any point a line will be draw", 200, 350);
  textSize(35);
  fill(255, 120, 1);
  text("Click any key to start", 250, height-230);
  noFill();
  rect(150, 160, 550, 320);
}

void drawScreen(){
    stroke(255, 255, 255);
    line(width/2-2, 0, width/2 -2, height);
    if (isMouseOnButton()) fill(47, 60, 60);
    else fill(0, 0, 0);
    rect(125, height-91, 200, 50);
    for(int i = 0; i < vertex.size() - 1; i++){
        line(vertex.get(i)[0] + width/2, vertex.get(i)[1] + height/2, vertex.get(i+1)[0] + width/2, vertex.get(i+1)[1] + height/2);
    }
    if(vertex.size() > 0) line(vertex.get(vertex.size()-1)[0] + width/2, vertex.get(vertex.size()-1)[1] + height/2, max(mouseX, width/2), mouseY);
    stroke(255, 255, 0);
    fill(255, 255, 0);
    circle(max(mouseX, width/2-2), mouseY, 3);
    textSize(22);
    fill(255, 120, 1);
    text("Display result", 150, height-60);
    fill(255, 255, 255);
    text("Draw in this side", height - 104, 40);
}

void figureScreen(){
  text("Space to freeze/unfreeze figure", 20, 40);
  text("Mouse wheel to zoom in/out", 20, 60);
  if (freeze) translate(lastX, lastY);
  else translate(mouseX, mouseY);
  scale(scale);
  shape(figure);
}

void mouseClicked() {
  if(menuOn) return;
  if (isMouseOnButton()){
    created = true;
    createVertex();
  }else vertex.add(new int[]{max(mouseX - width/2, 0), mouseY - height/2});
}

boolean isMouseOnButton(){
  return (mouseX >= 125 && mouseX <= 325 && mouseY >= height-91 && mouseY <= height - 41);
}
void keyPressed(){
  if (created && key == ' '){
    freeze = !freeze;
    lastX = mouseX;
    lastY = mouseY;
  }
  if(menuOn) menuOn = false;
  if (key == 'r' || key == 'R'){
    created = false;
    vertex.clear();
    scale = 0.8;
    initFigure();
    freeze = false;
  }
}

void mouseWheel(MouseEvent event) {
  if(event.getCount() > 0) scale = max(0.3, scale - 0.1);
  else scale = min(2, scale + 0.1);
}
