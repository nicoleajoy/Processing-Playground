// Animated Balls by Nicole Ajoy

class Ball {
  int locX = 0;
  int locY = 0;
  int diam = 0;
  int velX = 0;
  int velY = 0;
  color colour = 0;
  int state = 0;
  
  void Initialize(int x, int y, int d, int vx, int vy, color c) {
    locX = x;
    locY = y;
    diam = d;
    velX = vx;
    velY = vy;
    colour = c;
  }
  
  void DrawCircle() {
    fill(colour);
    circle(locX, locY, diam);
  }
}

Ball bounceBall;
Ball rollBall;

void setup() {
  size(500, 500);
  background(#F4EAE6); // beige
  
  int d = 50;
  bounceBall = new Ball();
  bounceBall.Initialize(width/4 + d, d/2, d, 2, 2, color(#4297A0)); // blue
  rollBall = new Ball();
  rollBall.Initialize(width/4 + d, d/2, d, 2, 0, color(#E57F84)); // red bouncing ball
}

void draw() {
  background(#F4EAE6);
  noStroke();
  fill(0);
  
  // Box in the upper left corner of the window
  fill(#2F5061);
  square(0, 0, width/4);
  
  // Bouncing ball
  bounceBall.locX += bounceBall.velX;
  bounceBall.locY += bounceBall.velY;
  
  // Box checks
  if(bounceBall.locX - bounceBall.diam/2 <= width/4 && bounceBall.locY - bounceBall.diam/2 <= height/4) {
    if (bounceBall.velX < 0) {
      bounceBall.velX = -bounceBall.velX;
    }
    else if (bounceBall.velY < 0) {
      bounceBall.velY = -bounceBall.velY;
    }
  }
  // Wall checks
  if(bounceBall.locX <= bounceBall.diam/2 || bounceBall.locX + bounceBall.diam/2 >= width) {
    bounceBall.velX = -bounceBall.velX;
  }
  if(bounceBall.locY <= bounceBall.diam/2 || bounceBall.locY + bounceBall.diam/2 >= height) {
    bounceBall.velY = -bounceBall.velY;
  }
    
  bounceBall.DrawCircle();
  
  // Rolling ball
  rollBall.locX += rollBall.velX;
  rollBall.locY += rollBall.velY;
  
  // Check what state we are currently in
  if(rollBall.locX >= width-rollBall.diam/2 && rollBall.state == 0) { // move right
    rollBall.velX = 0;
    rollBall.velY = 2;
    rollBall.state = 1;
  }
  if(rollBall.locY >= height-rollBall.diam/2 && rollBall.state == 1) { // move down
    rollBall.velX = -2;
    rollBall.velY = 0;
    rollBall.state = 2;
  }
  if(rollBall.locX <= rollBall.diam/2 && rollBall.state == 2) { // move left
    rollBall.velX = 0;
    rollBall.velY = -2;
    rollBall.state = 3;
  }
  if(rollBall.locY <= rollBall.diam/2 + width/4 && rollBall.state == 3) { // move up
    rollBall.velX = 2;
    rollBall.velY = 0;
    rollBall.state = 4;
  }
  if(rollBall.locX >= rollBall.diam/2 + width/4 && rollBall.state == 4) { // move right over the vox
    rollBall.velX = 0;
    rollBall.velY = -2;
    rollBall.state = 5;
  }
  if(rollBall.locY <= rollBall.diam/2 && rollBall.state == 5) { // move up over the box
    rollBall.velX = 2;
    rollBall.velY = 0;
    rollBall.state = 0;
  }
  
  rollBall.DrawCircle();
}
