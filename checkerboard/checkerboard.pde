// Checkerboard by Nicole Ajoy

int cols, rows;
boolean xBound, yBound;
int squareSize;

void setup() {
  size(480, 480);
  background(#F6EEE0);
  noStroke();
  
  // Initialize glboal variables
  cols = 8; rows = 8;
  xBound = false; yBound = false;
  squareSize = width / cols;
}
 
void draw() {
  background(#F6EEE0);
  for (int c = 0; c < cols; c++) {
    for (int r = 0; r < rows; r++) {
      // Square's upper left corner points at (x, y)
      int x = c * squareSize;
      int y = r * squareSize;
      
      // Will need to calculate if the cursor is within a square
      // Remember, x and y represent the upper left corner of a square
      // The low bound is where x or y are, the high bound is x+squareWidth OR y+squareHeight
      xBound = x < mouseX && mouseX <= x + squareSize;
      yBound = y < mouseY && mouseY <= y + squareSize;
      
      // Change fill color depending on if the cursor is hovering over a grid
      if (xBound && yBound) {
        fill(#C38370);
      }
      // Checkerboard: Fill in square colors for every other position
      else if ((c+r) % 2 != 0) { 
        fill(#F6EEE0);
      }
      else {
        fill(#E4B7A0);
      }
      
      // Draw square
      square(x, y, squareSize);
    }
  }
}
