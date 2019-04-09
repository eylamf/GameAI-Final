class Game {
  public int mode;
  public Board board;
  public Pacman pacman;
  public Blinky blinky;
  public Pinky pinky;
  public Clyde clyde;
  public Inky inky;
  
  public Game() {
    this.mode = CHASING;
    this.board = new Board();
    this.pacman = new Pacman();
    this.blinky = new Blinky();
    this.pinky = new Pinky();
    this.clyde = new Clyde();
    this.inky = new Inky();
  }
  
  public void render() {
    this.board.render(); 
    this.blinky.render();
    this.pinky.render();
    this.clyde.render();
    this.inky.render();
    this.pacman.render();
    
    this.pacman.move();
    this.blinky.move();
    
    if (SCORE > 10) {
      this.pinky.move(); 
    }
    
    if (SCORE > 20) {
      this.clyde.move(); 
    }
    
    if (SCORE > 30) {
      this.inky.move(); 
    }
  }
  
  public void setMode(int m) {
    this.mode = m; 
  }
}
