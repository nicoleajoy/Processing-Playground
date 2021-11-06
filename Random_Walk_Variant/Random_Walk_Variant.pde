import controlP5.*;
ControlP5 cp5;


DropdownList listOfShapes;
int MaximumSteps; //3
int StepRate; //4
int StepSize; //5
float StepScale; //6
boolean ConstrainSteps; //7
boolean SimulateTerrain; //8
boolean UseStroke; //9
boolean UseRandomSeed; //10
String InputSeedValue;
int seedValue; //11
int currentStepCount;
boolean startClicked;
HashMap<PVector,Integer> terrain;
Walker randomWalk = null;


void setup() 
{
  size(1200,800);
  stroke(0);
  strokeWeight(1);
  fill(100);
  rect(0, 0, 200, height - 1);
  
  cp5 = new ControlP5(this);
  
  // 1. Button start
  cp5.addButton("ButtonStart")
     .setCaptionLabel("Start")
     .setColorBackground(color(0,160,0));
  
  // 2. Dropdown list
  listOfShapes = cp5.addDropdownList("DropdownList")
     .setLabel("Select Shape")
     .setPosition(10,60)
     .setItemHeight(32)
     .setBarHeight(32)
     .addItem("Squares", 0)
     .addItem("Hexagons", 1);
  
  // 3. Slider for maximum steps
  cp5.addTextlabel("LabelMax")
     .setText("Maximum Steps")
     .setPosition(10,200);
  cp5.addSlider("MaximumSteps")
     .setPosition(10,210)
     .setRange(100,50000)
     .setSize(180,20);
  cp5.getController("MaximumSteps").getCaptionLabel().setVisible(false);
     
  // 4. Slider for step rate
  cp5.addTextlabel("LabelRate")
     .setText("Step Rate")
     .setPosition(10,240);
  cp5.addSlider("StepRate")
     .setPosition(10,250)
     .setRange(1,1000)
     .setSize(180,20);
  cp5.getController("StepRate").getCaptionLabel().setVisible(false);
  
  // 5. Slider for step size
  cp5.addTextlabel("LabelSize")
     .setText("Step Size")
     .setPosition(10,300);
  cp5.addSlider("StepSize")
     .setPosition(10,310)
     .setRange(10,30)
     .setSize(80,20);
  cp5.getController("StepSize").getCaptionLabel().setVisible(false);
  
  // 6. Slider for step scale
  cp5.addTextlabel("LabelScale")
     .setText("Step Scale")
     .setPosition(10,340);
  cp5.addSlider("StepScale")
     .setPosition(10,350)
     .setRange(1.0,1.5)
     .setSize(80,20);
  cp5.getController("StepScale").getCaptionLabel().setVisible(false);
  
  // 7. Toggle constrain steps
  cp5.addToggle("ConstrainSteps")
     .setLabel("Constrain steps")
     .setPosition(10,410)
     .setSize(25,20);
     
  // 8. Toggle simulate terrain
  cp5.addToggle("SimulateTerrain")
     .setLabel("Simulate Terrain")
     .setPosition(10,450)
     .setSize(25,20);
     
  // 9. Toggle use stroke
  cp5.addToggle("UseStroke")
     .setLabel("Use Stroke")
     .setPosition(10,490)
     .setSize(25,20);
     
  // 10. Toggle use random seed
  cp5.addToggle("UseRandomSeed")
     .setLabel("Use Random Seed")
     .setPosition(10,530)
     .setSize(25,20);
     
  // 11. Textfield seed value
  cp5.addTextfield("InputSeedValue")
     .setLabel("Seed Value")
     .setSize(50,20)
     .setInputFilter(ControlP5.INTEGER)
     .setPosition(110,530);
}


void draw()
{
  if (startClicked == true && currentStepCount < MaximumSteps)
  {
    for (int i = 0; i < StepRate; i++)
    {
      randomWalk.Update();
      randomWalk.Draw();
      
      if (currentStepCount == MaximumSteps)
      {
          startClicked = false;
      }
    }
  }
}


void ButtonStart()
{ 
  // Reset some values
  currentStepCount = 0;
  terrain = new HashMap();
  
  // Create new walker according to dropdown list
  if(listOfShapes.getValue() == 0)
  {
    background(204); // gray for square
    randomWalk = new Square();
  }
  else if (listOfShapes.getValue() == 1)
  {
    background(100,149,237); // blue for hexagon
    randomWalk = new Hexagon();
  }
  
  // Draw UI area
  stroke(0);
  strokeWeight(1);
  fill(100);
  rect(0, 0, 200, height - 1);
  
  if ((UseRandomSeed == true) && (InputSeedValue != null) && (InputSeedValue.length() != 0))
  {
    //print("Using Random Seed\n");
    seedValue = Integer.parseInt(InputSeedValue);
    randomSeed(seedValue);
  }
  
  // Ready to Update() and Draw()
  startClicked = true;
}
