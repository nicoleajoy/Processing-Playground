// VertexAnimation Project
import java.io.*;
import java.util.*;

Camera cam;

/*========== Monsters ==========*/
Animation monsterAnim;
ShapeInterpolator monsterForward = new ShapeInterpolator();
ShapeInterpolator monsterReverse = new ShapeInterpolator();
ShapeInterpolator monsterSnap = new ShapeInterpolator();

/*========== Sphere ==========*/
Animation sphereAnim; // Load from file
Animation spherePos; // Create manually
ShapeInterpolator sphereForward = new ShapeInterpolator();
PositionInterpolator spherePosition = new PositionInterpolator();

/*========== Cubes ==========*/
// Create animations for interpolators
ArrayList<PositionInterpolator> cubes = new ArrayList<PositionInterpolator>();

void setup()
{
  cam = new Camera();
  pixelDensity(2);
  size(1200, 800, P3D);
 
  /*====== Load Animations ======*/
  monsterAnim = ReadAnimationFromFile("monster.txt");
  sphereAnim = ReadAnimationFromFile("sphere.txt");

  /*====== Set Animations ======*/
  monsterForward.SetAnimation(monsterAnim);
  monsterReverse.SetAnimation(monsterAnim);
  monsterSnap.SetAnimation(monsterAnim);
  monsterSnap.SetFrameSnapping(true);
  sphereForward.SetAnimation(sphereAnim);

  /*====== Create Animations For Cubes ======*/
  // When initializing animations, to offset them
  // you can "initialize" them by calling Update()
  // with a time value update. Each is 0.1 seconds
  // ahead of the previous one
  float offsetCounter = 0;
  for (int x = -100; x <= 100; x += 20)
  {
    PositionInterpolator cubePosition = new PositionInterpolator();
    cubePosition.currentPosition = new PVector(x, 0, 0);
    cubePosition.currentTime = offsetCounter;
    offsetCounter += 0.1;
    Animation cubePos = new Animation();
    
    for (int i = 0; i < 4; i++)
    {
      KeyFrame cubeKeyFrame = new KeyFrame();
      PVector point = new PVector();
      
      // Set frame snapping first (alternate between every other cube)
      if (x == -100 || x == -60 || x == -20 || x == 20 || x == 60 || x == 100)
      {
        cubePosition.SetFrameSnapping(false);
      }
      else if (x == -80 || x == -40 || x == 0 || x == 40 || x == 80)
      {
        cubePosition.SetFrameSnapping(true);
      }
      
      // Initialize key frame data
      if (i == 0)
      {
        cubeKeyFrame.time = 0.5;
        point = new PVector(x, 0, 0);
      }
      else if (i == 1)
      {
        cubeKeyFrame.time = 1;
        point = new PVector(x, 0, -100);
      }
      else if (i == 2)
      {
        cubeKeyFrame.time = 1.5;
        point = new PVector(x, 0, 0);
      }
      else if (i == 3)
      {
        cubeKeyFrame.time = 2;
        point = new PVector(x, 0, 100);
      }
      cubeKeyFrame.points.add(point);
      cubePos.keyFrames.add(cubeKeyFrame);
    }
    
    cubePosition.SetAnimation(cubePos);
    cubes.add(cubePosition);
  }
  
  /*====== Create Animations For Spheroid ======*/
  // Create and set keyframes
  spherePos = new Animation();
  
  KeyFrame frame0 = new KeyFrame();
  KeyFrame frame1 = new KeyFrame();
  KeyFrame frame2 = new KeyFrame();
  KeyFrame frame3 = new KeyFrame();
  PVector loc = new PVector(0,0,0);
  
  frame0.time = 1;
  loc = new PVector(-100, 0, 100);
  frame0.points.add(loc);
  
  frame1.time = 2;
  loc = new PVector(-100, 0, -100);
  frame1.points.add(loc);
  
  frame2.time = 3;
  loc = new PVector(100, 0, -100);
  frame2.points.add(loc);
  
  frame3.time = 4;
  loc = new PVector(100, 0, 100);
  frame3.points.add(loc);
  
  spherePos.keyFrames.add(frame0);
  spherePos.keyFrames.add(frame1);
  spherePos.keyFrames.add(frame2);
  spherePos.keyFrames.add(frame3);
  
  spherePosition.SetAnimation(spherePos);
  spherePosition.SetFrameSnapping(false);
}


