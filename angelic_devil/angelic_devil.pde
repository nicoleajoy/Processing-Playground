// Angelic Devil by Nicole Ajoy

/*** README ***/
// Click (and hold) on the left side of the character to see her angel form!
// Click (and hold) on the right side to see her devil form!

float angleFlower;
float angleTheta;

void setup() {
  // Initialize some values
  size(750, 750);
  background(#B3D7F5); // Blue
  rectMode(CENTER);
  
  angleFlower = 0;
  angleTheta = 0;
}
void draw() {
  if(mousePressed && mouseX < width/2) { // Angel
    background(#79A1CB); // Blue
    
    // Spinning flower background
    pushMatrix();
      noStroke();
      translate(width/2, height/2);
      rotate(angleFlower);
      for (int i = 0; i < 8; i++) { // Leaves
        rotate(PI/4);
        fill(#A6B994); // Green
        ellipse(0, -height/4, width/4, height/2.1);
      }
      angleFlower += 0.0025;
      rotate(angleFlower);
      for (int i = 0; i < 5; i++) { // Petals
        rotate(2*PI/5);
        fill(#F2F2F2); // White
        ellipse(0, -height/4, width/2.5, height/2.5);
      }
      angleFlower += 0.0025;
    popMatrix();
    
    // Wings
    stroke(0);
    fill(#F6F6F6); // White
    arc(width/2, height/1.3, width/1.25, height/3, 0, PI, CHORD);
    arc(width/2, height/1.2, width/1.35, height/4, 0, PI);
    arc(width/2, height/1.1, width/1.45, height/5, 0, PI);
    
    // Hair
    fill(#201616); // Dark brown
    ellipse(width/2, height/2, width/2.2, height/1.7);
    ellipse(width/2, height/1.4, width/2, height/1.8);
    
    // Ears
    stroke(0);
    fill(#DBAD92); // Skin color
    rect(width/2, height/2, width/2.3, height/15, 
         width/2.5, height/2.5, width, height);
    line(width/3.3, height/2, width/1.43, height/2);
    
    // Neck
    rect(width/2, height/1.4, width/10, width/5);
    
    // Head
    rect(width/2, height/2, width/3, height/2.5, 
         width/2, height/2, width/2, height/2);
         
    // Halo
    stroke(#FAE887); // Yellow
    strokeWeight(20);
    noFill();
    ellipse(width/2, height/6, width/3, height/10);
    
    // Eyes
    noStroke();
    fill(#170700); // Dark brown
    ellipse(width/2.3, height/2.2, width/32, height/25);
    ellipse(width/1.76, height/2.2, width/32, height/25);
    
    // Cheeks
    noStroke();
    fill(#DA8592, 100); // Lighter pink
    ellipse(width/2.4, height/1.85, width/12, height/15);
    ellipse(width/1.7, height/1.85, width/12, height/15);
    
    // Nose
    noFill();
    stroke(0);
    strokeWeight(3);
    arc(width/2.04, height/1.96, width/20, height/20, PI/3, (3*PI)/2);
    
    // Mouth
    arc(width/2, height/1.7, width/34, height/50, 0, PI);
    
    // Eyebrows
    line(width/2.63, height/2.35, width/2.27, height/2.4);
    line(width/1.79, height/2.4, width/1.61, height/2.35);
    
    // Shirt
    fill(#F0F0F0); // White
    rect(width/2, height, width/2.2, height/2, 
       width/2.5, height/2.5, width/2.5, height/2.5);
    
  }
  else if(mousePressed && mouseX > width/2) { // Devil
    background(#750B0B); // Red
    
    // Spider-web spinning
    translate(width/2, height/2);
    for(int i = 0; i < 25; i++) {
      rotate(TWO_PI/25);
      pushMatrix();
        stroke(0, 50);
        line(0, 0, 200, 0);
        translate(200, 0);
        rotate(angleTheta);
        for(int j = 0; j < 5; j++) {
          rotate(TWO_PI/5);
          line(-width/2, 0, -width/100, 0);
        }
      popMatrix();
    }
    angleTheta += 0.01;
    resetMatrix();
    
    // Devil tail
    beginShape();
    noFill();
    stroke(0);
    strokeWeight(5);
    curveVertex(width/2, height);
    curveVertex(width-100, height);
    curveVertex(width-100, height/2);
    curveVertex(width-100, height-100);
    endShape();
    fill(#8B2C2C); // Red
    triangle(width/1.25, height/2, width/1.153, 
             height/2, width/1.2, height/3); // Tip
    strokeWeight(2);
    
    // Hair
    fill(#201616); // Dark brown
    ellipse(width/2, height/2, width/2.2, height/1.7);
    ellipse(width/2, height/1.4, width/2, height/1.8);
    
    // Ears
    stroke(0);
    fill(#DBAD92); // Skin color
    rect(width/2, height/2, width/2.3, height/15, 
         width/2.5, height/2.5, width, height);
    line(width/3.3, height/2, width/1.43, height/2);
    
    // Neck
    rect(width/2, height/1.4, width/10, width/5);
    
    // Head
    rect(width/2, height/2, width/3, height/2.5, 
         width/2, height/2, width/2, height/2);
       
    // Devil horns
    fill(#8B2C2C); // Red
    arc(width/2.5, height/3.5, width/10, height/5, PI, 3*PI/2);
    arc(width/1.66, height/3.5, width/10, height/5, -PI/2, 0);
    
    // Eyes
    noStroke();
    fill(#170700); // Dark brown
    ellipse(width/2.3, height/2.2, width/25, height/50);
    ellipse(width/1.76, height/2.2, width/25, height/50);
    
    // Cheeks
    noStroke();
    fill(#DB5B6F, 75); // Darker pink
    ellipse(width/2.4, height/1.85, width/12, height/15);
    ellipse(width/1.7, height/1.85, width/12, height/15);
    
    // Nose
    noFill();
    stroke(0);
    strokeWeight(3);
    arc(width/2.04, height/1.96, width/20, height/20, PI/3, (3*PI)/2);
    
    // Mouth
    fill(#F9F6E2); // White
    arc(width/2, height/1.72, width/25, height/20, 0, PI, CHORD);
    
    // Eyebrows
    line(width/2.63, height/2.4, width/2.27, height/2.3);
    line(width/1.79, height/2.3, width/1.61, height/2.4);
    
    // Shirt
    fill(#8B2C2C); // Red
    rect(width/2, height, width/2.2, height/2, 
         width/2.5, height/2.5, width/2.5, height/2.5);
    
  } // END OF EVIL CHARACTER
  
  else {
    background(#CCCCCC); // Gray
    rectMode(CENTER);
    strokeWeight(2);
    
    // Rainbow circle background
    pushMatrix();
      colorMode(HSB);
      noFill();
      translate(width/2, height/2);
      rotate(angleTheta);
      for (int i = 0; i < 50; i++) {
        rotate(TWO_PI/50);
        noStroke();
        fill(i*5, 50, 255, 20);
        circle(0, -height/2, width-1);
      }
      angleTheta += 0.05;
      colorMode(RGB);
      stroke(0);
    popMatrix();
    
    // Hair
    fill(#170700); // Dark brown
    ellipse(width/2, height/2, width/2.2, height/1.7);
    ellipse(width/2, height/1.4, width/2, height/1.8);
    
    // Ears
    stroke(1);
    fill(#DBAD92); // Skin color
    rect(width/2, height/2, width/2.3, width/15,
         width/2.5, height/2.5, width, height);
    line(width/3.3, height/2, width/1.43, height/2);
    
    // Neck
    rect(width/2, height/1.4, width/10, width/5);
    
    // Head
    rect(width/2, height/2, width/3, height/2.5, 
         width/2, height/2, width/2, height/2);
    
    // Eyes
    noStroke();
    fill(#170700); // Dark brown
    ellipse(width/2.3, height/2.2, width/32, height/25);
    ellipse(width/1.76, height/2.2, width/32, height/25);
    
    // Cheeks
    noStroke();
    fill(#DA8592, 50); // Blush
    ellipse(width/2.4, height/1.85, width/12, height/15);
    ellipse(width/1.7, height/1.85, width/12, height/15);
    
    // Nose
    noFill();
    stroke(0);
    strokeWeight(3);
    arc(width/2.04, height/1.96, width/20, height/20, PI/3, (3*PI)/2);
    
    // Mouth
    arc(width/2, height/1.7, width/34, height/50, 0, PI);
    
    // Eyebrows
    line(width/2.63, height/2.4, width/2.27, height/2.4);
    line(width/1.79, height/2.4, width/1.61, height/2.4);
    
    // Shirt
    fill(#666666); // Dark gray
    rect(width/2, height, width/2.2, height/2, 
         width/2.5, height/2.5, width/2.5, height/2.5);
  }
}
