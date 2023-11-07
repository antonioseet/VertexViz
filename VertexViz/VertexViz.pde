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
  
  // May be wise to change this to be above the for loops that draw.
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
    case MOVE:
      break;
    case MOVING:
      if(Global.movingVertex != null)
        Global.movingVertex.updatePosition(mouseX,mouseY);
      break;
    case SPREAD:
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
    case MOVE:
      stateStr = "ChoseForMove";
      break;
    case MOVING:
      stateStr = "Moving";
      break;
    case SPREAD:
      stateStr = "Vertex Spread";
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
        edges.add(new Edge(Global.vertex1, Global.vertex2));
      }
      Global.state = State.ADDING;
      break;
    case DELETING:
      if(VertexHelper.vertexToDeleteClicked(vertices, edges, mouseX, mouseY)){
        println("VERTEX AND adjacent EDGES DELETED");
      } else if(VertexHelper.removeEdgesNearMouse(edges, mouseX, mouseY)){
        println("Only edges deleted");
      }
      break;
    case MOVE:
    case MOVING:
      break;
    case SPREAD:
      break;
      
  }
}

void mousePressed(){
  println("mouse DOWN");
  switch (Global.state){
    case DELETING:
    case MOVING:
    case ADDING_EDGE:
    case SPREAD:
      break;
    case ADDING:
    case MOVE:
      if(VertexHelper.vertexToMoveClicked(vertices, mouseX, mouseY)){
        Global.state = State.MOVING;
      }
      break;
  }
}

void mouseReleased(){

  if(Global.state == State.MOVING){
    println("Move successful..?");
    Global.state = State.ADDING;
    Global.clear();
  }

}

void keyPressed() {
  if (key == '1') {
    Global.state = State.ADDING;
  } else if (key == '2') {
    Global.state = State.DELETING;
  } else if (key == '3') {
    Global.state = State.MOVE;
  } else if (key == '4') {
    Global.state = State.SPREAD;
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
