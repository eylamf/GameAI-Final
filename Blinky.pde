class Blinky extends Ghost {
  public Blinky() {
    super();
    this.row = 11;
    this.col = 13;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(0, -(this.speed));
    this.setIsActive(true);
  }
  
  public void render() {
    super.render(RED);
    
    if (this.path.isEmpty()) {
      this.createPath(); 
    }
  }
  
  @Override
  public void createPath() {
    if (this.isOnCell()) {
      if (USE_IDA) {
        this.path = idaStar(this.row, this.col, game.pacman.row, game.pacman.col);
      } else {
        this.path = aStar(game.pacman.row, game.pacman.col, this.row, this.col);
      }
    }
  }
  
  @Override
  public void scatter() {
    
  }
}
