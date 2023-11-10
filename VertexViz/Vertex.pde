// Vertex representation with coordinates and diameter

public class Vertex{
  
  public int x,y,d;
  public float randomX, randomY;
  
  public Vertex(int x, int y, int d){
    this.x = x;
    this.y = y;
    this.d = d;
    this.randomX = random(0,10);
    this.randomY = random(0,10);
  }
  
  public Vertex(Vertex v){
    x = v.x;
    y = v.y;
    d = v.d;
    randomX = v.randomX;
    randomY = v.randomY;
  }
  
  public void updateSize(int newDiameter){
    this.d = newDiameter;
  }
  
  public void updatePosition(int x, int y){
    this.x = x;
    this.y = y;
  }
    
  // Update the vertex position
  public void move() {
    x += randomX;
    y += randomY;
    checkBounds();
  }
  
  // Check if the vertex has hit the window's limits
  private void checkBounds() {
    if (x <= 0 || x >= 1200) {
      randomX *= -1; // Reverse direction in the x axis
    }
    if (y <= 0 || y >= 800) {
      randomY *= -1; // Reverse direction in the y axis
    }
  }
}
