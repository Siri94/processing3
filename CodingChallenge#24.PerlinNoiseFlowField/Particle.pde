class Particle 
{
  PVector pos = new PVector(random(width), random(height));
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float maxspeed = 4;
  PVector prevPos = this.pos.copy();
  
  void update() {
    this.vel.add(this.acc);
    this.vel.limit(this.maxspeed);
    this.pos.add(this.vel);
    this.acc.mult(0); // reset
  }
  
  void applyForce(PVector force) {
    this.acc.add(force);
  }
  
  void show() {
    stroke(0, 50);
//    point(this.pos.x, this.pos.y);
    line(this.pos.x, this.pos.y, this.prevPos.x, this.prevPos.y);
    this.updatePrev();
  }
  
  void follow(PVector[] vectors) {
    int x = floor(this.prevPos.x / SCL);
    int y = floor(this.prevPos.y / SCL);
    int index = x + y * COLS;
    this.applyForce(vectors[index]);
  }
  
   void updatePrev() {
    prevPos.x = this.pos.x;
    prevPos.y = this.pos.y;
  }
  
  void edges() {
    if (this.pos.x < 0) {
      this.pos.x = width;
      this.updatePrev();
    }
    if (this.pos.y < 0) {
      this.pos.y = height;
      this.updatePrev();
    }
    if (this.pos.x > width) {
      this.pos.x = 0;
      this.updatePrev();
    }
    if (this.pos.y > height) {
      this.pos.y = 0;
      this.updatePrev();
    }
  }
}