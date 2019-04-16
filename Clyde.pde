class Clyde extends Ghost {
  public Clyde() {
    super();
    this.row = 12;
    this.col = 13;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(-(this.speed), 0);
    this.desiredScatterR = 29;
    this.desiredScatterC = 1;
  }
  
  public void render() {
    super.render(ORANGE, clydeSvg);
    
    if (this.path.isEmpty() && SCORE > 20 && this.mode == CHASING) {
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
        if (USE_IDA) {
          this.path = idaStar(this.row, this.col, 29, 1);
        } else {
          this.path = aStar(29, 1, this.row, this.col); 
        }
      } else {
        if (USE_IDA) {
          this.path = idaStar(this.row, this.col, game.pacman.row, game.pacman.col);
        } else {
          this.path = aStar(game.pacman.row, game.pacman.col, this.row, this.col);
        }
      } 
    }
  }  
  
  /*
  * Bottom left
  * (20, 1) - (20, 12)
  * (29, 1) - (29, 12)
  */
  @Override
  protected void createPathToDesiredCorner() {
    if (this.isAtDesiredScatterPosn()) {
      int r, c;
      int randR = Math.round(random(20, 30));
      int randC = Math.round(random(1, 9));
      
      Cell cell = game.board.getCellAt(randR, randC);
      
      while (cell.isWall()) {
        randR = Math.round(random(20, 30));
        randC = Math.round(random(1, 9));
        
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
