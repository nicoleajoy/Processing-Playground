abstract class Interpolator
{
  Animation animation;
  
  // Where we at in the animation?
  float currentTime = 0;
  
  // To interpolate, or not to interpolate... that is the question
  boolean snapping = false;
  
  void SetAnimation(Animation anim)
  {
    animation = anim;
  }
  
  void SetFrameSnapping(boolean snap)
  {
    snapping = snap;
  }
  
  void UpdateTime(float time)
  {
    // Update the current time
    // Check to see if the time is out of bounds (0 / Animation_Duration)
    // If so, adjust by an appropriate amount to loop correctly
    
    currentTime += time;
    
    if (currentTime > animation.GetDuration()) // End of forward animation
    {
      currentTime = 0; 
    }
    else if (currentTime < 0) // End of inverse animation
    {
      currentTime = animation.GetDuration();
    }
  }
  
  // Implement this in derived classes
  // Each of those should call UpdateTime() and pass the time parameter
  // Call that function FIRST to ensure proper synching of animations
  abstract void Update(float time);
}

class ShapeInterpolator extends Interpolator
{
  // The result of the data calculations - either snapping or interpolating
  PShape currentShape = new PShape();
  
  // Changing mesh colors
  color fillColor;
  
  PShape GetShape()
  {
    return currentShape;
  }
  
  void Update(float time)
  {
    UpdateTime(time);
    
    // Create a new PShape by interpolating between 
    // two existing key frames using linear interpolation
    
    if (snapping == true) {
      for (int i = 0; i < animation.keyFrames.size(); i++)
      {
        if (currentTime < animation.keyFrames.get(0).time)
        {
          currentShape = new PShape();
          currentShape = createShape();
          currentShape.setStroke(false);
          currentShape.beginShape(TRIANGLE);
          currentShape.fill(fillColor);
          for (int j = 0; j < animation.keyFrames.get(animation.keyFrames.size()-1).points.size(); j++)
          {
            PVector currentVertex = animation.keyFrames.get(animation.keyFrames.size()-1).points.get(j);
            currentShape.vertex(currentVertex.x, currentVertex.y, currentVertex.z);
          }
          currentShape.endShape();
        }
        else if (currentTime > animation.keyFrames.get(i).time)
        {
          currentShape = new PShape();
          currentShape = createShape();
          currentShape.setStroke(false);
          currentShape.beginShape(TRIANGLE);
          currentShape.fill(fillColor);
          for (int j = 0; j < animation.keyFrames.get(i).points.size(); j++) 
          {
            PVector currentVertex = animation.keyFrames.get(i).points.get(j);
            currentShape.vertex(currentVertex.x, currentVertex.y, currentVertex.z);
          }
          currentShape.endShape();
        }
      }
    }
    else // Linear interpolate
    {
      KeyFrame previous = animation.keyFrames.get(animation.keyFrames.size()-1);
      KeyFrame next = animation.keyFrames.get(0);
      
      float timeRatio = 0;
      
      for (int i = 0; i < animation.keyFrames.size(); i++)
      {
        if (currentTime < animation.keyFrames.get(0).time)
        {
          timeRatio = (currentTime) / (next.time);
        }
        else if (currentTime > animation.keyFrames.get(i).time)
        {
          previous = animation.keyFrames.get(i);
          next = animation.keyFrames.get(i+1);
          timeRatio = (currentTime - previous.time) / (next.time - previous.time);
        }
        
        PVector currentPosition = new PVector(0,0,0);
        currentShape = new PShape();
        currentShape = createShape();
        currentShape.setStroke(false);
        currentShape.beginShape(TRIANGLE);
        currentShape.fill(fillColor);
        for (int j = 0; j < animation.keyFrames.get(i).points.size(); j++) 
        {
          currentPosition.x = previous.points.get(j).x + (timeRatio * (next.points.get(j).x - previous.points.get(j).x));
          currentPosition.y = previous.points.get(j).y + (timeRatio * (next.points.get(j).y - previous.points.get(j).y));
          currentPosition.z = previous.points.get(j).z + (timeRatio * (next.points.get(j).z - previous.points.get(j).z));
          
          currentShape.vertex(currentPosition.x, currentPosition.y, currentPosition.z);
        }
        currentShape.endShape();
      }
    }
  }
}

class PositionInterpolator extends Interpolator
{
  // The result of the data calculations - either snapping or interpolating
  PVector currentPosition = new PVector(0,0,0);
  
  void Update(float time)
  {
    UpdateTime(time);
    
    // The same type of process as the ShapeInterpolator class... 
    // except this only operates on a single point
    
    if (snapping == true) {
      for (int i = 0; i < animation.keyFrames.size(); i++)
      {
        if (currentTime < animation.keyFrames.get(0).time)
        {
          currentPosition = animation.keyFrames.get(animation.keyFrames.size()-1).points.get(0);
        }
        else if (currentTime > animation.keyFrames.get(i).time)
        {
          currentPosition = animation.keyFrames.get(i).points.get(0);
        }
      }
    }
    else // Linear interpolate
    {
      KeyFrame previous = animation.keyFrames.get(animation.keyFrames.size()-1);
      KeyFrame next = animation.keyFrames.get(0);
      float timeRatio = 0;
      
      for (int i = 0; i < animation.keyFrames.size(); i++)
      {
        if (currentTime < animation.keyFrames.get(0).time)
        {
          timeRatio = (currentTime) / (next.time);
        }
        else if (currentTime > animation.keyFrames.get(i).time)
        {
          previous = animation.keyFrames.get(i);
          next = animation.keyFrames.get(i+1);
          timeRatio = (currentTime - previous.time) / (next.time - previous.time);
        }
        currentPosition.x = previous.points.get(0).x + (timeRatio * (next.points.get(0).x - previous.points.get(0).x));
        currentPosition.z = previous.points.get(0).z + (timeRatio * (next.points.get(0).z - previous.points.get(0).z));
      }
    }
  }
}
