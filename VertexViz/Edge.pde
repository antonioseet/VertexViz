// Edge represenation with coordinates for both ends.

public class Edge{
  
  public Vertex v1, v2;
  
  public Edge(Vertex v1, Vertex v2){
    this.v1 = v1;
    this.v2 = v2;
  }
  
  public boolean isLoop(){
    return v1.x == v2.x && v1.y == v2.y;
  }
}
