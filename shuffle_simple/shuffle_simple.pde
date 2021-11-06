// Image Shuffle by Nicole Ajoy

// HOW TO PLAY: Drag (click + hold) a square next to 
// empty tile to move tile to position
//   (Hint: feel free to look at the original image in
//   the data folder!)

// NEED TO IMPLEMENT: win screen, reshuffle

import java.util.*;

PImage img;
PImage[] imgTiles = new PImage[16];
int[][] puzzle = new int[4][4];
ArrayList newTiles = new ArrayList();
boolean gameStart, gameWin;
boolean isTileSelected;
int emptyTileX, emptyTileY;
int selectedX, selectedY;
int mouseLocX, mouseLocY;
int counter = 0;

void setup() {
  img = loadImage("img.jpg");
  size(500, 500);
  
  // Initialize values
  gameStart = false;
  gameWin = false;
  isTileSelected = false;
  selectedX = -1;
  selectedY = -1;
  
  // https://processing.org/reference/PImage_get_.html
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      imgTiles[counter] = img.get(i*125, j*125, 125, 125);
      newTiles.add(counter);
      counter++;
    }
  }
  
  Collections.shuffle(newTiles);
  counter = 0;
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      puzzle[i][j] = (int)newTiles.get(counter); 
      counter++;
    }
  }
  
  emptyTileX = int(random(4));
  emptyTileY = int(random(4));
  puzzle[emptyTileX][emptyTileY] = -1; 
  gameStart = true;
}
 
void draw() {
  background(200);
  mouseLocX = int(mouseX/125);
  mouseLocY = int(mouseY/125);

  counter = 0;
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      if (puzzle[i][j] != -1) {
        image(imgTiles[puzzle[i][j]], i*125, j*125);
        counter++;
      }
    }
  }
  
  if (gameStart) {
    if (isMoveable() || (selectedX != -1 && selectedY != -1)) {
      noStroke();
      fill(255, 150);
      square(mouseLocX*125, mouseLocY*125, 125);
    }
  }
}

boolean isMoveable() {
  boolean left, right, top, btm, sameX, sameY;
  left = mouseLocX == emptyTileX-1;
  right = mouseLocX == emptyTileX+1;
  top = mouseLocY == emptyTileY-1;
  btm = mouseLocY == emptyTileY+1;
  sameX = mouseLocX == emptyTileX;
  sameY = mouseLocY == emptyTileY;
  
  if (((left||right) && sameY) || ((top||btm) && sameX))
    return true;
  else
    return false;
}

void mouseClicked() {
  if (isMoveable()) {
    boolean matchX = mouseLocX == selectedX;
    boolean matchY = mouseLocY == selectedY;
    
    if (isTileSelected && matchX && matchY) {
      isTileSelected = false;
      selectedX = -1;
      selectedY = -1;
    } 
    else {
      isTileSelected = true;
      selectedX = mouseLocX;
      selectedY = mouseLocY;
    }
  }
  
  if (isTileSelected && mouseLocX == emptyTileX && mouseLocY == emptyTileY) {
    puzzle[mouseLocX][mouseLocY] = puzzle[selectedX][selectedY];
    isTileSelected = false;
    puzzle[selectedX][selectedY] = -1;
    emptyTileX = selectedX; 
    emptyTileY = selectedY;
    selectedX = -1;
    selectedY = -1;
  }
}
