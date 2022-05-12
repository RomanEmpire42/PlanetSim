
int startX = width/2;
int startY = 0;
int endX = width/2;
int endY = 0;
int rand = (int)(Math.random()*2);

void setup()
{
  size(300,300);
  strokeWeight(5);
  background(0, 0, 0);
}
void draw(){
  stroke((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
  if(rand == 0){
    while(startY <= 300){
        endY = startY + (int)(Math.random()*9);
        endX = startX + ((int)(Math.random()*18)-9);
        line(startX, startY, endX, endY);
        startX = endX;
        startY = endY;
      }
    }
  else{
    while(startX <= 300){
       endY = startY + ((int)(Math.random()*18)-9);
       endX = startX + (int)(Math.random()*9);
        line(startX, startY, endX, endY);
        startX = endX;
        startY = endY;
      }
    }
  
}

void mousePressed(){
  background(0, 0, 0);
  rand = (int)(Math.random()*2);
  if(rand == 1){
      startX = 0;
      startY = 150;
      endX = 0;
      endY = 150;
    } else{
      startX = 150;
      startY = 0;
      endX = 150;
      endY = 0;
    }
}
