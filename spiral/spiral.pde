// Spiral by Nicole Ajoy

PShape spiral;
float h = 360;
float r = 0;
float theta = 0;
Ball ball1 = new Ball(0, 0, false, 0, 0);
Ball ball2 = new Ball(117.47831, -136.24792, true, 180, 18);

void setup() {
  size(500, 500);
  background(200);
  colorMode(HSB);
  noStroke();
  
  spiral = createShape(GROUP);
  for (float angle = 0; angle < 360; angle += 0.2) {
    float x = r * cos(theta);
    float y = r * sin(theta);
    h -= 0.25;
    if (h < 1)
      h = 360;
    fill(h, 100, 255);
    PShape circle = createShape(ELLIPSE, x, y, 16, 16);
    spiral.addChild(circle);
    r += 0.1;
    theta += 0.01;
  }
}

void draw() {
  background(200);
  pushMatrix();
    translate(width/2, height/2);
    shape(spiral);
    
    ball1.update();
    ball1.display();
    ball1.checkSpiralCollision();
    
    ball2.update();
    ball2.display();
    ball2.checkSpiralCollision();
    
    ball1.checkBallCollision(ball2);
  popMatrix();
}

class Ball {
  float x, y;
  boolean inward;
  float r, theta;
  
  Ball(float x_, float y_, boolean b, float r_, float t) {
    x = x_;
    y = y_;
    inward = b;
    r = r_;
    theta = t;
  }
  
  void checkSpiralCollision() {
    if (inward && theta <= 0) {
      inward = false;
    }
    if (!inward && theta >= 18) {
      inward = true;
    }
  }
  
  void checkBallCollision(Ball that) {
    float distance = dist(this.x, this.y, that.x, that.y);
    if (distance <= 16) {
      if (this.inward && !that.inward) {
        this.inward = false;
        that.inward = true;
      }
      if (!this.inward && that.inward) {
        this.inward = true;
        that.inward = false;
      }
    }
  }
  
  void update() {
    x = r * cos(theta);
    y = r * sin(theta);
    
    if (inward) {
      r -= 0.1;
      theta -= 0.01;
    }
    else {
      r += 0.1;
      theta += 0.01;
    }
  }
  
  void display() {
    noStroke();
    fill(0);
    ellipse(x, y, 16, 16);
  }
}
