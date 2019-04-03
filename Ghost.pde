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
  
  public abstract void chase();
  
  public abstract void scatter();
  
  public void render(color c) {
     fill(c, this.alpha);
     stroke(c);
     strokeWeight(2);
     rect(this.posn.x, this.posn.y, INCREMENT, INCREMENT, INCREMENT, INCREMENT, 2, 2);
     
     strokeWeight(3);
     for (Node n : this.path) {
       n.renderPath(c, this.alpha); 
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
  
  protected void moveRandomly() {
    
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
