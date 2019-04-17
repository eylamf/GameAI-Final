
class Inky extends Ghost {
  public Inky() {
    super();
    this.row = 13;
    this.col = 14;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(0, -(this.speed));
    this.desiredScatterR = 29;
    this.desiredScatterC = 26;
  }
  
  public void render() {
    super.render(LIGHT_BLUE, inkySvg);
    
    if (this.path.isEmpty() && SCORE > 30 && this.mode == CHASING) {
      this.createPath(); 
    }
  }
  
  @Override
  public void createPath() {
    if (this.isOnCell()) {
      
      PVector blinkyDiff = new PVector(game.pacman.posn.x - game.blinky.posn.x, game.pacman.posn.y - game.blinky.posn.y);
      PVector dest = new PVector(game.pacman.posn.x + blinkyDiff.x, game.pacman.posn.y + blinkyDiff.y);
      
      int r = game.pacman.row;
      int c = game.pacman.col;
      
      Cell closest = this.getClosestToDest(dest.x, dest.y);
      
      if (dest.x > (width / 2) || dest.y > (HEIGHT / 2)) {
        closest = game.board.getCellAt(game.pacman.row, game.pacman.col); 
      }
      
      if (closest != null) {
        r = closest.row;
        c = closest.col;
      }
      
      if (USE_IDA) {
        this.path = idaStar(this.row, this.col, r, c);
      } else {
        this.path = aStar(r, c, this.row, this.col); 
      }
    }
  }
  
  /*
  * Bottom right
  * (20, 15) - (20, 26)
  * (29, 1) - (29, 12)
  */
  @Override
  protected void createPathToDesiredCorner() {
    if (this.isAtDesiredScatterPosn()) {
      int r, c;
      int randR = Math.round(random(20, 30));
      int randC = Math.round(random(15, 27));
      
      Cell cell = game.board.getCellAt(randR, randC);
      
      while (cell.isWall()) {
        randR = Math.round(random(20, 30));
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
  
  private Cell getClosestToDest(float x, float y) {
    float minDist = Float.MAX_VALUE;
    Cell cell = null;
    
    if (x > WIDTH || y > HEIGHT) {
      println("GREATER");
      cell = game.board.getCellAt(game.pacman.row, game.pacman.col);
      return cell;
    }
    
    for (int r = 0; r < game.board.numRows; r++) {
      for (int c = 0; c < game.board.numCols; c++) {
        if (!game.board.grid[r][c].isWall()) {
          float dist = dist(game.board.grid[r][c].x, game.board.grid[r][c].y, x, y);
        
          if (dist < minDist) {
            minDist = dist;
            cell = game.board.grid[r][c];
          } 
        }
      }
    }
    
    return cell;
  }
}
