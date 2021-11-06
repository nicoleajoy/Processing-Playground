// Poster by Nicole Ajoy

size(1000, 1000);
background(#DBEBF5); // Blue

// Geometric repetitive pattern (with UF colors)
for(int x = 0; x <= width; x += width/5) {
  for (int y = 0; y <= height; y += height/5) {
    pushMatrix();
    translate(x, y);
    noStroke();
    rotate(PI/4);
    fill(255);
    for(int i = 0; i < 4; i++) {
      rotate(TWO_PI/4);
      ellipse(0, height/18.5, width/35, height/10);
    }
    stroke(255);
    strokeWeight(width/200);
    noFill();
    circle(0, 0, width/4);
    stroke(#F9E9DA); // Orange
    strokeWeight(width/100);
    noFill();
    circle(0, 0, width/5.5);
    popMatrix();
  }
}

fill(#F7F7F7, 200);
noStroke();
triangle(0, 0, width-1, 0, width/2, height/2);
triangle(0, height-1, width-1, height-1, width/2, height/2);


// Font located in "data" directory
PFont fontA, fontB;
textAlign(CENTER, CENTER);
fontA = createFont("GameOver.ttf", width/2);
fontB = createFont("Paskowy.ttf", width/2);
fill(#3B525B);

textFont(fontA);

// Title
textSize(width/2.5);
text("HSPC @ UF", width/2, height/8);

// Hosts
textSize(width/8.5);
text("Held by ACM & UF Programming Team", width/2, height/3.8);

// Details
textSize(width/12);
text("CELEBRATE VALENTINES DAY WITH AN EXCITING", width/2, height/1.25);
text("HIGH SCHOOL PROGRAMMING CONTEST", width/2, height/1.18);

// Date
textSize(width/8);
text("Feb 14 from 9am - 4pm on UF Campus", width/2, height/1.11);

textFont(fontB);

// Barcode
textSize(width/10);
text("HSPC@UF2020", width/2, height/2);