void draw()
{
  lights();
  background(0);
  DrawGrid();

  float playbackSpeed = 0.005f;

  // Implement your own camera
  cam.Update();
  camera(cam.x, cam.y, cam.z, cam.targetX, cam.targetY, cam.targetZ, 0, 1, 0);

  /*====== Draw Forward Monster ======*/
  pushMatrix();
  translate(-40, 0, 0);
  monsterForward.fillColor = color(128, 200, 54);
  monsterForward.Update(playbackSpeed);
  shape(monsterForward.currentShape);
  popMatrix();
  
  /*====== Draw Reverse Monster ======*/
  pushMatrix();
  translate(40, 0, 0);
  monsterReverse.fillColor = color(220, 80, 45);
  monsterReverse.Update(-playbackSpeed);
  shape(monsterReverse.currentShape);
  popMatrix();
  
  /*====== Draw Snapped Monster ======*/
  pushMatrix();
  translate(0, 0, -60);
  monsterSnap.fillColor = color(160, 120, 85);
  monsterSnap.Update(playbackSpeed);
  shape(monsterSnap.currentShape);
  popMatrix();
  
  /*====== Draw Spheroid ======*/
  spherePosition.Update(playbackSpeed);
  sphereForward.fillColor = color(39, 110, 190);
  sphereForward.Update(playbackSpeed);
  PVector spherePos = spherePosition.currentPosition;
  pushMatrix();
  translate(spherePos.x, spherePos.y, spherePos.z);
  shape(sphereForward.currentShape);
  popMatrix();
  
  /*====== Update and draw cubes ======*/
  // For each interpolator, update/draw
  for (int i = 0; i < cubes.size(); i++) 
  {
    cubes.get(i).Update(playbackSpeed);
    PVector cubePos = cubes.get(i).currentPosition;
    pushMatrix();
    noStroke();
    if (cubes.get(i).snapping == false)
    {
      fill(255,0,0); // Red
    }
    else
    {
      fill(255,240,0); // Yellow
    }
    translate(cubePos.x, cubePos.y, cubePos.z);
    box(15);
    popMatrix();
  }
}

void mouseWheel(MouseEvent event)
{
  float e = event.getCount();
  cam.Zoom(e);
}

// Create and return an animation object
Animation ReadAnimationFromFile(String fileName)
{
  Animation animation = new Animation();

  // The BufferedReader class will let you read in the file data
  try
  {
    BufferedReader reader = createReader(fileName);
    String line;
    
    line = reader.readLine(); // Number of keyframes;
    int keyFrameCount = Integer.parseInt(line);
    
    line = reader.readLine(); // Number of data points
    int dataPointCount = Integer.parseInt(line);
    
    for (int i = 0; i < keyFrameCount; i++)
    {
      KeyFrame frame = new KeyFrame();
      line = reader.readLine(); // Time of current keyframe
      float time = Float.parseFloat(line);
      frame.time = time;
      for (int j = 0; j < dataPointCount; j++)
      {
        PVector vertex = new PVector();
        line = reader.readLine();
        String vertexLocation[] = line.split(" ");
        vertex.x = Float.parseFloat(vertexLocation[0]);
        vertex.y = Float.parseFloat(vertexLocation[1]);
        vertex.z = Float.parseFloat(vertexLocation[2]);
        frame.points.add(vertex);
      }
      animation.keyFrames.add(frame);
    }
  }
  catch (FileNotFoundException ex)
  {
    println("File not found: " + fileName);
    
  }
  catch (IOException ex)
  {
    ex.printStackTrace();
  }
 
  return animation;
}

void DrawGrid()
{
  // Draw the grid
  // Dimensions: 200x200 (-100 to +100 on X and Z)
  
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
}
