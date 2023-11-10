public class ObjectManager{

  ArrayList<Vertex> vertices;
  ArrayList<Edge> edges;
  
  public ObjectManager(){
    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<Edge>();
  }
  
  public int numVertices(){
    return vertices.size();
  }

}
