// Clock by Nicole Ajoy

PImage wallpaper;
float hr, min, sec;
float radClock, radHr, radMin, radSec;
PFont font;

void setup() {
  size(500, 500);
  wallpaper = loadImage("background.jpg");
  font = loadFont("Skia.vlw");
  
  hr = 0;
  min = 0;
  sec = 0;
  
  radClock = width/3;
  radHr = width/5;
  radMin = width/3.75;
  radSec = radClock;
}

void draw() {
  image(wallpaper, 0, 0);
  mapCurrentTime();
  
  pushMatrix();
    translate(width/2, height/2);
    
    // Draw outer circles
    fill(#f6ebe6, 100); // beige
    circle(0, 0, width/1.37); // outermost black circle
    circle(0, 0, width/1.52); // second outermost black circle
    fill(0);
    circle(0, 0, 10); // middle black circle
    
    // Draw hands
    stroke(0);
    // Hours
    strokeWeight(3);
    drawHand(0, 0, radHr * cos(hr), radHr * sin(hr));
    // Minutes
    strokeWeight(2);
    drawHand(0, 0, radMin * cos(min), radMin * sin(min));
    // Seconds
    strokeWeight(1);
    drawHand(0, 0, radSec * cos(sec), radSec * sin(sec));
  popMatrix();
  
  // Draw tick marks
  strokeWeight(3);
  stroke(#404040);
  drawSecTicks();
  drawMinTicks();
  drawNumbers();
}

void mapCurrentTime() {
  hr =  map(hour(), 0, 24, 0, 4*PI) - (PI/2);
  min = map(minute(), 0, 60, 0, 2*PI) - (PI/2); 
  sec = map(second(), 0, 60, 0, 2*PI) - (PI/2);
}

void drawHand(float x1, float y1, float x2, float y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
    translate(x2, y2);
    float a = atan2(x1-x2, y2-y1);
    rotate(a);
    scale(0.75);
    line(0, 0, -20, -20);
    line(0, 0, 20, -20);
    noFill();
    ellipse(0, -25, 40, 25);
    ellipse(0, -25, 20, 30);
  popMatrix();
}

void drawSecTicks() {
  pushMatrix();
    translate(width/2, height/2);
    for (int a = 0; a < 360; a += 6) {
      rotate(TWO_PI / 60);
      rect(width/3, 0, 15, 0.1);
    }
  popMatrix();
}

void drawMinTicks() {
  pushMatrix();
    translate(width/2, height/2);
    for (float a = 0; a < TWO_PI; a += PI/6) {
      rotate(PI/6);
      fill(0);
      rect(width/3, 0, 15, 3);
    }
  popMatrix();
}

void drawNumbers() {
  float angleFix = PI/4;
  pushMatrix();
    textFont(font);
    textSize(45);
    textAlign(CENTER, CENTER);
      translate(width/2, height/2);
      rotate(-TWO_PI/6);
      for (int a = 1; a <= 12; a++) {
        pushMatrix();
          translate(width/3.5, 0);
          rotate(angleFix+PI/12);
          if (a == 1)  
            text("I", 0, 0);
          if (a == 2)  
            text("II", 0, 0);
          if (a == 3)  
            text("III", 0, 0);
          if (a == 4)  
            text("IV", 0, 0);
          if (a == 5)  
            text("V", 0, 0);
          if (a == 6)  
            text("VI", 0, 0);
          if (a == 7)  
            text("VII", 0, 0);
          if (a == 8)  
            text("VIII", 0, 0);
          if (a == 9)  
            text("IX", 0, 0);
          if (a == 10) 
            text("X", 0, 0);
          if (a == 11) 
            text("XI", 0, 0);
          if (a == 12) 
            text("XII", 0, 0);
          angleFix -= PI/6;
        popMatrix();
        rotate(PI/6);
    }
  popMatrix();
}
