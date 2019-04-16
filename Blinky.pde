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
    this.desiredScatterR = 1;
    this.desiredScatterC = 1;
  }
  
  public void render() {
    super.render(RED, blinkySvg);
    
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
  
  /*
  * Top left
  * (1, 1) - (1, 8)
  * (8, 1) - (8, 12)
  */
  @Override
  protected void createPathToDesiredCorner() {
    if (this.isAtDesiredScatterPosn()) {
      int r, c;
      int randR = Math.round(random(1, 9));
      int randC = Math.round(random(1, 13));
      
      Cell cell = game.board.getCellAt(randR, randC);
      
      while (cell.isWall()) {
        randR = Math.round(random(1, 9));
        randC = Math.round(random(1, 13));
        
        cell = game.board.getCellAt(randR, randC);
      }
      
      r = randR;
      c = randC;
      
      this.desiredScatterR = r;
      this.desiredScatterC = c;
      
      if (USE_IDA) {
        this.path = idaStar(this.row, this.col, this.desiredScatterR, this.desiredScatterC);
      } else {
        this.path = aStar(this.desiredScatterR, this.desiredScatterC, this.row, this.col);
      } 
    }
  }
}
