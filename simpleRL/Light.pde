class Light extends Entity{
  int range;
  int minRange = 2;
  int minBrightness = 5;
  color c;
  float falloffStrength = 1.2;
  Light(int x, int y){
    super(x,y);
  }
  
  int BrightnessAtDistance(int distance){
    if(distance < minRange)
      return range;
    if(distance > range)
      return 0;
    float x = distance - minRange;
    int b =(int) ((float) range * pow(falloffStrength, -x));
    
    return max(minBrightness, b);
  }
  
  void Illuminate(){
    if (currentLevel.map.mapData[x][y] == 1)
        return;
      for (int i = x - range; i < x + range; i++) {
        Line lineTop = new Line(x, y, i, y - range);
        Line lineBot = new Line(x, y, i, y + range);
        lineTop.ReduceRange(range);
        lineBot.ReduceRange(range);
        for (int j = 0; j < lineTop.indices.size(); j++) {
          int x = (int)lineTop.indices.get(j).x;
          int y = (int)lineTop.indices.get(j).y;
          if (x >= 0 && x < currentLevel.map.w && y >= 0 && y < currentLevel.map.h)
            currentLevel.illuminationMap[x][y] = max(BrightnessAtDistance(j), currentLevel.illuminationMap[x][y]);
          if (currentLevel.map.mapData[x][y] == 1)
            break;
        }

        for (int j = 0; j < lineBot.indices.size(); j++) {
          int x = (int)lineBot.indices.get(j).x;
          int y = (int)lineBot.indices.get(j).y;
          if (x >= 0 && x < currentLevel.map.w && y >= 0 && y < currentLevel.map.h)
            currentLevel.illuminationMap[x][y] = max(BrightnessAtDistance(j), currentLevel.illuminationMap[x][y]);
          if (currentLevel.map.mapData[x][y] == 1)
            break;
        }
      }

      for (int i = y - range; i < y + range; i++) {
        Line lineLeft = new Line(x, y, x - range, i);
        Line lineRight = new Line(x, y, x + range, i);
        lineLeft.ReduceRange(range);
        lineRight.ReduceRange(range);
        for (int j = 0; j < lineLeft.indices.size(); j++) {
          int x = (int)lineLeft.indices.get(j).x;
          int y = (int)lineLeft.indices.get(j).y;

          if (x >= 0 && x < currentLevel.map.w && y >= 0 && y < currentLevel.map.h)
            currentLevel.illuminationMap[x][y] = max(BrightnessAtDistance(j), currentLevel.illuminationMap[x][y]);
          if (currentLevel.map.mapData[x][y] == 1)
            break;
        }

        for (int j = 0; j < lineRight.indices.size(); j++) {
          int x = (int)lineRight.indices.get(j).x;
          int y = (int)lineRight.indices.get(j).y;

          if (x >= 0 && x <currentLevel.map.w && y >= 0 && y < currentLevel.map.h)
            currentLevel.illuminationMap[x][y] = max(BrightnessAtDistance(j), currentLevel.illuminationMap[x][y]);
          if (currentLevel.map.mapData[x][y] == 1)
            break;
        }
      }
    
  }
}
