// Nicole Ajoy
// Recursive Function

// Honeycomb

float h = 75;
int counter = 0;
PImage background;

void setup() {
  size(500, 500);
  background(#D0B97D);
  background = loadImage("background.jpg");
  image(background, -50, 0);
  stroke(#8D6600);
  strokeWeight(2.5);
  fill(#FACD57, 150);
  
  float x = width/2, y = height/2;
  for (float a = 0; a < TWO_PI; a += PI/3) {
    //println(degrees(a));
    pushMatrix();
    translate(width/2, height/2);
    float hexagonXpos = 3*h/sqrt(3)*cos(a);
    float hexagonYpos = 3*h/sqrt(3)*sin(a);
    drawHex(hexagonXpos, hexagonYpos, h);
    popMatrix();
  }
  
  drawHex(x, y, h);
}
 
void drawHex(float x, float y, float h) {
  beginShape();
  for (float a = PI/2; a < TWO_PI+PI; a += PI/3) {
    float cornerX = x + h*cos(a);
    float corderY = y + h*sin(a);
    //line(width/2, height/2, cornerX, corderY);
    vertex(cornerX, corderY);
  }
  endShape(CLOSE);
  
  // Recursive part for inside
  if (h > 12) {
    drawHex(x, y, h/2);
  }
}
