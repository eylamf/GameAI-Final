class Blinky extends Ghost {
  public Blinky() {
    super();
    this.row = 11;
    this.col = 13;
    int x = convertCtoX(this.col);
    int y = convertRtoY(this.row);
    this.posn = new PVector(x, y);
    this.orientation = new PVector(0, -1);
  }
  
  public void render() {
    super.render(RED);
    
    if (this.path.isEmpty()) {
      this.createPath(); 
    }
  }
  
  @Override
  public void createPath() {
    if (this.isOnCell()) {
      this.path = aStar(game.pacman.row, game.pacman.col, this.row, this.col); 
    }
  }
  
  @Override
  public void chase() {
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
  
  @Override
  public void scatter() {
    
  }
}
