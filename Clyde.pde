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
    if (this.isOnCell()) {
      if (this.isLessThanEightAway()) {
        this.path = aStar(29, 1, this.row, this.col);
      } else {
        this.path = aStar(game.pacman.row, game.pacman.col, this.row, this.col);   
      } 
    }
  }  
  
  @Override
  public void scatter() {
    
  }
}
