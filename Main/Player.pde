public class Player {
  int x, y;
  Vector velocity, endGameVelocity;
  Particle endGameParticle;
  float endGameRotation;
  PlayerMode current = new Running(this);
  ArrayList<Particle> particles;

  /**Constructs a new player*/
  public Player() {
    x = 0;
    y = 300 - UNIT/2;
    velocity = new Vector(2.5, 0);
    particles = new ArrayList<Particle>();
    endGameVelocity = new Vector(2, -5);
    endGameParticle = new Trail(0, 0, #66ffcc, 300);
    endGameRotation = 0;
  }

  public void draw() {
    current.draw(); //Calls the more specific draw for UFO/Airplane
    fill(150, 100, 255, 200);
    rect(x - 25, 300, 100, 2);
    fill(150, 100, 255, 175);
    rect(x + 75, 300, 25, 2);
    fill(150, 100, 255, 175);
    rect(x - 50, 300, 25, 2);
  }

  public void draw(boolean b) {
    current.draw(b);
  }

  /**Updates the game*/
  public void update() {
    //If player is colliding, then restart
    if (current.isColliding()) {
      die();
    }
    current.update();
  }

  /** Resets the coords*/
  public void die() {
    x = 0;
    y = 300 - UNIT / 2;
    xoffset = 0;
    velocity = new Vector(2.5, 0);
    particles.clear();
    current = new Running(this);
  }

  /** Checks all points on bottom*/
  public boolean isOnGround() {
    if (current.isColliding()) return false;
    for (int i = 0; i < UNIT; i++) {
      Block b = map.blockAt((x - UNIT/2) + i, y + UNIT/2);
      if (b != null) {
        if (!b.isSolid()) return false; 
        if (b.isHarmful()) {
          die();
          return false;
        }
        return true;
      }
    }
    return false;
  }


  public ArrayList<Particle> particles() {
    return particles;
  }
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public void setX(int x) {
    this.x = x;
  }
  public void setY(int y) {
    this.y = y;
  }
  public void addX(int x) {
    this.x += x;
  }
  public void addY(int y) {
    this.y += y;
  }
  public void setMode(PlayerMode c) {
    current = c;
  }
  public PlayerMode getMode() {
    return current;
  }
  public void addVelocity(Vector v) {
    velocity.add(v);
  }
  public Vector getVelocity() {
    return velocity;
  }
  public void setVelocity(Vector v) {
    velocity = v;
  }
}
