abstract class Actor extends Entity {
  ArrayDeque<Action> actionStack;
  abstract void DecideOnAction();
  abstract Action GetAction();

  String name;
  int speed = 50;
  int energy = 100;
  float health = 100;
  float maxHealth = 100;

  public Actor(int x, int y) {
    super(x, y);
    actionStack = new ArrayDeque<Action>();
  }
  
  public void MoveTo(Point newPos){
    currentLevel.actors.RemoveAt(pos);
    pos = newPos.Clone();
    this.x = pos.x;
    this.y = pos.y;
    currentLevel.actors.Insert(this);
  }

  public Boolean HasEnoughEnergy() {
    if(health <= 0)
      return false;
    return energy >= 100;
  }
  void GainEnergy() {
    energy += speed;
  }
  void TakeDamage(float dmg) {
    this.health -= dmg;
  }

  void Display() {
  }

  Line LineOfSightToPoint(PVector p) {
    /*
    Line L = new Line(x, y, (int)p.x, (int)p.y);
    for (int i = 0; i < L.indices.size(); i++) {
      if (!currentLevel.map.tiles[(int)L.indices.get(i).x][(int)L.indices.get(i).y].passable) {
        return new Line(x, y, (int)L.indices.get(i).x, (int)L.indices.get(i).y);
      }
    }
    return L;
    */
    return null;
  }

  Line HasLineOfSight(Actor other, int range) {
    /*
    Line L = new Line(x, y, other.x, other.y);
    L.reduceRange(range);

    for (int i = 0; i < L.indices.size(); i++) {
      if (!currentLevel.map.tiles[(int)L.indices.get(i).x][(int)L.indices.get(i).y].passable) {
        return null;
      }
    }
    return L;
    */
    return null;
  }

  void MoveRandomly() {
    /*
    PVector[] randomSteps = findRandomSteps(this.x, this.y);
    if (randomSteps.length != 0) {
      actionStack.push(new MovementAction(this, randomSteps[(int) random(0, randomSteps.length)])); // take random Step
    } else {
      actionStack.push(new MovementAction(this, new PVector(0, 0))); // stand still
    }
    */
  }
}
