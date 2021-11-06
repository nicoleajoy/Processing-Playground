PVector cubes, fans, monsterHalfScale, monsterWireframe;
PShape cube, circle, hex, monster;
int currentTargetIndex = 0;
Camera cam;

void setup()
{
  size(1600, 1000, P3D);
  perspective(radians(50.0f), width/(float)height, 0.1, 1000);
  cam = new Camera();
  
  monsterWireframe = new PVector(75, 0, 0);
  cam.AddLookAtTarget(monsterWireframe);
  
  currentTargetIndex++;
  cubes = new PVector(-100, 0, 0);
  cam.AddLookAtTarget(cubes);
  
  currentTargetIndex++;
  fans = new PVector(-50, 0, 0);
  cam.AddLookAtTarget(fans);
  
  currentTargetIndex++;
  monsterHalfScale = new PVector(0, 0, 0);
  cam.AddLookAtTarget(monsterHalfScale);
  
  cube = createShape();
  cube.setStroke(false);
  cube.beginShape(TRIANGLE);
  cube.fill(255, 255, 0); // Yellow
  cube.vertex(-0.5, -0.5, 0.5);
  cube.vertex(-0.5, 0.5, 0.5);
  cube.vertex(0.5, 0.5, 0.5);
  cube.fill(0, 255, 0); // Green
  cube.vertex(-0.5, -0.5, 0.5);
  cube.vertex(0.5, -0.5, 0.5);
  cube.vertex(0.5, 0.5, 0.5);
  cube.fill(255, 69, 0); // Orange red
  cube.vertex(0.5, -0.5, -0.5);
  cube.vertex(0.5, -0.5, 0.5);
  cube.vertex(0.5, 0.5, 0.5);
  cube.fill(0, 128, 255); // Blue
  cube.vertex(0.5, -0.5, -0.5);
  cube.vertex(0.5, 0.5, 0.5);
  cube.vertex(0.5, 0.5, -0.5);
  cube.fill(30, 144, 255); // Dodger blue
  cube.vertex(-0.5, -0.5, -0.5);
  cube.vertex(-0.5, 0.5, -0.5);
  cube.vertex(0.5, 0.5, -0.5);
  cube.fill(138, 43, 226); // Purple
  cube.vertex(-0.5, -0.5, -0.5);
  cube.vertex(0.5, -0.5, -0.5);
  cube.vertex(0.5, 0.5, -0.5);
  cube.fill(230, 230, 230); // Gray
  cube.vertex(-0.5, -0.5, -0.5);
  cube.vertex(-0.5, -0.5, 0.5);
  cube.vertex(-0.5, 0.5, 0.5);
  cube.fill(0, 0, 255); // Blue
  cube.vertex(-0.5, -0.5, -0.5);
  cube.vertex(-0.5, 0.5, 0.5);
  cube.vertex(-0.5, 0.5, -0.5);
  cube.fill(255, 165, 0); // Orange
  cube.vertex(0.5, -0.5, -0.5);
  cube.vertex(-0.5, -0.5, -0.5);
  cube.vertex(0.5, -0.5, 0.5);
  cube.fill(127, 255, 212); // Mint
  cube.vertex(-0.5, -0.5, 0.5);
  cube.vertex(-0.5, -0.5, -0.5);
  cube.vertex(0.5, -0.5, 0.5);
  cube.fill(255, 0, 0); // Red
  cube.vertex(0.5, 0.5, -0.5);
  cube.vertex(-0.5, 0.5, -0.5);
  cube.vertex(0.5, 0.5, 0.5);
  cube.fill(255, 0, 255); // Magenta
  cube.vertex(-0.5, 0.5, 0.5);
  cube.vertex(-0.5, 0.5, -0.5);
  cube.vertex(0.5, 0.5, 0.5);
  cube.endShape();
  
  circle = createShape();
  circle.beginShape(TRIANGLE_FAN);
  // Top half
  circle.stroke(0);
  circle.strokeWeight(2.0f);
  colorMode(HSB, 360, 100, 100);
  circle.fill(color(0, 100, 100));
  circle.vertex(10, 0);
  circle.fill(color(330, 100, 100));
  circle.vertex(9.5, -3);
  circle.vertex(8, -6);
  circle.fill(color(300, 100, 100));
  circle.vertex(6, -8);
  circle.vertex(3, -9.5);
  circle.fill(color(270, 100, 100));
  circle.vertex(0, -10);
  circle.vertex(-3, -9.5);
  circle.fill(color(240, 100, 100));
  circle.vertex(-6, -8);
  circle.fill(color(210, 100, 100));
  circle.vertex(-8, -6);
  circle.vertex(-9.5, -3);
  circle.fill(color(180, 100, 100));
  circle.vertex(-10, 0);
  // Bottom half
  circle.vertex(-9.5, 3);
  circle.fill(color(150, 100, 100));
  circle.vertex(-8, 6);
  circle.vertex(-6, 8);
  circle.fill(color(120, 100, 100));
  circle.vertex(-3, 9.5);
  circle.fill(color(90, 100, 100));
  circle.vertex(0, 10);
  circle.fill(color(60, 100, 100));
  circle.vertex(3, 9.5);
  circle.fill(color(30, 100, 100));
  circle.vertex(6, 8);
  circle.vertex(8, 6);
  circle.vertex(9.5, 3);
  colorMode(RGB, 255, 255, 255);
  circle.endShape();
  
  hex = createShape();
  hex.beginShape(TRIANGLE_FAN);
  hex.stroke(0);
  hex.strokeWeight(2.0f);
  colorMode(HSB, 360, 100, 100);
  hex.fill(color(0, 100, 100)); // Red 
  hex.vertex(10, 0);
  hex.fill(color(60, 100, 100)); // Yellow
  hex.vertex(5, 9);
  hex.fill(color(120, 100, 100)); // Green
  hex.vertex(-5, 9);
  hex.fill(color(180, 100, 100)); // Cyan 
  hex.vertex(-10, 0);
  hex.fill(color(240, 100, 100)); // Blue
  hex.vertex(-5, -9);
  hex.fill(color(300, 100, 100)); // Magenta 
  hex.vertex(5, -9);
  colorMode(RGB, 255, 255, 255);
  hex.endShape();
  
  // Load from "data" folder
  monster = loadShape("monster.obj");
}

