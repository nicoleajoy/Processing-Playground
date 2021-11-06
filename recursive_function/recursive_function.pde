// Recursive Function by Nicole Ajoy

float hexStartingSize = 70;
PImage background;

void setup() {
  size(500, 500);
  background = loadImage("background.jpg");
  image(background, -50, 0);
  
  stroke(#8D6600);
  fill(#FACD57, 100);
  
  pushMatrix();
    translate(width/2, height/2);
    // Hexes around the center hex
    for (float a = 0; a < TWO_PI; a += PI/3) {
      if (a == 0) // central hex
        drawHex(0, 0, hexStartingSize);
      else // surrounding hex
        drawHex(3 * (hexStartingSize/sqrt(3)) * cos(a), 3 * (hexStartingSize/sqrt(3)) * sin(a), hexStartingSize);
    }
  popMatrix();
}
 
void drawHex(float x, float y, float h) {
  beginShape();
  for (float a = PI/2; a < TWO_PI+PI; a += PI/3) {
    float cornerX = x + (h * cos(a));
    float corderY = y + (h * sin(a));
    vertex(cornerX, corderY);
  }
  endShape(CLOSE);
  
  // Recursive part for inside
  if (h > 0) {
    drawHex(x, y, h - 10);
  }
}
