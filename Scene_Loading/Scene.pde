class Scene {
  color background;
  Mesh[] meshes;
  Light[] lights;
  
  Scene(color bg, Mesh[] m, Light[] l) {
    background = bg;
    
    meshes = new Mesh[m.length];
    for (int i = 0; i < m.length; i++)
      meshes[i] = m[i];
      
    lights = new Light[l.length];
    for (int i = 0; i < l.length; i++)
      lights[i] = l[i];
  }
  
  void DrawScene() {
    background(background);
    
    for (int i = 0; i < lights.length; i++) {
      pointLight(red(lights[i].colour), green(lights[i].colour), blue(lights[i].colour),
                 lights[i].location.x, lights[i].location.y, lights[i].location.z);
    }
    
    for (int i = 0; i < meshes.length; i++) {
      pushMatrix();
        translate(meshes[i].location.x, meshes[i].location.y, meshes[i].location.z);
        meshes[i].object.setFill(meshes[i].colour);
        shape(meshes[i].object);
      popMatrix();
    }
  }
  
  int GetShapeCount() {
    return meshes.length;
  }
  
  int GetLightCount() {
    return lights.length;
  }
};
