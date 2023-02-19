class Map {
  Tile[] tiles;
  int[][] mapData;
  int[][] Dmap;
  int[][] buffer;
  PGraphics miniMap;
  int w, h; // width and height
  public Map(int w, int h) {
    this.w = w;
    this.h = h;
    InitMapData();
    InitDMap();
    InitMiniMap();
  }

  public void Display() {
  }

  void InitDMap() {
    this.Dmap = new int[50][50];
    this.buffer = new int[50][50];
    MakeDMap();
  }


  void InitMiniMap() {
    miniMap = createGraphics(50, 50);
    miniMap.beginDraw();
    miniMap.loadPixels();
    miniMap.updatePixels();
    miniMap.endDraw();
  }

  public void DisplayMiniMap() {
    image(miniMap, 100, 100);
  }

  void MakeDMap() {
  }

  void InitMapData() {
    mapData = new int[w][h];
    for(int x = 0; x < w; x++)
      for(int y = 0; y < h; y++)
        mapData[x][y] = random(0,1) < 0.9f ? 0 : 1; // 0 is for ground, 1 is walls
    for(int x = 0; x < w; x++){
      mapData[x][0] = 1;
      mapData[x][h-1] = 1;
    }
    
    for(int y = 0; y < h; y++){
      mapData[0][y] = 1;
      mapData[w-1][y] = 1;
    }
    
    
    
  }
}
