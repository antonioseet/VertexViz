public static class MathHelper{
  
  public static Vertex lastVertex;
  
  // Returns whether you have clicked within a vertex's radius.
  public static boolean vertexClicked(ArrayList<Vertex> list, float mouseX, float mouseY){
  
      for(Vertex v : list){
        if(MathHelper.distanceBetweenVertexAndMouse(v, mouseX, mouseY) < v.d){
          lastVertex = v;
          return true;
        }
      }
      return false;
  }
  
  // Returns the distance between a vertex and the mouse pointer
  public static float distanceBetweenVertexAndMouse(Vertex v, float mouseX, float mouseY) {
    float diffX = (float)v.x - mouseX;
    float diffY = (float)v.y - mouseY;
    return sqrt(diffX * diffX + diffY * diffY);
  }


}
