class Game {
  public int mode;
  public Board board;
  public Pacman pacman;
  public Blinky blinky;
  public Pinky pinky;
  public Clyde clyde;
  public Inky inky;
  private int timer;
  
  public Game() {
    this.mode = CHASING;
    this.board = new Board();
    this.pacman = new Pacman();
    this.blinky = new Blinky();
    this.pinky = new Pinky();
    this.clyde = new Clyde();
    this.inky = new Inky();
    this.timer = 0;
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
          if (game.mode == CHASING) {
            this.pinky.move(); 
          }
        }
      }
      
      if (SCORE > 20) {
        if (this.clyde.getIsActive()) {
          println("active");
          this.clyde.move();  
        } else {
          if (game.mode == CHASING) {
            this.clyde.move(); 
          }
        }
      }
      
      if (SCORE > 30) {
        if (this.inky.getIsActive()) {
          this.inky.move();  
        } else {
          if (game.mode == CHASING) {
            this.inky.move(); 
          }
        } 
      }
      
      // Ghost flash timer
      if (this.mode == FRIGHTENED) {
        this.timer++;
        // Frightened mode lasts for 7s
        if (this.timer > 700) {
          this.setMode(CHASING);
          this.timer = 0;
          
          this.blinky.clampPosn();
          this.pinky.clampPosn();
          this.clyde.clampPosn();
          this.inky.clampPosn();
        }        
      }
    } else {
      fill(RED);
      textAlign(CENTER);
      textSize(24);
      text("GAME OVER", 0, 0);
    }
  }
  
  public void setMode(int m) {
    this.mode = m; 
  }
  
  public int getTimer() {
    return this.timer;
  }
}
