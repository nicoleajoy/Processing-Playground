class Square extends Walker
{
  float x = (width + 200) / 2;
  float y = height / 2;
  
  void Update()
  {
    int stepGenerated = int(random(4));
    float xOld = x;
    float yOld = y;
    
    if (stepGenerated == 0) 
    {
      y = y + (StepSize * StepScale); // up
    } 
    else if (stepGenerated == 1) 
    {
      y = y - (StepSize * StepScale); // down
    } 
    else if (stepGenerated == 2) 
    {
      x = x - (StepSize * StepScale); // left
    } 
    else if (stepGenerated == 3) 
    {
      x = x + (StepSize * StepScale); // right
    }
    
    if (ConstrainSteps == true)
    {
      if ((x - (StepScale * StepSize) / 2 < 200) 
      || (x + (StepScale * StepSize) / 2 > (width - 1))
      || (y - (StepScale * StepSize) / 2 < 0) 
      || (y + (StepScale * StepSize) / 2 > (height - 1)))
      {
        x = xOld;
        y = yOld;
      }
      x = constrain(x, 200 + StepSize, (width - 1) - StepSize);
      y = constrain(y, 0 + StepSize, (height - 1) - StepSize);
    }
    else
    {
      if ((x - (StepScale * StepSize) / 2 < 200)) {
        x = xOld;
        y = yOld;
      }
      x = constrain(x, 200 - (StepSize * StepScale), displayWidth);
    }
  };
  
  void Draw()
  {
    rectMode(CENTER);
    
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
      PVector point = new PVector(x,y);
      
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
    
    rect(x,y,StepSize,StepSize);
    
    rectMode(CORNER);
    
    currentStepCount++;
    // print("Current Step Count: " + currentStepCount + "\n");
  }
};
