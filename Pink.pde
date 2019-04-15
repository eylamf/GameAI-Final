class Pinky extends Ghost {
  public Pinky() {
    super();
    this.row = 13;
    this.col = 13;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(0, -(this.speed));
    this.desiredScatterR = 1;
    this.desiredScatterC = 26;
  }
  
  public void render() {
    super.render(PINK);
    
    if (this.path.isEmpty() && SCORE > 10 && this.mode == CHASING) {
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
      
      if (USE_IDA) {
        this.path = idaStar(this.row, this.col, r, c);
      } else {
        this.path = aStar(r, c, this.row, this.col); 
      }
    }
  }
  
  /*
  * Top right
  * (1, 15) - (1, 26)
  * (8, 15) - (8, 26)
  */
  @Override
  protected void createPathToDesiredCorner() {
    if (this.isAtDesiredScatterPosn()) {
      int r, c;
      int randR = Math.round(random(1, 9));
      int randC = Math.round(random(15, 27));
      
      Cell cell = game.board.getCellAt(randR, randC);
      
      while (cell.isWall()) {
        randR = Math.round(random(1, 9));
        randC = Math.round(random(15, 27));
        
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
