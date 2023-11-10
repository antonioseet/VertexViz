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
  
  // Returns whether you have clicked within a vertex's radius.
  public static boolean vertexToDeleteClicked(ArrayList<Vertex> vertices, ArrayList<Edge> edges, float mouseX, float mouseY){
      ArrayList<Edge> edgesToRemove = new ArrayList<Edge>();
      
      Vertex deleteVertex = null;
      
      // Check to see which vertex was clicked, then save it to compare the edges to determine what gets deleted.
      for(Vertex v : vertices){
        if(MathHelper.distanceBetweenVertexAndMouse(v, mouseX, mouseY) < v.d){
          deleteVertex = v;
        }
      }
      
      
      vertices.remove(deleteVertex);
      
      // If we find an vertex was clicked, we can try to remove every edge associated with that vertex.
      // We save the index for every edge that matches.
      if(deleteVertex != null){
        for(int i = 0; i < edges.size(); i++){
          Edge e = edges.get(i);
          int vx = deleteVertex.x;
          int vy = deleteVertex.y;
          
          int v1x = e.v1.x;
          int v1y = e.v1.y;
          int v2x = e.v2.x;
          int v2y = e.v2.y;
          
          // Check if the vertex match either Edge.vertex.
          if((vx == v1x && vy == v1y) || (vx == v2x && vy == v2y)){
            edgesToRemove.add(e);
          }          
        }
        
        for(Edge e : edgesToRemove){
          edges.remove(e);
        }
        
      }
      
      return !edgesToRemove.isEmpty();
  }
    
   // Helper function to calculate the distance of a point from a line segment
  public static float pointLineDistance(float x1, float y1, float x2, float y2, float px, float py) {
    float norm = dist(x1, y1, x2, y2);
    if (norm == 0) return dist(px, py, x1, y1);
    float u = ((px - x1) * (x2 - x1) + (py - y1) * (y2 - y1)) / (norm * norm);
    u = constrain(u, 0, 1);
    float x = x1 + u * (x2 - x1);
    float y = y1 + u * (y2 - y1);
    return dist(px, py, x, y);
  }
  
  // The main method to remove edges close to the mouse click
  public static boolean removeEdgesNearMouse(ArrayList<Edge> edges, float mouseX, float mouseY) {
    ArrayList<Edge> edgesToRemove = new ArrayList<Edge>();
    
    // Check each edge to see if the mouse is close to it
    for (Edge edge : edges) {
      float d = pointLineDistance(edge.v1.x, edge.v1.y, edge.v2.x, edge.v2.y, mouseX, mouseY);
      if (d < 5.0) { // If the mouse is within the 'proximityThreshold' distance from the edge
        edgesToRemove.add(edge);
      }
    }
  
    // Remove all edges that were too close to the mouse click
    edges.removeAll(edgesToRemove);
    
    // Return true if any edges were removed
    return !edgesToRemove.isEmpty();
  }

  public static int findMidPoint(Edge e){
    return (e.v1.x + e.v2.x) / 2;
  }
  
  public static int findMidPointY(Edge e){
    return (e.v2.y + e.v1.y) /2;
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
