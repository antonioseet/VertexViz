/* Created by Tony Barrera */

// Global Variables
int bgColor = 255;
ArrayList<Vertex> vertices = new ArrayList<Vertex>();
ArrayList<Edge> edges = new ArrayList<Edge>();
int NodeDiameter = 20;

State state = State.ADDING;

// Last Vertex, try to ckeep track of the last clicked vertex to assign edges, might work. 
//Vertex lastVertex; keep it in MAthHelpers

// Runs once when the program starts.
void setup() {
  size(1200, 800);
  background(bgColor);
  Global.state = State.ADDING;
}

void draw() {
  background(bgColor);
  displayActions();
  
  for(Edge e : edges){
    line(e.v1.x, e.v1.y, e.v2.x, e.v2.y);
  }
  for(Vertex v : vertices){
    circle(v.x, v.y, v.d);
  }
  
  
  switch(Global.state){
    case ADDING_EDGE:
      Vertex v;
      if(Global.vertex1 != null){
        v = Global.vertex1;
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
  displayState();
}

void displayState(){
  String stateStr = "";
  switch(Global.state){
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
  text("Current State: " + stateStr, 150, 30);
  fill(255);
}

void mouseClicked(){
  println("Mouse Clicked");
  switch(Global.state){
    case ADDING:
      // If we are adding and we click on an existing vertex, we start making an edge.
      if(VertexHelper.vertexClicked(vertices, mouseX, mouseY)){
        Global.state = State.ADDING_EDGE;
        println("Start making an edge");
      // else add a vertex only.
      }else{
        vertices.add(new Vertex(mouseX, mouseY, NodeDiameter));
      }
      break;
    case ADDING_EDGE:
      if(VertexHelper.vertexEndClicked(vertices, mouseX, mouseY)){
        println(" Edge MAde");
        Vertex temp1 = new Vertex(Global.vertex1);
        Vertex temp2 = new Vertex(Global.vertex2);
        edges.add(new Edge(temp1, temp2));
        //Global.clear();
      }
      Global.state = State.ADDING;
      break;
    case DELETING:
      break;
    case MOVING:
      break;
      
  }
}

void displayActions(){
  fill(0);
  textSize(20);
  
  int x = 20;
  int y = 30;
  text("1: Add", x, y);
  text("2: Delete", x, y+20);
  text("3: Move", x, y+40);
  text("4: Surprise!", x, y+60);
  fill(255);
}

// IDEAS

//  1: USE KEYS INSTEAD OF UI BUTTONS TO CHANGE STATES, line up Keys|actions vertically
//  2: Have a key that will make every vertex move in a random direction and bounce around, keeping their edges.
//      Maybe consider giving eaach vertex a random vector or angle at creation to move.
//  3: Vertex Visual in chart
//  4: Matrix visuals?
