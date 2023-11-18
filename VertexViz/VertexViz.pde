/* Created by Tony Barrera */

// Global Variables
int bgColor = 100;
int vertexColor = 255;
ArrayList<Vertex> vertices = new ArrayList<Vertex>();
ArrayList<Edge> edges = new ArrayList<Edge>();
int NodeDiameter = 20;
boolean labelsOn = true;

//State state = State.ADDING;

// If these change remember to change them in setup.
int windowX = 1200;
int windowY = 800;

// Last Vertex, try to ckeep track of the last clicked vertex to assign edges, might work. 
//Vertex lastVertex; keep it in MAthHelpers

// Runs once when the program starts.
void setup() {
  size(1200, 800);
  frameRate(60);
  background(bgColor);
  Global.state = State.ADDING;
}

void draw() {
  background(100);
  displayActions();
  
  // go through all the edges and if we find a loop, instead of drawring a line, draw a circle representina loop.
  for(Edge e : edges){
    if(e.isLoop()){
      fill(bgColor);
      circle(e.v1.x, e.v1.y - (3*e.v1.d/4), e.v1.d * 2);
      if(labelsOn){
        // Edge label color
        fill(0);
        text("e"+edges.indexOf(e), (e.v2.x + e.v1.x) /2 - 5,(e.v2.y + e.v1.y) / 2 - 38);
        fill(255);
      }
    }else{
      line(e.v1.x, e.v1.y, e.v2.x, e.v2.y);
      if(labelsOn){
        fill(0);
        text("e"+edges.indexOf(e), (e.v2.x + e.v1.x) /2 - 5,(e.v2.y + e.v1.y) / 2 - 10);
        fill(255);
      }
    }
    
    
  }
  
  for(Vertex v : vertices){
    fill(255);
    circle(v.x, v.y, v.d);
    if(labelsOn){
      fill(0);
      text(vertices.indexOf(v), v.x - v.d/4, v.y + v.d/4);
      fill(255);
    }
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
  displayAdjacencyMatrix();
  
  if(Global.state == State.SPREAD){
    for(Vertex v: vertices){
      v.move();
    }
  }
  
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
  text("Current State: " + stateStr, 20, 620);
  
  // Vertex and Edge Status
  text("Total Vertices: " + vertices.size(), 700, 20);
  text("Total Edges: " + edges.size(), 700, 40);
  
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
    if(Global.state == State.SPREAD)
      Global.state = State.ADDING;
    else
      Global.state = State.SPREAD;
  } else if (key == '5') {
     labelsOn = !labelsOn; 
  } else if(key == '6'){
    addRandomVertices();
  } else if(key == '7'){
    resetGraph();
  }else if( key == ' '){
    vertices.clear();
    edges.clear();
  }
}

void displayActions(){
  fill(0);
  textSize(20);
  
  int x = 20;
  int y = 650;
  text("1: Add", x, y);
  text("2: Delete", x, y+20);
  text("3: Move", x, y+40);
  text("4: Surprise!", x, y+60);
  text("5: Label Switch. Status --> " + (labelsOn ? "On" : "Off"), x, y + 80);
  text("6: Add 5 Random Vertices", x, y+100);
  text("7: Reset All", x, y+120);
  fill(255);
}

// Function to display the adjacency matrix
void displayAdjacencyMatrix() {
  // Create a 2D array to represent the adjacency matrix
  int[][] matrix = new int[vertices.size()][vertices.size()];
  
  // Initialize the adjacency matrix with 0's
  for (int i = 0; i < vertices.size(); i++) {
    for (int j = 0; j < vertices.size(); j++) {
      matrix[i][j] = 0;
    }
  }

  // Populate the adjacency matrix based on the edges
  for (Edge e : edges) {
    int v1Index = vertices.indexOf(e.v1);
    int v2Index = vertices.indexOf(e.v2);
    
    // Undirected graph without loops
    if (v1Index != -1 && v2Index != -1) {
      matrix[v1Index][v2Index] = 1;
      matrix[v2Index][v1Index] = 1; // Because the graph is undirected
    }
  }

  // Display the adjacency matrix
  textSize(15);
  fill(0);
  text("Adjacency Matrix:", 10, 15);
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      // Calculate the position for each cell's text
      int x = 10 + j * 20;
      int y = 30 + i * 20;
      text(matrix[i][j], x, y);
    }
  }
}

void addRandomVertices(){
  for(int i = 0; i < 5; i ++){
    float x = random(50,width-50);
    float y = random(50, height-50);
    vertices.add(new Vertex((int)x, (int)y , NodeDiameter));
  }
}


void resetGraph(){
  vertices.clear();
}

// IDEAS

//  1: USE KEYS INSTEAD OF UI BUTTONS TO CHANGE STATES, line up Keys|actions vertically
//  2: Have a key that will make every vertex move in a random direction and bounce around, keeping their edges.
//      Maybe consider giving eaach vertex a random vector or angle at creation to move.
//  3: Vertex Visual in chart
//  4: Matrix visuals?
