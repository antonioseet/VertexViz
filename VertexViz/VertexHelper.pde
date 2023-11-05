public static class VertexHelper{
  
  // Returns whether you have clicked within a vertex's radius.
  public static boolean vertexClicked(ArrayList<Vertex> list, float mouseX, float mouseY){
      for(Vertex v : list){
        if(MathHelper.distanceBetweenVertexAndMouse(v, mouseX, mouseY) < v.d){
          Global.vertex1 = v;
          return true;
        }
      }
      return false;
  }

  // Returns whether you have clicked within a vertex's radius.
  public static boolean vertexEndClicked(ArrayList<Vertex> list, float mouseX, float mouseY){
      for(Vertex v : list){
        if(MathHelper.distanceBetweenVertexAndMouse(v, mouseX, mouseY) < v.d){
          Global.vertex2 = v;
          return true;
        }
      }
      return false;
  }

}
