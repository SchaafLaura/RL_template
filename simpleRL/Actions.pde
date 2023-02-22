abstract class Action {
  int cost = 100;
  Actor performedBy;
  public Action(Actor performedBy) {
    this.performedBy = performedBy;
  }
  public Action(Actor performedBy, int cost) {
    this.performedBy = performedBy;
    this.cost = cost;
  }
  public abstract ActionResult Perform();
}

class AttackAction extends Action{
  Point dir;
  public AttackAction(Actor performedBy, Point dir){
    super(performedBy);
    this.dir = dir;
  }
  
  public ActionResult Perform(){
    if(dir.x == 0 && dir.y == 0)
      return failure;
    
    Point attackLocation = Point.Add(dir, performedBy.pos);
    Actor toAttack = currentLevel.TryGetActorAt(attackLocation);
    
    if(toAttack == null)
      return failure;
    
    toAttack.TakeDamage(50);
    performedBy.energy -= 100;
    return success;
  }
}

class MovementAction extends Action {
  Point dir;
  public MovementAction(Actor performedBy, Point dir) {
    super(performedBy);
    this.dir = dir;
  }

  public ActionResult Perform() {
    Point goalLocation = Point.Add(performedBy.pos, dir);

    // standing still action
    if (dir.x == 0 && dir.y == 0) {
      performedBy.energy -= cost;
      return success;
    }
    
    if(!tileSet[currentLevel.map.mapData[goalLocation.x][goalLocation.y]].passable)
      return failure;
    
    if (currentLevel.TryGetActorAt(goalLocation) != null) {
      AttackAction alt = new AttackAction(performedBy, dir);
      return new ActionResult(alt);
    }
    
    performedBy.MoveTo(goalLocation);
    performedBy.energy -= cost;
    
    if(performedBy instanceof Player)
      step.play();
    
    return success;
  }
}
