
class Inky extends Ghost {
  public Inky() {
    super();
    this.row = 13;
    this.col = 14;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(0, -1);
  }
  
  public void render() {
    super.render(LIGHT_BLUE);
    
    if (this.path.isEmpty() && SCORE > 30 && game.mode == CHASING) {
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
  
  @Override
  public void scatter() {
    
  }
  
  private Cell getClosestToDest(float x, float y) {
    float minDist = Float.MAX_VALUE;
    Cell cell = null;
    
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
