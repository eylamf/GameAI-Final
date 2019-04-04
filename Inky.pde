
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
    
    if (this.path.isEmpty()) {
      this.createPath(); 
    }
  }
  
  @Override
  public void createPath() {
    
  }
  
  @Override
  public void chase() {
    
  }
  
  @Override
  public void scatter() {
    
  }
}
