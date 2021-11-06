class Camera
{
  float x, y, z;
  float r = 200;
  float phi, theta;
  float targetX, targetY, targetZ;
  float derivedX, derivedY, derivedZ;
  PVector[] listOfTargets = new PVector[4];
  
  // Called every frame from within main draw() function
  // Calculates values to pass to void camera() function
  void Update()
  {
    phi = map(mouseX, 0, width - 1, 0, 360);
    theta = map(mouseY, 0, height - 1, 1, 179);
    
    targetX = listOfTargets[currentTargetIndex].x;
    targetY = listOfTargets[currentTargetIndex].y;
    targetZ = listOfTargets[currentTargetIndex].z;
    
    derivedX = r * cos(radians(phi)) * sin(radians(theta));
    derivedY = r * cos(radians(theta));
    derivedZ = r * sin(radians(theta)) * sin(radians(phi));
    
    x = targetX + derivedX;
    y = targetY + derivedY;
    z = targetZ + derivedZ;
  };
  
  // Add a target to the list of positions to cycle through
  void AddLookAtTarget(PVector value)
  {
    listOfTargets[currentTargetIndex] = value;
  }; 
  
  // Move to the next target in the list
  void CycleTarget()
  {
    // Reached end of list, start again from 0
    if (currentTargetIndex == 3)
    {
      currentTargetIndex = 0;
    }
    else
    {
      currentTargetIndex++;
    }
    
    // print("Target index: " + currentTargetIndex + "\n");
    // print("(" + targetX + ", " + targetY + ", " + targetZ + ")\n\n");
    
  }; 
  
  // Move toward or away from the target
  void Zoom(float value)
  {
    r = r + value;
    if (r < 0)
    {
      r *= -1; // So it doesn't zoom in too much and inverts orientation
    }
    // print(r + "\n");
  }; 
};
