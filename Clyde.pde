class Clyde extends Ghost {
  public Clyde() {
    super();
    this.row = 12;
    this.col = 13;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(-1, 0);
  }
  
  public void render() {
    super.render(ORANGE);
    
    if (this.path.isEmpty()) {
      this.createPath(); 
    }
  }
  
  private boolean isLessThanEightAway() {
    if (this.path.isEmpty()) {
      return false;  
    }
    
    return Math.abs(this.row - game.pacman.row) + Math.abs(this.col - game.pacman.col) <= 8;
  }
  
  @Override
  public void createPath() {
    if (this.isLessThanEightAway()) {
      this.path = aStar(29, 1, this.row, this.col);
    } else {
      this.path = aStar(game.pacman.row, game.pacman.col, this.row, this.col);   
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
        
        if (this.row == 29 && this.col == 1) {
          this.orientation = new PVector(0, 0);
        } else {
          this.orientation = new PVector(x, y);
        }
        
        break;
      }
    }
    
    this.posn.add(this.orientation);
  }
  
  @Override
  public void scatter() {
    
  }
}
