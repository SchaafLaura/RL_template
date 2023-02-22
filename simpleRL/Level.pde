class Level {
  int stage;
  Map map;
  int[][] illuminationMap;
  ArrayList<Light> lights;
  boolean lightsChanged = true;
  QuadTree<Actor> actors;
  ArrayList<Actor> actorList;
  QuadTree<Item> items;
  ArrayList<Item> itemList;


  //PGraphics mapView;

  public Level(int stage) {
    this.stage = stage;
    Init();
    mapView = createGraphics((int)(60 * 24), (int)(60 * 24));
  }

  public void Display() {
    int mapW = map.mapData.length;
    int mapH = map.mapData[0].length;
    float tileSize = tileSet[0].img.width;

    for (int x = 0; x < mapW; x++)
      for (int y = 0; y < mapH; y++)
        image(tileSet[map.mapData[x][y]].img, x * tileSize, y * tileSize);
  }

  public PGraphics GetMapView(int startX, int startY, int sizeX, int sizeY) {
    float tileSize = tileSet[0].img.width;
    mapView.beginDraw();
    mapView.background(0);
    mapView.blendMode(ADD);
    for (int x = startX; x < startX + sizeX; x++) {
      for (int y = startY; y < startY + sizeY; y++) {
        int brightness = illuminationMap[x][y];
        if (brightness == 0)
          continue;
        mapView.tint(map(brightness, 0, maximumBrightness, 0, 255));
        mapView.image(tileSet[map.mapData[x][y]].img, (x-startX) * tileSize, (y-startY) * tileSize);
      }
    }
    Rectangle viewPort = new Rectangle(startX + sizeX/2, startY + sizeY/2, sizeX, sizeY);
    ArrayList<Actor> actorsInView = actors.Query(viewPort);
    for (Actor a : actorsInView) {
      int brightness = illuminationMap[a.x][a.y];
      if (brightness == 0)
        continue;
      mapView.tint(map(brightness, 0, maximumBrightness, 0, 255));
      mapView.image(a instanceof Player ? actorTileSet[0] : actorTileSet[1], (a.x - startX) * tileSize, (a.y - startY) * tileSize);
    }

    mapView.endDraw();

    return mapView;
  }

  void UpdateLights() {
    if (!lightsChanged)
      return;

    for (Light light : lights) {
      light.Illuminate();
    }


    lightsChanged = false;
  }


  void DisplayActors() {
  }

  public Actor GetActor(int i) {
    return actorList.get(i);
  }

  public boolean AddActor(Actor actor) {
    // TODO: check if something is at that location already, if so, return false
    actorList.add(actor);
    actors.Insert(actor);

    return true;
  }

  public Actor TryGetActorAt(Point p) {
    return TryGetActorAt(p.x, p.y);
  }


  public Actor TryGetActorAt(int x, int y) {
    Rectangle selection = new Rectangle(x, y, 0.5, 0.5);
    ArrayList<Actor> maybeActor = actors.Query(selection);
    if (maybeActor.size() == 0)
      return null;
    if (maybeActor.size() == 1)
      return maybeActor.get(0);
    return null;
  }

  void Init() {
    this.map = new Map(60, 35);
    this.illuminationMap = new int[60][35];
    for (int i = 0; i < 60; i++)
      for (int j = 0; j < 35; j++)
        illuminationMap[i][j] = 0;

    Rectangle levelBoundary = new Rectangle(map.w/2, map.h/2, map.w, map.h);

    actors = new QuadTree<Actor>(levelBoundary, 10);
    actorList = new ArrayList<Actor>();
    items = new QuadTree<Item>(levelBoundary, 10);
    itemList = new ArrayList<Item>();
    lights = new ArrayList<Light>();
  }

  public void Update() {
  }
}
