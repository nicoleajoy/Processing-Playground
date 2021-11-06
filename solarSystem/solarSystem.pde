// Nicole Ajoy
// Solar System

float aEarth, aMoon;
float aMercury, aVenus, aMars;
// Not enough room for the rest of the planets :(
float x, y, dx, dy, s;
PImage background, sun;

void setup() {
  background = loadImage("background.jpg");
  size(1000, 1000);
  background(10);
  strokeWeight(3);
  
  // Planets
  aEarth = 0;
  aMoon = 0;
  aMars = 0;
  aMercury = 0;
  aVenus= 0;
  
  // Ship
  x = 200; y = 200;
  dx = 0; dy = 0;
  s = 2;
}

void draw() {
  background(#35333E);
  image(background, 0, 0);
  translate(width/2, height/2);
  
  // Sun
  fill(#FFCE33);
  circle(0, 0, 150);
  pushMatrix();
  popMatrix();
  
  // Mercury
  pushMatrix();
  aMercury += 0.018;
  rotate(aMercury);
  translate(125, 0);
  fill(#D6D3DB);
  circle(0, 0, 15);
  popMatrix();
  
  // Venus
  pushMatrix();
  aVenus += 0.008;
  rotate(aVenus);
  translate(200, 0);
  fill(#A76F29);
  circle(0, 0, 30);
  popMatrix();
  
  // Mars
  pushMatrix();
  aMars += 0.005;
  rotate(aMars);
  translate(425, 0);
  fill(#A54E3B);
  circle(0, 0, 15);
  popMatrix();
  
  // Earth
  aEarth += 0.01;
  rotate(aEarth);
  translate(300, 0);
  fill(#69AAEC);
  circle(0, 0, 40);
  
  // Moon
  aMoon += 0.12;
  rotate(aMoon);
  fill(#C6C6C6);
  circle(50, 0, 10);
  
  resetMatrix();
  
  drawShip();
}

void drawShip() {
  float dx = mouseX - x;
  float dy = mouseY - y;
  // To add some delay in mouse chase
  float scale = s / sqrt(dx*dx+dy*dy);
  x += dx * scale;
  y += dy * scale;
  fill(255);
  circle(x, y, 15);
}
