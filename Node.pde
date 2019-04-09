class Node implements Comparable<Node> {
  public int row, col, x, y;
  public Node parent;
  private boolean isActive;
  private int f, g, h;
  
  public Node(int r, int c, int x, int y) {
    this.isActive = false;
    this.row = r;
    this.col = c;
    this.x = x;
    this.y = y;
    this.f = 0;
    this.g = 0;
    this.h = 0;
  }  
  
  public void render() {
    if (DEBUG) {
      fill(255, 0, 0);
      ellipse(this.x, this.y, 5, 5); 
    }
  }
  
  public void renderPath(color c, float a) {
    if (this.parent != null) {
      stroke(c, a);
      strokeWeight(3);
      line(this.x, this.y, this.parent.x, this.parent.y);
    } else {
      noStroke();
      if (USE_IDA) {
        fill(c);
        ellipse(this.x, this.y, 5, 5);
      } else {
        fill(c, a);
        ellipse(this.x, this.y, 10, 10);
      }
    }
  }
  
  public void setIsActive(boolean active) {
    this.isActive = active; 
  }
  
  public boolean getIsActive() {
    return this.isActive; 
  }
  
  public ArrayList<Node> getNeighbors() {
    ArrayList<Node> neighbors = new ArrayList();
    
    /*
    // Right neighbor
    Node temp = game.board.getNodeAt(this.row, this.col + 1);
    
    int colDiff = 1;
    
    while (!temp.getIsActive() && temp.col != game.board.w - 1 && !game.board.getCellAt(temp.row, temp.col).isWall()) {
      temp = game.board.getNodeAt(this.row, this.col + colDiff);
      colDiff++;
    }
    
    if (!temp.equals(game.board.getNodeAt(this.row, this.col + 1))) {
      neighbors.add(temp); 
    }
    
    // Left neighbor
    temp = game.board.getNodeAt(this.row, this.col - 1);
    
    colDiff = 1;
    
    while (!temp.getIsActive() && temp.col != 0 && !game.board.getCellAt(temp.row, temp.col).isWall()) {
      temp = game.board.getNodeAt(this.row, this.col - colDiff);
      colDiff++;
    }
    
    if (!temp.equals(game.board.getNodeAt(this.row, this.col - 1))) {
      neighbors.add(temp); 
    }
    
    // Bottom neighbor
    temp = game.board.getNodeAt(this.row + 1, this.col);
    
    int rowDiff = 1;
    
    while (!temp.getIsActive() && temp.row != game.board.h - 1 && !game.board.getCellAt(temp.row, temp.col).isWall()) {
      temp = game.board.getNodeAt(this.row + rowDiff, this.col);
      rowDiff++;
    }
    
    if (!temp.equals(game.board.getNodeAt(this.row + 1, this.col))) {
      neighbors.add(temp);
    }
    
    // Top neighbor
    temp = game.board.getNodeAt(this.row - 1, this.col);
    
    rowDiff = 1;
    
    while (!temp.getIsActive() && temp.row != 0 && !game.board.getCellAt(temp.row, temp.col).isWall()) {
      temp = game.board.getNodeAt(this.row - rowDiff, this.col);
      rowDiff++;
    }
    
    if (!temp.equals(game.board.getNodeAt(this.row - 1, this.col))) {
      neighbors.add(temp); 
    }
    */
    
    neighbors.add(game.board.getNodeAt(this.row - 1, this.col).clone());
    neighbors.add(game.board.getNodeAt(this.row, this.col + 1).clone());
    neighbors.add(game.board.getNodeAt(this.row + 1, this.col).clone());
    neighbors.add(game.board.getNodeAt(this.row, this.col - 1).clone());
    
    return neighbors;
  }
  
  public void setG(int g) {
    this.g = g; 
  }
  
  public int getG() {
    return this.g; 
  }
  
  public int getH() {
    return this.h; 
  }
  
  public void setH(int h) {
    this.h = h;
  }
  
  public int getF() {
    return this.f; 
  }
  
  public void setF() {
    this.f = this.g + this.h; 
  }
  
  @Override
  public Node clone() {
    Node clone = new Node(this.row, this.col, this.x, this.y);
    clone.setIsActive(this.isActive);
    
    return clone;
  }
  
  @Override
  public int compareTo(Node node) {
    if (this.f > node.f) {
      return 1;
    } else if (this.f < node.f) {
      return -1;
    } else {
      return 0; 
    }
  }
  
  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (!(o instanceof Node)) return false;
    
    Node node = (Node) o;
    return this.row == node.row && this.col == node.col;
  }
  
  @Override
  public int hashCode() {
    return Objects.hash(this.row, this.col); 
  }
  
  @Override
  public String toString() {
    return "row: " + this.row + " " + "col: " + this.col; //+ " parent: " + this.parent; 
  }
}
