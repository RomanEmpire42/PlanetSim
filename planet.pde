class Planet {
  private int myColor;   
  private PVector pos;
  private PVector vel;
  private int mass;
  private ArrayList<PVector> dots;
  private boolean gravity;
  private float radius;
  Planet() {
    myColor = color((int)(Math.random()*155)+50, (int)(Math.random()*155)+50, (int)(Math.random()*155)+50);
    pos = new PVector(mouseX, mouseY);
    vel = new PVector(0, 0);
    mass = 5; //(int)(Math.random()*2000+1000);
    dots = new ArrayList<PVector>();
    gravity = true;
    radius = 15;
  }
  public float radius() {
    return radius;
  }
  public void setRad(float r) {
    radius = r;
  }
  public void resetDots() {
    dots = new ArrayList<PVector>();
  }
  public boolean getGrav() {
    return gravity;
  }
  public void setGrav(boolean g) {
    gravity = g;
  }
  public PVector getPos() {
    return pos;
  }
  public void setPos(PVector p) {
    pos = p;
  }
  public PVector getVel() {
    return vel;
  }
  public void setVel(PVector v) {
    vel = v;
  }
  public int getMass() {
    return mass;
  }
  public void setMass(float m) {
    //keeping density the same, assuming the planet is a sphere
    radius = (float)(radius*Math.cbrt(m/mass));
    mass = (int)m;
  }
  public void accelerate (PVector accel)   
  {
    vel.add(accel);
  } 
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myXspeed and myYspeed  
    pos.add(vel);

    //if (pos.x > width+1000 || pos.x < -1000 || pos.y > height+1000 || pos.y < -1000)
  }  
  public void addDot() {
    dots.add(new PVector().set(pos));
  }
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    if (gravity) {
      stroke(myColor); 
      strokeWeight(1);
    } else {
      stroke(color(50, 50, 50)); 
      strokeWeight(5);
    }
    //radius = (float)Math.sqrt(mass*125/Math.PI);
    circle((float)pos.x, (float)pos.y, 2*radius);
    for (int i = 0; i < dots.size(); i++) {
      circle(dots.get(i).x, dots.get(i).y, 10);
    }
    PVector velpos = pos.copy().add(vel.copy().mult(60));
    strokeWeight(5);
    line(pos.x, pos.y, velpos.x, velpos.y);
    circle((float)velpos.x, (float)velpos.y, 10);
  }
}