void draw()
{
  background(150);
  
  // X-axis (red)
  stroke(255, 0, 0);
  strokeWeight(5);
  fill(100);
  line(-100, 0, 0, 100, 0, 0);
  
  // Z-axis (blue)
  stroke(0, 0, 255);
  strokeWeight(5);
  fill(50);
  line(0, 0, -100, 0, 0, 100);
  
  // Grids (white)
  stroke(255);
  strokeWeight(1);
  for (int x = -100; x <= 100; x = x + 10)
  {
    if (x == 0) 
    {
      continue; // Ignore x-axis
    }
    line(x, 0, -100, x, 0, 100); 
  }
  for (int z = -100; z <= 100; z = z + 10)
  {
    if (z == 0) 
    {
      continue; // Ignore z-axis
    }
    line(-100, 0, z, 100, 0, z);
  }
  
  // Cube (small)
  pushMatrix();
  translate(-110, 0, 0);
  shape(cube);
  popMatrix();
  
  // Cube (medium)
  pushMatrix();
  translate(-100, 0, 0);
  scale(5, 5, 5);
  shape(cube);
  popMatrix();
  
  // Cube (large)
  pushMatrix();
  translate(-90, 0, 0);
  scale(10, 20, 10);
  shape(cube);
  popMatrix();
  
  // Fan (20 segments)
  pushMatrix();
  translate(-60, -10);
  shape(circle);
  popMatrix();
  
  // Fan (6 segments)
  pushMatrix();
  translate(-40, -10);
  shape(hex);
  popMatrix();
  
  // Monster (half-scaled)
  monster.setStroke(false);
  monster.setFill(color(210, 255, 93)); // yellow-green
  scale(0.5, -0.5, 0.5);
  shape(monster);
  
  // Monster (wireframe)
  pushMatrix();
  scale(2, 2, 2);
  translate(75, 0, 0);
  monster.setStroke(true);
  monster.setStroke(color(0));
  monster.setStrokeWeight(2.0f);
  monster.setFill(color(0, 0, 0, 0)); // 0 = fully transparent
  shape(monster);
  popMatrix();
  
  cam.Update();
  camera(cam.x, cam.y, cam.z, cam.targetX, cam.targetY, cam.targetZ, 0, 1, 0);
}

void keyPressed()
{
  if (keyCode == ' ')
  {
    cam.CycleTarget();
  }
}

void mouseWheel(MouseEvent event)
{
  float scrolledAmount = event.getCount();
  // print("Scrolled amount: " + scrolledAmount + "\n");
  cam.Zoom(scrolledAmount);
}
