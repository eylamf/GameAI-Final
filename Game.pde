class Game {
  public Board board;
  public Pacman pacman;
  public Blinky blinky;
  public Pinky pinky;
  public Clyde clyde;
  public Inky inky;
  public int timer;
  private int mode;
  
  public Game() {
    this.board = new Board();
    this.pacman = new Pacman();
    this.blinky = new Blinky();
    this.pinky = new Pinky();
    this.clyde = new Clyde();
    this.inky = new Inky();
    this.timer = 0;
    this.mode = CHASING;
  }
  
  public void render() {
    this.board.render(); 
    this.blinky.render();
    this.pinky.render();
    this.clyde.render();
    this.inky.render();
    this.pacman.render();
    
    if (LIVES > 0) {
      this.pacman.move();
      this.blinky.move();
      
      if (SCORE > 10) {
        if (this.pinky.getIsActive()) {
          this.pinky.move();  
        } else {
          if (this.pinky.mode == CHASING) {
            this.pinky.move(); 
          }
        }
      }
      
      if (SCORE > 20) {
        if (this.clyde.getIsActive()) {
          this.clyde.move();  
        } else {
          if (this.clyde.mode == CHASING) {
            this.clyde.move(); 
          }
        }
      }
      
      if (SCORE > 30) {
        if (this.inky.getIsActive()) {
          this.inky.move();  
        } else {
          if (this.inky.mode == CHASING) {
            this.inky.move(); 
          }
        } 
      }
      
      // Frightened timer
      if (this.mode == FRIGHTENED) {
        this.timer++;
      
        // Frightened mode lasts for 7s
        if (this.timer > 700) {
          this.mode = CHASING;
          this.setGhostsMode(CHASING);
          this.timer = 0; 
          
          this.clampGhostPosns();
        } 
      }
      // Scatter timer
      else if (this.mode == CHASING) {
        this.timer++;
        
        // Switch to scatter after 9s of chasing
        if (this.timer > 900) {
          this.setMode(SCATTER);
          this.setGhostsMode(SCATTER);
          this.clampGhostPosns();
        }
      }
      // Switch to chasing after 6s of scatter
      else if (this.mode == SCATTER) {
        this.timer++; 
        
        if (this.timer > 600) {
          this.setMode(CHASING);
          this.setGhostsMode(CHASING);
          this.clampGhostPosns();
        }
      }
      
    } else {
      fill(RED);
      textAlign(CENTER);
      textSize(24);
      text("GAME OVER", 0, 0);
    }
  }
  
  public int getMode() {
    return this.mode;
  }
  
  public void setMode(int m) {
    this.mode = m;
    this.timer = 0;
  }
  
  public void setGhostsMode(int mode) {
    if (mode == SCATTER) {
      this.setGhostsScatterDest();
    }
    
    this.blinky.setMode(mode);
    this.pinky.setMode(mode);
    this.clyde.setMode(mode);
    this.inky.setMode(mode);
    
    this.clampGhostPosns();
  }
  
  public void clampGhostPosns() {
    this.blinky.clampPosn(); 
    this.pinky.clampPosn();
    this.clyde.clampPosn();
    this.inky.clampPosn();
  }
  
  private void setGhostsScatterDest() {
    this.blinky.setInitialScatterDest();
    this.pinky.setInitialScatterDest();
    this.clyde.setInitialScatterDest();
    this.inky.setInitialScatterDest();
  }
}
