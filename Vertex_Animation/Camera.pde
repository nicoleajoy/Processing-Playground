class Camera
{
  float x, y, z;
  float r = 250;
  float phi, theta;
  float targetX, targetY, targetZ;
  float derivedX, derivedY, derivedZ;
  
  // Called every frame from within main draw() function
  // Calculates values to pass to void camera() function
  void Update()
  { 
    phi = map(mouseX, 0, width - 1, 0, 360);
    theta = map(mouseY, 0, height - 1, 1, 179);
    
    targetX = 0;
    targetY = 0;
    targetZ = 0;
    
    derivedX = r * cos(radians(phi)) * sin(radians(theta));
    derivedY = r * cos(radians(theta));
    derivedZ = r * sin(radians(theta)) * sin(radians(phi));
    
    x = targetX + derivedX;
    y = targetY + derivedY;
    z = targetZ + derivedZ;
  };
  
  // Move toward or away from the target
  void Zoom(float value)
  {
    r = r + value;
    if (r < 0)
    {
      r *= -1; // Inverts orientation when max zoomed in
    }
  }; 
};
