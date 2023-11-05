/* Created by Tony Barrera */

// Global Variables
ArrayList<Vertex> vertices = new ArrayList<Vertex>();
ArrayList<Edge> edges = new ArrayList<Edge>();
int NodeDiameter = 20;

State state = State.ADDING;

// Last Vertex, try to ckeep track of the last clicked vertex to assign edges, might work. 
//Vertex lastVertex; keep it in MAthHelpers

// Runs once when the program starts.
void setup() {
  size(1200, 800);
  background(255);
}

void draw() {
  
  for(Vertex v : vertices){
    circle(v.x, v.y, v.d);
  }
  
  for(Edge e : edges){
    line(e.v1.x, e.v1.y, e.v2.x, e.v2.y);
  }
  
  switch(state){
    case ADDING_EDGE:
      Vertex v;
      if(MathHelper.lastVertex != null){
        v = MathHelper.lastVertex;
        line(v.x, v.y, mouseX, mouseY);
      }
      break;
    case ADDING:
      break;
    case DELETING:
      break;
    case MOVING:
      break;
      
  }
  displayState(state);
}

void displayState(State state2){
  String stateStr = "";
  switch(state2){
    case ADDING_EDGE:
      stateStr = "Adding_Edge";
      break;
    case ADDING:
      stateStr = "Adding";
      break;
    case DELETING:
      stateStr = "Deleting";
      break;
    case MOVING:
      stateStr = "Moving";
      break;
  }
  
  //size(40,40);
  fill(0);
  textSize(20);
  text(stateStr, 100, 100);
  fill(255);
}

void mouseClicked(){
  
    switch(state){
    case ADDING_EDGE:
      if(MathHelper.vertexClicked(vertices, mouseX, mouseY)){
        state = State.ADDING;
        print("Edge MAde");
      // else add a vertex only.
      }else{
        state = State.ADDING;
      }
      break;
    case ADDING:
      // If we are adding and we click on an existing vertex, we start making an edge.
      if(MathHelper.vertexClicked(vertices, mouseX, mouseY)){
        state = State.ADDING_EDGE;
        print("Start making an edge");
      // else add a vertex only.
      }else{
        vertices.add(new Vertex(mouseX, mouseY, NodeDiameter));
      }
      break;
    case DELETING:
      break;
    case MOVING:
      break;
      
  }
}
