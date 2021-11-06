import java.io.*; // Needed for BufferedReader
import queasycam.*;
import controlP5.*;

QueasyCam cam;
ControlP5 cp5;
float xPos = 150;
float zPos = 300;
float speed = 1.0f;

ArrayList<Scene> scenes = new ArrayList<Scene>();
int currentScene = 0;

void setup() {
  size(1200, 1000, P3D);
  pixelDensity(2);
  perspective(radians(60.0f), width/(float)height, 0.1, 1000);
  
  cp5 = new ControlP5(this);
  cp5.addButton("ChangeScene").setPosition(10, 10);
  
  cam = new QueasyCam(this);
  cam.speed = 0;
  cam.sensitivity = 0;
  cam.position = new PVector(0, -50, 100);

  // Load scene files (testfile, scene 1, and scene 2)
  //LoadTestScene("scenes/testfile.txt");
  LoadScene("scenes/scene1.txt");
  LoadScene("scenes/scene2.txt");
  
  lights(); // Lights turned on once here
}

void draw() {
  // Use lights, and set values for the range of lights. 
  // Scene gets REALLY bright this commented out...
  lightFalloff(1.0, 0.001, 0.0001);
  
  pushMatrix();
    rotateZ(radians(180)); // Flip everything upside down because Processing uses -y as up
    // Draw the current scene
    scenes.get(currentScene).DrawScene();
  popMatrix();

  camera();
  noLights(); // Turn lights off for ControlP5 to render correctly
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    // Enable the camera
    cam.sensitivity = 1.0f; 
    cam.speed = 2;
  }

}

void mouseReleased() {  
  if (mouseButton == RIGHT) {
    // "Disable" the camera by setting move and turn speed to 0
    cam.sensitivity = 0; 
    cam.speed = 0;
  }
}

void ChangeScene() {
  currentScene++;
  if (currentScene >= scenes.size())
    currentScene = 0;
}

void DrawText() {
  hint(DISABLE_DEPTH_TEST);
  textSize(30);
  text("PShapes: " + scenes.get(currentScene).GetShapeCount(), 0, 30);
  text("Lights: " + scenes.get(currentScene).GetLightCount(), 0, 60);
  hint(ENABLE_DEPTH_TEST);
}

void LoadTestScene(String filename) {
  try {
    Scene test;
    BufferedReader reader = createReader(filename);
    color background = color(0);
    
    // Read first line
    String line = reader.readLine();
    String meshInfo[] = line.split(",");
    String fileToOpen = meshInfo[0];
    float mx = Float.parseFloat(meshInfo[1]);
    float my = Float.parseFloat(meshInfo[2]);
    float mz = Float.parseFloat(meshInfo[3]);
    int mr = Integer.parseInt(meshInfo[4]);
    int mg = Integer.parseInt(meshInfo[5]);
    int mb = Integer.parseInt(meshInfo[6]);
    
    // Read second line
    line = reader.readLine();
    String lightInfo[] = line.split(",");
    int lx = Integer.parseInt(lightInfo[0]);
    int ly = Integer.parseInt(lightInfo[1]);
    int lz = Integer.parseInt(lightInfo[2]);
    int lr = Integer.parseInt(lightInfo[3]);
    int lg = Integer.parseInt(lightInfo[4]);
    int lb = Integer.parseInt(lightInfo[5]);
    
    // Check values
    /*
    println("File to open: " + fileToOpen);
    println("Mesh coordinates: " + mx + ", " + my + ", " + mz);
    println("Mesh color: " + mr + ", " + mg + ", " + mb);
    println("Light coordinates: " + lx + ", " + ly + ", " + lz);
    println("Light color: " + lr + ", " + lg + ", " + lb);
    */
    
    PShape mesh = loadShape("models/" + fileToOpen + ".obj");
    
    PVector m_xyz = new PVector(mx, my, mz);
    color m_rgb = color(mr, mg, mb);
    Mesh newMesh = new Mesh(mesh, m_xyz, m_rgb);
    Mesh meshes[] = new Mesh[1];
    meshes[0] = newMesh;
    
    PVector l_xyz = new PVector(lx, ly, lz);
    color l_rbg = color(lr, lg, lb);
    Light newLight = new Light(l_xyz, l_rbg);
    Light lights[] = new Light[1];
    lights[0] = newLight;
    
    test = new Scene(background, meshes, lights);
    scenes.add(test);
  }
  catch (IOException e) { // In case something went wrong during process
    e.printStackTrace();
  }
}

void LoadScene(String filename) {
  try {
    Scene scene;
    BufferedReader reader = createReader(filename);
    Mesh[] meshes;
    Light[] lights;
    
    String line = reader.readLine();
    String threeValues[] = line.split(",");
    int br = Integer.parseInt(threeValues[0]);
    int bg = Integer.parseInt(threeValues[1]);
    int bb = Integer.parseInt(threeValues[2]);
    color background = color(br, bg, bb);
    
    line = reader.readLine();
    int meshCounter = Integer.parseInt(line);
    meshes = new Mesh[meshCounter];
    
    for (int i = 0; i < meshCounter; i++) {
      line = reader.readLine();
      String meshInfo[] = line.split(",");
      String fileToOpen = meshInfo[0];
      float mx = Float.parseFloat(meshInfo[1]);
      float my = Float.parseFloat(meshInfo[2]);
      float mz = Float.parseFloat(meshInfo[3]);
      int mr = Integer.parseInt(meshInfo[4]);
      int mg = Integer.parseInt(meshInfo[5]);
      int mb = Integer.parseInt(meshInfo[6]);
      
      // Check values
      /*
      println("File to open: " + fileToOpen);
      println("Mesh coordinates: " + mx + ", " + my + ", " + mz);
      println("Mesh color: " + mr + ", " + mg + ", " + mb);
      */
      
      PShape mesh = loadShape("models/" + fileToOpen + ".obj");
      
      PVector m_xyz = new PVector(mx, my, mz);
      color m_rgb = color(mr, mg, mb);
      Mesh newMesh = new Mesh(mesh, m_xyz, m_rgb);
      meshes[i] = newMesh;
    }
    
    line = reader.readLine();
    int lightCounter = Integer.parseInt(line);
    lights = new Light[lightCounter];
    
    for (int i = 0; i < lightCounter; i++) {
      line = reader.readLine();
      String lightInfo[] = line.split(",");
      float lx = Float.parseFloat(lightInfo[0]);
      float ly = Float.parseFloat(lightInfo[1]);
      float lz = Float.parseFloat(lightInfo[2]);
      int lr = Integer.parseInt(lightInfo[3]);
      int lg = Integer.parseInt(lightInfo[4]);
      int lb = Integer.parseInt(lightInfo[5]);
      
      // Check values
      /*
      println("Light coordinates: " + lx + ", " + ly + ", " + lz);
      println("Light color: " + lr + ", " + lg + ", " + lb);
      */
      
      PVector l_xyz = new PVector(lx, ly, lz);
      color l_rbg = color(lr, lg, lb);
      Light newLight = new Light(l_xyz, l_rbg);
      lights[i] = newLight;
    }
    
    scene = new Scene(background, meshes, lights);
    scenes.add(scene);
  }
  catch (IOException e) { // In case something went wrong during process
    e.printStackTrace();
  }
}
