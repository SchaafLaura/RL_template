abstract class Item extends Entity {
  Item(int x, int y) {
    super(x, y);
  }
}

abstract class Weapon extends Item {
  int damage;
  float speed;

  public Weapon(int d, float s) {
    super(0, 0);
    this.damage = d;
    this.speed = s;
  }
}
