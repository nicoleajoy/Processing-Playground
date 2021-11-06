// Profile by Nicole Ajoy

// Initialize some values
size(750, 750);
background(#E9CFCC); // Baby pink
rectMode(CENTER);
strokeWeight(2);

// Flower background
pushMatrix();
  noStroke();
  translate(width/2, height/2);
  for (int i = 0; i < 8; i++) { // Leaves
    rotate(PI/4);
    fill(#C0D6AB); // Pale green
    ellipse(0, -height/4, width/4, height/2.1);
  }
  for (int i = 0; i < 5; i++) { // Petals
    rotate(2*PI/5);
    fill(#C69999); //  Pale red
    ellipse(0, -height/4, width/2.5, height/2.5);
  }
popMatrix();

// Shadow
fill(#000000, 25); // Black (transparent)
ellipse(width/1.85, height/2, width/2.22, height/1.8);
ellipse(width/1.85, height/1.43, width/2, height/1.54);
rect(width/1.85, height, width/2.22, width/1.85, 
     width/2.5, height/2.5, width/2.5, height/2.5);

// Hair
fill(#170700); // Dark brown
ellipse(width/2, height/2, width/2.2, height/1.8);
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
fill(#170700); // Dark brown
ellipse(width/2.3, height/2.2, width/33, width/25);
ellipse(width/1.76, height/2.2, width/33, width/25);

// Cheeks
noStroke();
fill(#DA8592, 150); // Blush
ellipse(width/2.4, height/1.85, width/12, height/15);
ellipse(width/1.7, height/1.85, width/12, height/15);

// Glasses
stroke(0);
fill(255, 255, 255, 75); // White (transparent)
ellipse(width/2.4, height/2.2, width/6.7, height/8.3);
ellipse(width/1.71, height/2.2, width/6.7, height/8.3);
strokeWeight(8); // Bridge of glasses
line(width/2.03, height/2.17, width/1.96, height/2.17);

// Nose
strokeWeight(3);
arc(width/2.04, height/1.96, width/20, height/20, PI/3, (3*PI)/2);

// Mouth
arc(width/2, height/1.7, width/33.3, height/50, 0, PI);

// Eyebrows
line(width/2.63, height/2.4, width/2.27, height/2.4); // L
line(width/1.79, height/2.4, width/1.61, height/2.4); // R

// Shirt
fill(#B4847C); // Pale red
rect(width/2, height, width/2.2, height/2, 
     width/2.5, height/2.5, width/2.5, height/2.5);
