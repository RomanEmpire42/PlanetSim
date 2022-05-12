
ArrayList<Planet> system;
double G = 6.674;  //*(Math.pow(10, -11));
int tick = 0;
color backcolor = 20;


/*
    CONTROLS
 
 Space                   --> Play / Pause (Starts Paused)
 Shift + RMB             --> Add a new body (of mass 5), add 5 mass to an existing body
 Control + RMB           --> Remove 5 mass from selected body
 Delete + RMB            --> Delete selected body
 F + RMB                 --> Lock selected body
 Control + Shift + RMB   --> Remove 1 mass from selected body
 Tab + Control + RMB     --> Make selected body 1 order of magnitude less massive
 Tab + Shift + RMB       --> Make selected body 1 order of magnitude more massive
 W + RMB                 --> Increase radius of body
 RMB                     --> Display Mass
 RMB + Drag              --> Drag velocity vectors!
 */

public void setup()
{
  size((int)(0.95*window.innerWidth), (int)(0.95*window.innerHeight));
  frameRate(60);
  backcolor = 20;
  background(backcolor);
  system = new ArrayList <Planet>();
  space = false;
  massText = 0;
}
public void draw()
{  
  background(backcolor);
  if (space) {
    tick++;
    if (tick >= 60) {
      tick = 0;
    }
    for (int i = 0; i < system.size(); i++)
    {
      if (tick%6 == 0) {
        system.get(i).addDot();
        tick = 0;
      }
      for (int j = 0; j < system.size(); j++) {
        if (i != j) {
          PVector direction = (system.get(j).getPos().copy().sub(system.get(i).getPos().copy()));
          float absdist = direction.copy().mag();
          float distance = direction.copy().magSq();
          if (absdist < system.get(i).radius() + 5/6*system.get(j).radius()) {
            if (system.get(i).getGrav()) {
              //found final velocity using momentum3 = momentum1 + momentum2, and momentum = mv
              PVector m1 = system.get(i).getVel().copy().mult(system.get(i).getMass());
              PVector m2 = system.get(j).getVel().copy().mult(system.get(j).getMass());
              system.get(i).setVel(m1.add(m2).div(system.get(i).getMass()+system.get(j).getMass()));
              //weighted average of positions with mass
              system.get(i).setPos((system.get(i).getPos().copy().mult(system.get(i).getMass()).add(system.get(j).getPos().mult(system.get(j).getMass()))).div(system.get(i).getMass()+system.get(j).getMass()));
            }
            system.get(i).setMass(system.get(i).getMass() + system.get(j).getMass());
            system.remove(j);
            break;
          }
          if (system.get(i).getGrav()) {
            float gforce = (float)(G*system.get(i).getMass()*system.get(j).getMass()/distance);
            PVector force = direction.copy().normalize().mult(gforce).mult(50);
            system.get(i).accelerate(force.div(system.get(i).getMass()));
          }
        }
      }
    }
    for (int i = 0; i < system.size(); i++)
    {
      system.get(i).move();
    }
  }
  for (int i = 0; i < system.size(); i++)
  {
    system.get(i).show();
  }
  fill(255);
  textSize(35);
  if (massText != 0) {
    text(massText, 50, 60);
  }
}

boolean space = false;
boolean shift = false;
boolean fPress = false;
boolean ctrl = false;
boolean delete = false;
boolean tab = false;
boolean wPress = false;
boolean sPress = false;
void keyPressed()
{
  if (key == 'r') {
    setup();
  }
  if (keyCode==32)
  {
    if (backcolor == 0) {
      backcolor = 20;
    } else {
      backcolor = 0;
    }
    space = !space;
  }
  if (keyCode==16)
  {
    shift = true;
  }
  if (key == 'f')
  {
    fPress = true;
  }
  if (keyCode == 17)
  {
    ctrl = true;
  }
  if (keyCode == 9)
  {
    tab = true;
  }
  if (keyCode == 8)
  {
    delete = true;
  }
  if (key == 'w')
  {
    wPress = true;
  }
  if (key == 's')
  {
    sPress = true;
  }
}
void keyReleased()
{
  if (keyCode==16)
  {
    shift = false;
  }
  if (key == 'f')
  {
    fPress = false;
  }
  if (keyCode == 17)
  {
    ctrl = false;
  }
  if (keyCode == 9)
  {
    tab = false;
  }
  if (keyCode == 8)
  {
    delete = false;
  }
  if (key == 'w')
  {
    wPress = false;
  }
  if (key == 'f')
  {
    sPress = false;
  }
}
int massText = 0;
void mouseClicked() {
  PVector mPos = new PVector(mouseX, mouseY);
  if (shift & !ctrl & !tab) {
    Planet planet = new Planet();
    planet.addDot();
    planet.show();
    system.add(planet);
  } else {
    massText = 0;
    for (int i = 0; i < system.size(); i++)
    {
      PVector direction = (system.get(i).getPos().copy().sub(mPos.copy()));
      float distance = direction.copy().mag();

      if (distance < system.get(i).radius()) {
        massText = system.get(i).getMass();
        if (fPress) {
          system.get(i).setGrav(!system.get(i).getGrav());
          system.get(i).setVel(new PVector(0, 0));
          system.get(i).resetDots();
        }
        if (ctrl) {
          if (shift) {
            system.get(i).setMass(system.get(i).getMass()-1);
          } else {
            system.get(i).setMass(system.get(i).getMass()-5);
          }
        }
        if (tab) {
          if (shift) {
            system.get(i).setMass((int)(system.get(i).getMass()*10));
          }
          if (ctrl) {
            system.get(i).setMass((int)(system.get(i).getMass()/10));
          }
        }
        if (wPress) {
          system.get(i).setRad(system.get(i).radius()+3);
        }
        if (sPress && system.get(i).radius() > 9) {
          system.get(i).setRad(system.get(i).radius()-3);
        }
        if (delete || system.get(i).getMass() <= 0) {
          system.remove(i);
          break;
        }
      }
    }
  }
  for (int i = 0; i < system.size(); i++)
  {
    for (int j = 0; j < system.size(); j++) {
      if (i != j) {
        PVector direction = (system.get(j).getPos().copy().sub(system.get(i).getPos().copy()));
        float distance = direction.copy().mag();
        if (distance < system.get(i).radius() + 5/6*system.get(j).radius()) {
          system.get(i).setMass(system.get(i).getMass() + system.get(j).getMass());
          //weighted average of positions with mass
          system.get(i).setPos((system.get(i).getPos().copy().mult(system.get(i).getMass()).add(system.get(j).getPos().mult(system.get(j).getMass()))).div(system.get(i).getMass()+system.get(j).getMass()));
          system.remove(j);
          break;
        }
      }
    }
  }
}
void mouseDragged() {
  PVector mPos = new PVector(mouseX, mouseY);
  for (int i = 0; i < system.size(); i++)
  {
    //direction to the velocity arrow, pos+(60*vel)
    PVector velpos = system.get(i).getPos().copy().add(system.get(i).getVel().copy().mult(60));
    PVector direction = (velpos.copy().sub(mPos.copy()));
    float distance = direction.copy().mag();
    if (distance < system.get(i).radius() && system.get(i).getGrav()) {
      system.get(i).setVel(mPos.copy().sub(system.get(i).getPos().copy()).div(60));
    }
  }
}
