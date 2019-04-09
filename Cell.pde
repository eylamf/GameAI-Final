class Cell {
  public int type, row, col, x, y;
  
  public Cell(int r, int c) {
    this.row = r;
    this.col = c;
  }
  
  public Cell(int t, int r, int c, int x, int y) {
    this.type = t;
    this.row = r;
    this.col = c;
    this.x = x;
    this.y = y;
  }
  
  public void render() {
    if (DEBUG) {
      strokeWeight(1);
      stroke(WHITE);
    } else {
      noStroke(); 
    }
    
    if (this.isWall()) {
      fill(BLUE);
    } else {
      
      if (this.isTurnBlock() || this.isEatenTurnBlock()) {
        if (DEBUG) {
          fill(RED); 
        } else {
          fill(BLACK); 
        }
      } else {
        fill(BLACK); 
      }
    }
    
    rect(this.x, this.y, INCREMENT, INCREMENT);
    
    if (this.isPellet() || this.isTurnBlock()) {
      fill(WHITE);
      ellipse(this.x, this.y, 3, 3);
    } else if (this.isPowerPellet()) {
      fill(WHITE);
      ellipse(this.x, this.y, 10, 10);
    }
  }
  
  public void setType(int t) {
    this.type = t; 
  }
  
  public boolean isWall() {
    return this.type == WALL; 
  }
  
  public boolean isPellet() {
    return this.type == PELLET; 
  }
  
  public boolean isPowerPellet() {
   return this.type == POWER_PELLET;
  }
  
  public boolean isEmpty() {
    return this.type == EMPTY; 
  }
  
  public boolean isTurnBlock() {
    return this.type == TURN_BLOCK; 
  }
  
  public boolean isEatenTurnBlock() {
    return this.type == 5; 
  }
  
  @Override
  public boolean equals(Object o) {
    if (o == this) return true;
    if (!(o instanceof Cell)) return false;
    
    Cell cell = (Cell) o;
    
    return this.row == cell.row && this.col == cell.col;
  }
  
  @Override
  public int hashCode() {
    return Objects.hash(this.row, this.col); 
  }
}
