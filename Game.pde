class Game {
  public int mode;
  public Board board;
  public Pacman pacman;
  public Blinky blinky;
  public Pinky pinky;
  public Clyde clyde;
  
  public Game() {
    this.mode = CHASING;
    this.board = new Board();
    this.pacman = new Pacman();
    this.blinky = new Blinky();
    this.pinky = new Pinky();
    this.clyde = new Clyde();
  }
  
  public void render() {
    this.board.render(); 
    this.blinky.render();
    this.pinky.render();
    this.clyde.render();
    this.pacman.render();
    
    this.pacman.move();
    this.blinky.move();
    this.pinky.move();
    this.clyde.move();
  }
}
