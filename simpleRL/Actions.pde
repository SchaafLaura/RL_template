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

class MovementAction extends Action {
  Point dir;
  public MovementAction(Actor performedBy, Point dir) {
    super(performedBy);
    this.dir = dir;
  }

  public ActionResult Perform() {
    Point goalLocation = Point.Add(new Point(performedBy.pos.x, performedBy.pos.y), dir);

    // standing still action
    if (dir.x == 0 && dir.y == 0) {
      /*if (!performedBy.isPlayer && performedBy.health < performedBy.maxHealth) {
        currentLevel.map.tiles[performedBy.posX][performedBy.posY].materialAmounts[material_Blood] += 70;
      }*/
      performedBy.energy -= cost;
      return success;
    }
    
    
    // RIGHT NOW DON'T CHECK IF SPOT IS FREE, JUST MOVE
    performedBy.pos.x = goalLocation.x;
    performedBy.pos.y = goalLocation.y;
    performedBy.energy -= cost;
    return success;

    // new spot is empty - we can move there
    /*
    if (currentLevel.map.tiles[(int)goalLocation.x][(int)goalLocation.y].passable &&
      currentLevel.tryGetActorAt((int)goalLocation.x, (int)goalLocation.y) == null   ) {
      performedBy.posX = (int) goalLocation.x;
      performedBy.posY = (int) goalLocation.y;

      performedBy.energy -= cost;
      if (!performedBy.isPlayer && performedBy.health < performedBy.maxHealth) {

        currentLevel.map.tiles[performedBy.posX + (int)random(-2, 2)][performedBy.posY+ (int)random(-2, 2)].materialAmounts[material_Blood] += random(40, 100);
      }
      if (performedBy instanceof Player) {
        step.play();
      }

      performedBy.energy -= cost;
      return success;
    }*/
    
    // alternative attack when walking into someone
    /*
    if (currentLevel.tryGetActorAt((int)goalLocation.x, (int)goalLocation.y) != null) {
      AttackAction alt = new AttackAction(performedBy, direction);
      return new ActionResult(alt);
    }
    return failure;*/
  }
}
