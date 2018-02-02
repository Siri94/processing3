final float INC = 0.05;
final float SCL = 10;
int COLS, ROWS;
float zoff = 0;
PVector[] flowfield;
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(1280, 800, P2D);  
  background(255);
  
  COLS = floor(width / SCL);
  ROWS = floor(height / SCL);
  
  flowfield = new PVector[(COLS + 1) * (ROWS + 1)];
  // because a position can be 0 to COLS and 0 to ROWS, that causes an error of boundary array.
  
  for (int i = 0; i < 1000; i++) {
    particles.add(new Particle()); 
  }
  
}

void draw() {
  //background(255);
  println(frameRate);
  float yoff  = 0;

  for (int y = 0; y < ROWS + 1; y++) {
    float xoff = 0;
    for (int x = 0; x < COLS + 1; x++) {
      int index = x + y * COLS;
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 4;
      PVector v = PVector.fromAngle(angle);
      v.setMag(1);
      flowfield[index] = v;
      xoff += INC;   
    }
    yoff += INC;
  }
  zoff += INC;
  
  // notice that a function of order is important!
  for (int i = 0; i < particles.size(); ++i) {
    particles.get(i).follow(flowfield);
    particles.get(i).update();
    particles.get(i).show();
    particles.get(i).edges();
  }
}