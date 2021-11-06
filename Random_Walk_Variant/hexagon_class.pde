class Hexagon extends Walker
{
  float x = (width + 200) / 2;
  float y = height / 2;
  
  void Update()
  {
    int stepGenerated = int(random(7));
    float xOld = x;
    float yOld = y;
    
    if (stepGenerated == 0) // diag btm right
    {
      y = y + ((sqrt(3) * (StepSize * StepScale)))/2;
      float xTemp = (StepSize * StepScale) * sin(radians(30));
      x = x + ((StepSize * StepScale) + xTemp);
    } 
    else if (stepGenerated == 1) // down
    {
      y = y - (sqrt(3) * (StepSize * StepScale));
    } 
    else if (stepGenerated == 2) // diag btm left
    {
      y = y + ((sqrt(3) * StepSize * StepScale))/2;
      float xTemp = (StepSize * StepScale) * sin(radians(30));
      x = x - ((StepSize * StepScale) + xTemp);
    } 
    else if (stepGenerated == 3) // diag top left
    {
      y = y - ((sqrt(3) * StepSize * StepScale))/2;
      float xTemp = (StepSize * StepScale) * sin(radians(30));
      x = x - ((StepSize * StepScale) + xTemp);
    }
    else if (stepGenerated == 4) // up
    {
      y = y + (sqrt(3) * (StepSize * StepScale));
    }
    else if (stepGenerated == 5) // diag top right
    {
      y = y - ((sqrt(3) * (StepSize * StepScale)))/2;
      float xTemp = (StepSize * StepScale) * sin(radians(30));
      x = x + ((StepSize * StepScale) + xTemp);
    }
    
    if (ConstrainSteps == true)
    {
      if ((x - (StepScale * StepSize) < 200) 
      || (x + (StepScale * StepSize) > (width - 1))
      || (y - (StepScale * StepSize) < 0) 
      || (y + (StepScale * StepSize) > (height - 1)))
      {
        x = xOld;
        y = yOld;
      }
      x = constrain(x, 200 + StepSize, (width - 1) - StepSize);
      y = constrain(y, 0 + StepSize, (height - 1) - StepSize);
    }
    else
    {
      if ((x - (StepScale * StepSize) < 200))
      {
        x = xOld;
        y = yOld;
      }
      x = constrain(x, 200 - (StepScale * StepSize), displayWidth);
    }
  }
    
  void Draw() 
  {
    if (UseStroke == false)
    {
      noStroke();
    }
    
    if (SimulateTerrain == false)
    {
      fill(154,78,174);
    }
    else
    {
      PVector point = new PVector((int)x,(int)y);
      
      if (!terrain.containsKey(point))
      {
        terrain.put(point, 0);
      }
      else
      {
        terrain.put(point, terrain.get(point) + 1);
      }
      
      if (terrain.get(point) >= 0 && terrain.get(point) < 4)
      {
        fill(160, 126, 84); // dirt
      }
      else if (terrain.get(point) < 7)
      {
        fill(143, 170, 64); // grass
      }
      else if (terrain.get(point) < 10)
      {
        fill(135, 135, 135); // rock
      } 
      else
      { 
        fill((terrain.get(point))*20); // 200, 220, 240, and 255)
      }
    }
    
    beginShape();
    for (int i = 0; i < 360; i += 60)
    {
      x = x + (cos(radians(i)) * StepSize);
      y = y + (sin(radians(i)) * StepSize);
      vertex((int)x,(int)y);
    }
    endShape(CLOSE);
    
    currentStepCount++;
    // print("Current Step Count: " + currentStepCount + "\n");
  };
};
