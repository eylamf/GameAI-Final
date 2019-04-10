// Represent the pacman character
class Pacman {
  public int row, col;
  public PVector posn; 
  private int initX, initY;
  private PVector orientation;
  private boolean turnRequested;
  private String requestedDir;
  
  public Pacman() {
    this.reset();  
  }
  
  public void reset() {
    this.row = 23;
    this.col = 13;
    this.initX = convertCtoX(this.col);
    this.initY = convertRtoY(this.row);
    this.posn = new PVector(this.initX, this.initY);
    this.orientation = new PVector(-1, 0);
    this.turnRequested = false;
    this.requestedDir = "left";
  }
  
  public void render() {
    noStroke();
    fill(YELLOW);
    ellipse(this.posn.x, this.posn.y, INCREMENT, INCREMENT);
  }
  
  public void move() {
    
    if (!this.willHitWall()) {
      this.posn.add(this.orientation); 
    }
    
    if (this.isOnCell()) {
      this.row = convertYtoR((int) this.posn.y);
      this.col = convertXtoC((int) this.posn.x);
      
      if (this.didEatPowerPellet()) {
        game.setMode(FRIGHTENED);
      }
      
      Cell current = game.board.getCellAt(this.row, this.col);
      
      if (current.isTurnBlock()) {
        current.setType(EATEN_TURN_BLOCK);
        SCORE++;
      } else if (current.isPellet() || current.isPowerPellet()) {
        current.setType(EMPTY);
        SCORE++;
      }
    }
    
    Cell[][] surroundings = this.getNearbyCells();
    
    if (this.turnRequested) {
      // Try to turn the requested dir
      if (this.isOnTurnBlock()) {
        
        if (this.requestedDir.equals("right")) {
          if (!surroundings[1][2].isWall()) {
            this.attemptTurn(); 
          }
        } else if (this.requestedDir.equals("left")) {
          if (!surroundings[1][0].isWall()) {
            this.attemptTurn(); 
          }
        } else if (this.requestedDir.equals("down")) {
          if (!surroundings[2][1].isWall()) {
            this.attemptTurn(); 
          }
        } else if (this.requestedDir.equals("up")) {
          if (!surroundings[0][1].isWall()) {
            this.attemptTurn(); 
          }
        }
      }
    }
  }
  
  public void attemptTurn() {
    this.orientation = this.getVectorForDir(this.requestedDir);
    this.turnRequested = false;
  }
  
