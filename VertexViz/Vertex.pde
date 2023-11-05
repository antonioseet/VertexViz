// Vertex representation with coordinates and diameter

public class Vertex{
  
  public int x,y,d;
  
  public Vertex(int x, int y, int d){
    this.x = x;
    this.y = y;
    this.d = d;
  }
  
  public void updateSize(int newDiameter){
    this.d = newDiameter;
  }
    
}
