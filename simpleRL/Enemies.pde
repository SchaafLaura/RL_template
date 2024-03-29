class Enemy extends Actor {
  Enemy(int x, int y) {
    super(x, y);
  }
  void DecideOnAction() {
  }
  Action GetAction() {
    if(health <= 0)
      return new MovementAction(this, new Point(0,0));
    
    Point dir = new Point((int)random(-2,2), (int)random(-2,2));
    while(!tileSet[currentLevel.map.mapData[x+dir.x][y+dir.y]].passable && !(abs(dir.x) + abs(dir.y) < 2))
      dir = new Point((int)random(-2,2), (int)random(-2,2));
    return new MovementAction(this, dir);
  }
}
