static abstract class VertexFunction<EntityType extends Entity> {
  abstract void Apply(EntityType e);
}

static abstract class ActorFunction extends VertexFunction<Actor> {
}
