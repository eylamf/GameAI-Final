abstract class Ghost {
  public int row, col;
  public PVector posn;
  public ArrayList<Node> path;
  protected PVector orientation;
  protected int appearanceTimer;
  protected float alpha;
  
  public Ghost() {
    this.appearanceTimer = 0;
    this.alpha = 200;
    this.path = new ArrayList();
  }
 
  public abstract void createPath();
  
  public abstract void scatter();
  
  public void render(color c) {
    if (game.mode == FRIGHTENED) {
      fill(BLUE, this.alpha);
      stroke(BLUE);
    } else {
      fill(c, this.alpha);
      stroke(c);
    }
    
    strokeWeight(2);
    rect(this.posn.x, this.posn.y, INCREMENT, INCREMENT, INCREMENT, INCREMENT, 2, 2);
     
    strokeWeight(3);
    for (Node n : this.path) {
      n.renderPath(c, this.alpha / 1.5); 
    }
  }
  
  protected void move() {
    if (game.mode == CHASING) {
      this.createPath();
      this.chase();
    } else if (game.mode == FRIGHTENED) {
      this.moveRandomly();
    } else if (game.mode == SCATTER) {
      this.scatter();
    }
  }
  
  protected void chase() {
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
  
  protected void moveRandomly() {
    if (this.isOnTurnBlock() || this.isOnEatenTurnBlock()) {
      this.orientation = this.getRandomDir();
    }
    
    this.posn.add(this.orientation);
  
    if (this.isOnCell()) {
      this.row = convertYtoR((int) this.posn.y);
      this.col = convertXtoC((int) this.posn.x);
    }
  }
  
  private PVector getRandomDir() {
    float rand = random(0, 4);
    float vx = 0;
    float vy = 0;
    
    switch (Math.round(rand)) {
      case 0:
        vy = -1;
        break;
      case 1:
        vx = 1;
        break;
      case 2:
        vy = 1;
        break;
      case 3:
        vx = -1;
        break;
    }
    
    Cell cell = game.board.getCellAt(this.row + ((int) vx), this.col + ((int) vy));
    
    while (cell.isWall()) {
      rand = random(0, 4);
      vx = 0;
      vy = 0;
      
      switch (Math.round(rand)) {
        case 0:
          vy = -1;
          break;
        case 1:
          vx = 1;
          break;
        case 2:
          vy = 1;
          break;
        case 3:
          vx = -1;
          break;
      }
      
      cell = game.board.getCellAt(this.row + ((int) vx), this.col + ((int) vy));
    }
    
    return new PVector(vx, vy);
  }
  
  private boolean isOnTurnBlock() {
    if (!this.isOnCell()) {
      return false; 
    }
    
    return game.board.getCellAt(this.row, this.col).isTurnBlock();
  }
  
  private boolean isOnEatenTurnBlock() {
    if (!this.isOnCell()) {
      return false; 
    }
    
    return game.board.getCellAt(this.row, this.col).isEatenTurnBlock();
  }
  
  /*
  [X][C][X]
  [C][G][C]
  [X][C][X]
  */
  private Cell[][] getNearby() {
    Cell[][] nearby = new Cell[3][3];
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        nearby[i][j] = null; 
      }
    }
    
    if (this.row - 1 > 0) {
      nearby[0][1] = game.board.getCellAt(this.row - 1, this.col);
    }
    
    if (this.row + 1 < game.board.numRows) {
      nearby[2][1] = game.board.getCellAt(this.row + 1, this.col);
    }
    
    if (this.col - 1 > 0) {
      nearby[1][0] = game.board.getCellAt(this.row, this.col - 1);
    }
    
    if (this.col + 1 < game.board.numCols) {
      nearby[1][2] = game.board.getCellAt(this.row, this.col + 1);
    }
    
    return nearby;
  }
  
  public boolean isMovingRight() {
    return this.orientation.x == 1; 
  }
  
  public boolean isMovingLeft() {
    return this.orientation.x == -1; 
  }
  
  public boolean isMovingUp() {
    return this.orientation.y == -1; 
  }
  
  public boolean isMovingDown() {
    return this.orientation.y == 1; 
  }
  
  public boolean isOnCell() {
    return (Math.abs(this.posn.x - game.board.initX) % INCREMENT == 0
    && Math.abs(this.posn.y - game.board.initY) % INCREMENT == 0);
  }
}
