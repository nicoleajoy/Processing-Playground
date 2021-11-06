// Waves by Nicole Ajoy

float offset = 0.0f;

void setup() {
  size(500, 500);
  noStroke();
  fill(#71A9F7);
}
 
void draw() {
  background(#C6D8FF);
  pushMatrix();
  translate(0, height/2);
  CreateGraph(offset, width);
  offset += 0.5f;
  popMatrix();
}

// Function with a single parameter
float CalculateTrigResult(float x) {
  return (cos(6*x) + sin(4*x));
}

// Graph part of this function given a range
void CreateGraph(float x1, float x2) {
  for (float i = 0; i < x2; i += 0.25) {
    ellipse(i*2, 50.0f * CalculateTrigResult(radians(i+x1)), 5, 5);
  }
}
