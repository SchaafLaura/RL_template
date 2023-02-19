abstract class Entity{
  Point pos;
  int x, y;
  Entity(int x, int y){
    pos = new Point(x, y);
    this.x = x;
    this.y = y;
  }
  Entity(Point pos){
    this.pos = pos.Clone();
    this.x = pos.x;
    this.y = pos.y;
  }
  public void MoveTo(Point newPos){
    pos = newPos.Clone();
    this.x = pos.x;
    this.y = pos.y;
  }
}

static abstract class VertexFunction<EntityType extends Entity> {
  abstract void Apply(EntityType e);
}

static abstract class ActorFunction extends VertexFunction<Actor> {
}
