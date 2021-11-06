// Kaleidoscope by Nicole Ajoy

int numPattern = 26;
float theta;
float rot = 2*PI/numPattern;
float delta_theta = 0.02;
color[] colors = {
  #52414C,
  #565264,
  #706677,
  #A6808C,
  #CCB7AE,
  #54414E,
  #3A405A,
  #042A2B
};
    
void setup() {
  size(500, 500);
  background(#706677);
  noStroke();
  colorMode(HSB);
  noFill();
  theta = 0;
  noLoop();
  smooth();
}

void drawLines(float x1, float y1, float x2, float y2, int sw, color c) {
  int s = 1;

  for(int i=0; i<numPattern; i++) {
    rotate(rot);
    pushMatrix();
    scale(s, 1);
    
    stroke(c);
    strokeWeight(sw);
    line(x1, y1, x2, y2);

    popMatrix();
    s *= -1;
  }
}

void drawArcs(float cx, float cy, float w, float h, float rotEllip, float a1, float a2, int sw, color c) {
  int s = 1;
  float rotang  = 0; //rot;

  for(int i=0; i<numPattern; i++) {
    pushMatrix();
    rotate(rotang);
    scale(s, 1);
    
    pushMatrix();
    translate(cx, cy);
    rotate(rotEllip);
    stroke(c);
    strokeWeight(sw);
    arc(cx, cy, w, h, a1, a2);

    popMatrix();
    popMatrix();
    s *= -1;
    rotang += rot;
  }
}

void draw() {
  translate(width/2, height/2);

  drawArcs(0, 0, 40, 13, 0.2, -PI/4, PI/4, 12, colors[0]);
  drawArcs(15, 0, 160, 50, 0.1, -PI*0.4, PI*0.4, 12, colors[1]);
  drawLines(40, 0, 120, 24, 12, colors[2]);
  drawArcs(45, 25, 100, 120, PI/13, -PI/3, PI/13, 13, colors[3]);
  drawArcs(40, 50, 70, 100, PI/20, -PI/4, PI/4, 13, colors[4]);
  drawArcs(40, 50, 150, 110, PI/20, -PI/4, PI/4, 5, colors[5]);
  drawArcs(40, 50, 250, 110, PI/20, -PI/4, PI/4, 5, colors[6]);
  drawArcs(40, 50, 50, 310, PI/20, -PI/4, PI/4, 2, colors[7]);
  drawArcs(40, 50, 50, 310, PI/20, -PI/4, PI/4, 2, colors[3]);

  filter(BLUR, 5);
  
  drawLines(40, 0, 120, 24, 3, color(0,150));
  drawArcs(15, 0, 160, 50, 0.1, -PI*0.4, PI*0.4, 2, color(0,150));
  drawArcs(0, 0, 40, 13, 0.2, -PI/4, PI/4, 2, color(0,150));
  drawArcs(45, 25, 100, 120, PI/13, -PI/3, PI/13, 2, color(0,150));
  drawArcs(40, 50, 70, 100, PI/20, -PI/4, PI/4, 2, color(255,150));
  drawArcs(40, 50, 150, 110, PI/20, -PI/4, PI/4, 2, color(0,150));
  drawArcs(40, 50, 250, 110, PI/20, -PI/4, PI/4, 2, color(0,150));
  drawArcs(40, 50, 50, 310, PI/20, -PI/4, PI/4, 2, color(0,150));
  drawArcs(40, 50, 50, 310, PI/20, -PI/4, PI/4, 2, color(0,150));
  
  save("kaleidoscopeNA.tif");
}
