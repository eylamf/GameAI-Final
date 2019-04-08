class Pinky extends Ghost {
  public Pinky() {
    super();
    this.row = 13;
    this.col = 13;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(0, -1);
  }
  
  public void render() {
    super.render(PINK);
    
    if (this.path.isEmpty()) {
      this.createPath(); 
    }
  }
  
  @Override
  public void createPath() {
    if (this.isOnCell()) {
      Cell[][] surroundings = game.pacman.getSurroundingCells();
    
      int r = game.pacman.row;
      int c = game.pacman.col;
      
      if (game.pacman.isMovingRight()) {
        if (surroundings[4][8] != null && !surroundings[4][8].isWall()) {
          c = surroundings[4][8].col;
        }
      } else if (game.pacman.isMovingLeft()) {
        if (surroundings[4][0] != null && !surroundings[4][0].isWall()) {
          c = surroundings[4][0].col;
        }
      } else if (game.pacman.isMovingUp()) {
        if (surroundings[0][4] != null && !surroundings[0][4].isWall()) {
          r = surroundings[0][4].row;
        }
      } else if (game.pacman.isMovingDown()) {
        if (surroundings[8][4] != null && !surroundings[8][4].isWall()) {
          r = surroundings[8][4].row;
        }
      }
      
      this.path = aStar(r, c, this.row, this.col); 
    }
  }
  
  @Override
  public void chase() {
    for (int i = 0; i < this.path.size() - 1; i++) {
      if (this.path.get(i).x == this.posn.x && this.path.get(i).y == this.posn.y) {
        Node next = this.path.get(i + 1);
        
        float x = 0;
        float y = 0;
        
        if (next.x < this.posn.x) {
          x = -1;
          this.col--;
        } else if (next.x > this.posn.x) {
          x = 1;
          this.col++;
        }
        
        if (next.y < this.posn.y) {
          y = -1;
          this.row--;
        } else if (next.y > this.posn.y) {
          y = 1;
          this.row++;
        }
        
        this.orientation = new PVector(x, y);
        
        break;
      }
    }
    
    this.posn.add(this.orientation);
  }
  
  @Override
  public void scatter() {
    
  }
}
