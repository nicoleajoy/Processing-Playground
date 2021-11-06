import controlP5.*;
ControlP5 cp5;


// Random_Walker object
Walker w;

// Variables for buttons and sliders
boolean ToggleColor;
boolean ToggleGradual;
int SliderIterations;
int SliderStepCount;

// Helper variables
int currentStepCount = 0;
boolean startGradual = false;


class Walker
{
  int x = width/2;
  int y = height/2;
  
  void step() 
  {
    int stepGenerated = int(random(4));
    if (stepGenerated == 0) 
    {
      y++; //up
    } 
    else if (stepGenerated == 1) 
    {
      y--; //down
    } 
    else if (stepGenerated == 2) 
    {
      x--; //left
    } 
    else if (stepGenerated == 3) 
    {
      x++; //right
    }
  }
  
  void display(int value) 
  {
    if (ToggleColor == true) 
    {
      float m = map(value, 0, SliderIterations, 0, 255);
      stroke(m);
    }
    else 
    {
      stroke(0);
    }
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);
    point(x,y);
    currentStepCount++;
  }
}


void setup() 
{
  size(800,800);
  background(145,174,214);
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("ButtonStart")
     .setCaptionLabel("Start");
  
  cp5.addToggle("ToggleColor")
     .setLabel("Color")
     .setPosition(100,30);
     
  cp5.addToggle("ToggleGradual")
     .setLabel("Gradual")
     .setPosition(150,30);
  
  cp5.addSlider("SliderIterations")
     .setLabel("Iterations")
     .setRange(1000,500000)
     .setPosition(200,30);
  
  cp5.addSlider("SliderStepCount")
     .setLabel("Step Count")
     .setRange(1,1000)
     .setPosition(200,45);
     
  w = new Walker();
}


void draw() 
{
  if ((ToggleGradual == true) && (startGradual == true) && (currentStepCount <= SliderIterations))
  {
    for (int i = 0; i < SliderStepCount; i++) 
    {
      w.step();
      w.display(currentStepCount);
      //print("Steps: " + currentStepCount + "\n");
    }
    
    // One may choose to have an odd step count value with even iterations (or vice versa).
    // Thus, when drawing the steps each frame, the program may draw MORE than necessary at the end.
    // The code below was written to address this case.
    // It works better to let the program finish running before changing interation value.
    if (currentStepCount == (SliderStepCount * (SliderIterations / SliderStepCount)))
    {
      int remainder = SliderIterations % SliderStepCount;
      for (int i = 0; i < remainder; i++) 
      {
        w.step();
        w.display(currentStepCount);
        //print("Steps: " + currentStepCount + "\n");
      }
      startGradual = false;
    }
  }
}


void drawImmediate() 
{
  for (int i = 0; i < SliderIterations; i++) 
  {
    w.step();
    w.display(i);
  }
}


void ButtonStart() 
{
  // Reset values
  background(145,174,214);
  w.x = width/2;
  w.y = height/2;
  currentStepCount = 0;
  
  if (ToggleGradual == false) 
  {
    drawImmediate();
  }
  else 
  {
    startGradual = true;
    //draw();
  }
}
