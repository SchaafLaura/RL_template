class QuadTree<EType extends Entity> {
  Rectangle boundary;
  int capacity;
  ArrayList<EType> entities;
  boolean divided = false;
  QuadTree<EType> NE;
  QuadTree<EType> SE;
  QuadTree<EType> SW;
  QuadTree<EType> NW;

  QuadTree(Rectangle boundary, int capacity) {
    this.boundary = boundary;
    this.capacity = capacity;
    this.entities = new ArrayList<EType>();
  }

  void ApplyToAll(VertexFunction<EType> function) {
    for (int i = 0; i < entities.size(); i++)
      function.Apply(entities.get(i));
    if (divided) {
      NE.ApplyToAll(function);
      SE.ApplyToAll(function);
      SW.ApplyToAll(function);
      NW.ApplyToAll(function);
    }
  }

  void ApplyTo(VertexFunction<EType> function, Rectangle R) {
    ArrayList<EType> toApplyTo = Query(R);
    for (int i = 0; i < toApplyTo.size(); i++)
      function.Apply(toApplyTo.get(i));
  }

  void ApplyTo(VertexFunction<EType> function, float x, float y, float r) {
    ArrayList<EType> toApplyTo = Query(x, y, r);
    for (int i = 0; i < toApplyTo.size(); i++)
      function.Apply(toApplyTo.get(i));
  }

  ArrayList<EType> Query(float x, float y, float r) {
    ArrayList<EType> candidates = Query(new Rectangle(x, y, r, r));
    candidates.removeIf(v -> (v.x - x)*(v.x - x) + (v.y - y)*(v.y - y) > (r*0.5) * (r*0.5));
    return candidates;
  }

  ArrayList<EType> Query(Rectangle R) {
    ArrayList<EType> foundNodes = new ArrayList<EType>();
    if (!boundary.Intersects(R))
      return foundNodes;

    foundNodes.addAll(entities.stream().filter(node -> R.Contains(node.x, node.y)).collect(Collectors.toList()));

    if (divided) {
      foundNodes.addAll(NE.Query(R));
      foundNodes.addAll(SE.Query(R));
      foundNodes.addAll(SW.Query(R));
      foundNodes.addAll(NW.Query(R));
    }
    return foundNodes;
  }

  boolean Insert(EType entity) {
    if (!boundary.Contains(entity.x, entity.y))
      return false;

    if (entities.size() < capacity) {
      entities.add(entity);
      return true;
    }

    if (!divided)
      Subdivide();

    if (NE.Insert(entity))
      return true;
    else if (SE.Insert(entity))
      return true;
    else if (SW.Insert(entity))
      return true;

    return NW.Insert(entity);
  }

  void Subdivide() {
    divided = true;
    Rectangle r = boundary;
    NE = new QuadTree(new Rectangle(r.x + r.w/4.0, r.y - r.h/4.0, r.w/2, r.h/2), capacity);
    SE = new QuadTree(new Rectangle(r.x + r.w/4.0, r.y + r.h/4.0, r.w/2, r.h/2), capacity);
    SW = new QuadTree(new Rectangle(r.x - r.w/4.0, r.y + r.h/4.0, r.w/2, r.h/2), capacity);
    NW = new QuadTree(new Rectangle(r.x - r.w/4.0, r.y - r.h/4.0, r.w/2, r.h/2), capacity);
  }

  void Display() {
    DisplayPoints();
    DisplayChildren();
  }

  void DisplayChildren() {
    if (!divided)
      return;
    NE.Display();
    SE.Display();
    SW.Display();
    NW.Display();
  }

  void DisplayPoints() {
    /*
    fill(255);
     noStroke();
     for (int i = 0; i < entities.size(); i++)
     entities.get(i).Display();
     */
  }
}
