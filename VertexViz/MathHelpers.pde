public static class MathHelper{
  
  // Returns the distance between a vertex and the mouse pointer
  public static float distanceBetweenVertexAndMouse(Vertex v, float mouseX, float mouseY) {
    float diffX = (float)v.x - mouseX;
    float diffY = (float)v.y - mouseY;
    return sqrt(diffX * diffX + diffY * diffY);
  }


}