  /*
  [X][X][X][X][N][X][X][X][X]
  [X][X][X][X][N][X][X][X][X]
  [X][X][X][X][N][X][X][X][X]
  [X][X][X][X][N][X][X][X][X]
  [N][N][N][N][P][N][N][N][N]
  [X][X][X][X][N][X][X][X][X]
  [X][X][X][X][N][X][X][X][X]
  [X][X][X][X][N][X][X][X][X]
  [X][X][X][X][N][X][X][X][X]
  */
  public Cell[][] getSurroundingCells() {
    Cell[][] surroundings = new Cell[9][9];
    
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        surroundings[i][j] = null; 
      }
    }
    
    if (this.row - 4 > 0) {
      surroundings[0][4] = game.board.grid[this.row - 4][this.col];
      surroundings[1][4] = game.board.grid[this.row - 3][this.col];
      surroundings[2][4] = game.board.grid[this.row - 2][this.col];
      surroundings[3][4] = game.board.grid[this.row - 1][this.col];
    }
    
    if (this.row + 4 < game.board.numRows) {
      surroundings[5][4] = game.board.grid[this.row + 1][this.col];
      surroundings[6][4] = game.board.grid[this.row + 2][this.col];
      surroundings[7][4] = game.board.grid[this.row + 3][this.col];
      surroundings[8][4] = game.board.grid[this.row + 4][this.col];
    }
    
    if (this.col - 4 > 0) {
      surroundings[4][0] = game.board.grid[this.row][this.col - 4];
      surroundings[4][1] = game.board.grid[this.row][this.col - 3];
      surroundings[4][2] = game.board.grid[this.row][this.col - 2];
      surroundings[4][3] = game.board.grid[this.row][this.col - 1];
    }
    
    if (this.col + 4 < game.board.numCols) {
      surroundings[4][5] = game.board.grid[this.row][this.col + 1];
      surroundings[4][6] = game.board.grid[this.row][this.col + 2];
      surroundings[4][7] = game.board.grid[this.row][this.col + 3];
      surroundings[4][8] = game.board.grid[this.row][this.col + 4];
    }
    
    if (DEBUG) {
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          if (surroundings[i][j] != null) {
            fill(WHITE);
            noStroke();
            ellipse(surroundings[i][j].x, surroundings[i][j].y, INCREMENT / 2, INCREMENT / 2); 
          }
        }
      }
    }
    
    return surroundings;
  }
  
  /*
  [X][C][X]
  [C][P][C]
  [X][C][X]
  */
  private Cell[][] getNearbyCells() {
    Cell[][] surroundings = new Cell[3][3];
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        surroundings[i][j] = null; 
      }
    }
    
    if (this.row - 1 > 0) {
      surroundings[0][1] = game.board.grid[this.row - 1][this.col];
    }
    
    if (this.row + 1 < game.board.numRows) {
      surroundings[2][1] = game.board.grid[this.row + 1][this.col];
    }
    
    if (this.col - 1 > 0) {
      surroundings[1][0] = game.board.grid[this.row][this.col - 1];
    }
    
    if (this.col + 1 < game.board.numCols) {
      surroundings[1][2] = game.board.grid[this.row][this.col + 1];
    }
    
    if (DEBUG) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (surroundings[i][j] != null) {
            fill(0, 255, 0);
            noStroke();
            ellipse(surroundings[i][j].x, surroundings[i][j].y, INCREMENT / 2, INCREMENT / 2); 
          }
        }
      }
    }
    
    return surroundings;
  }
  
  public void onKey() {
    if (key == CODED) {
      this.turnRequested = true;
      
      switch (keyCode) {
        case RIGHT:
          if (this.isMovingLeft()) {
            this.turnRequested = false;
            this.requestedDir = "right";
            this.attemptTurn();
          } if (this.isMovingRight()) {
            this.turnRequested = false;
          } else {
            this.requestedDir = "right";
          }
          break;
        
        case LEFT:
          if (this.isMovingRight()) {
            this.turnRequested = false;
            this.requestedDir = "left";
            this.attemptTurn();
          } if (this.isMovingLeft()) {
            this.turnRequested = false; 
          } else {
            this.requestedDir = "left"; 
          }
          break;
          
        case UP:
          if (this.isMovingDown()) {
            this.turnRequested = false;
            this.requestedDir = "up";
            this.attemptTurn();
          } if (this.isMovingUp()) {
            this.turnRequested = false; 
          } else {
            this.requestedDir = "up";
          }
          break;
          
        case DOWN:
          if (this.isMovingUp()) {
            this.turnRequested = false;
            this.requestedDir = "down";
            this.attemptTurn();
          } if (this.isMovingDown()) {
            this.turnRequested = false; 
          } else {
            this.requestedDir = "down"; 
          }
          break;
      }
    }
  }
  
  private PVector getVectorForDir(String dir) {
    switch (dir) {
      case "up":
        return new PVector(0, -1);
      case "down":
        return new PVector(0, 1);
      case "right":
        return new PVector(1, 0);
      case "left":
        return new PVector(-1, 0);
      default:
        return new PVector(0, 0);
    }
  }
  
  private boolean willHitWall() {
    if (this.isMovingRight()) {
      return game.board.getCellAt(this.row, this.col + 1).isWall();
    } else if (this.isMovingLeft()) {
      return game.board.getCellAt(this.row, this.col - 1).isWall(); 
    } else if (this.isMovingUp()) {
      return game.board.getCellAt(this.row - 1, this.col).isWall();
    } else if (this.isMovingDown()) {
      return game.board.getCellAt(this.row + 1, this.col).isWall();
    } else {
      return true; 
    }
  }
  
  private boolean didEatPowerPellet() {
    Cell current = new Cell(this.row, this.col);
    
    for (Cell cell : POWER_PELLET_POSNS) {
      if (current.equals(cell)) {
        return true;
      }
    }
    
    return false;
  }
  
  private boolean isOnCell() {
    return Math.abs(this.initX - (int) this.posn.x) % INCREMENT == 0
    && Math.abs(this.initY - (int) this.posn.y) % INCREMENT == 0;
  }
  
  private boolean isOnTurnBlock() {
    Cell curr = game.board.getCellAt(this.row, this.col);
    
    return curr.isTurnBlock() || curr.isEatenTurnBlock();
  }
  
  private boolean isMovingUp() {
    return this.orientation.y == -1; 
  }
  
  private boolean isMovingDown() {
    return this.orientation.y == 1; 
  }
  
  private boolean isMovingRight() {
    return this.orientation.x == 1; 
  }
  
  private boolean isMovingLeft() {
    return this.orientation.x == -1; 
  }
  
  private boolean isNotMoving() {
    return this.orientation.x == 0 && this.orientation.y == 0; 
  }
}
