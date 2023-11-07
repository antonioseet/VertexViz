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
  
  // Returns whether you have clicked within a vertex's radius.
  public static boolean vertexToMoveClicked(ArrayList<Vertex> list, float mouseX, float mouseY){
      for(Vertex v : list){
        if(MathHelper.distanceBetweenVertexAndMouse(v, mouseX, mouseY) < v.d){
          Global.movingVertex = v;
          return true;
        }
      }
      return false;
  }
  
  public static void printEdges(ArrayList<Edge> edges){
    String s = "";
    for(Edge e : edges)
      s += " | Edge: v1(" + e.v1.x + ", " + e.v1.y + "), v2(" + e.v2.x + ", " + e.v2.y + ")";
    println(s);
  }
  
  public static void printVertices(ArrayList<Vertex> vertices){
    String s = "";
    for(Vertex v : vertices)
      s += " | Vertex: (" + v.x + ", " + v.y + ") ";
    println(s);
  }

}
