/* Created by Tony Barrera */

// Global Variables
ArrayList<Vertex> vertices = new ArrayList<Vertex>();
ArrayList<Edge> edges = new ArrayList<Edge>();
int NodeDiameter = 20;

// Runs once when the program starts.
void setup() {
  size(1200, 800);
  background(0);
}

void draw() {
  
  for(int i = 0; i < vertices.size(); i++){
    Vertex v = vertices.get(i);
    circle(v.x, v.y, v.d);
  }
  
  for(int i = 0; i < edges.size(); i++){
    Edge e = edges.get(i);
    line(e.v1.x, e.v1.y, e.v2.x, e.v2.y);
  }
  
}

void mouseClicked(){
  vertices.add(new Vertex(mouseX, mouseY, NodeDiameter));
}
