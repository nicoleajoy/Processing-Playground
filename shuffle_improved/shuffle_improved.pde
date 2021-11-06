// Shuffle Game by Nicole Ajoy

// HOW TO PLAY
// Click corners in the right order:
// 1. TOP LEFT
// 2. TOP RIGHT
// 3. BTM LEFT
// 4. BTM RIGHT

import java.util.*;

PImage img, imgTL, imgTR, imgBL,imgBR;
ArrayList<PImage> originalImgs = new ArrayList<PImage>();
ArrayList<PImage> shuffledImgs = new ArrayList<PImage>();
ArrayList<PImage> userInput = new ArrayList<PImage>();

int clicks;
boolean gameOver, gameWin;
PFont font = new PFont();

void setup() {
  size(500, 500);
  
  img = loadImage("img.jpg");
  imgTL = loadImage("imgTL.jpg");
  imgTR = loadImage("imgTR.jpg");
  imgBL = loadImage("imgBL.jpg");
  imgBR = loadImage("imgBR.jpg");
  
  originalImgs.add(imgTL);
  originalImgs.add(imgTR);
  originalImgs.add(imgBL);
  originalImgs.add(imgBR);
  
  shuffledImgs.add(imgTL);
  shuffledImgs.add(imgTR);
  shuffledImgs.add(imgBL);
  shuffledImgs.add(imgBR);
  Collections.shuffle(shuffledImgs);
  
  clicks = 0;
  gameOver = false;
  gameWin = false;
  
  font = createFont("Bubblegum.ttf", 75);
}

void draw() {
  image(shuffledImgs.get(0), 0, 0);
  image(shuffledImgs.get(1), width/2, 0);
  image(shuffledImgs.get(2), 0, height/2);
  image(shuffledImgs.get(3), width/2, height/2);
  
  if (gameOver) {
    gameWin = true;
    
    for (int i = 0; i < 4; i++) {
      if (originalImgs.get(i) != userInput.get(i)) {
        gameWin = false;
      }
    }
    
    if (!gameWin) {
      fill(0, 50);
      noStroke();
      square(0, 0, 500);
      
      textFont(font, 50);
      textAlign(CENTER, CENTER);
      fill(#FFF2EE);
      text("TRY AGAIN :(", width/2, height/2);
    }
    else {
      image(img, 0, 0);
      fill(255, 50);
      noStroke();
      square(0, 0, 500);
      
      textFont(font, 50);
      textAlign(CENTER, CENTER);
      fill(#675445);
      text("YOU WIN :)", width/2, height/2);
    }
  }
}

void mousePressed() {
  boolean left = 0 <= mouseX && mouseX <= width/2;
  boolean right = width/2 <= mouseX && mouseX <= width;
  boolean top = 0 <= mouseY && mouseY <= height/2;
  boolean btm = height/2 <= mouseY && mouseY <= height;
  
  clicks++;
  // println("Moves: " + clicks);
  
  if (top && left) {
    // println("TOP LEFT");
    userInput.add(shuffledImgs.get(0));
  }
  if (top && right) {
    // println("TOP RIGHT");
    userInput.add(shuffledImgs.get(1));
  }
  if (btm && left) {
    // println("BTM LEFT");
    userInput.add(shuffledImgs.get(2));
  }
  if (btm && right) {
    // println("BTM RIGHT");
    userInput.add(shuffledImgs.get(3));
  }
  
  if (clicks == 4) {
    gameOver = true;
  }
}
