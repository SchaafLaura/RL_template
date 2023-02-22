class Rectangle {
  float x;
  float y;
  float w;
  float h;
  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean Intersects(Rectangle other) {
    return !(
      other.x - other.w > this.x + this.w ||
      other.x + other.w < this.x - this.w ||
      other.y - other.h > this.y + this.h ||
      other.y + other.h < this.y - this.h);
  }

  boolean Contains(float vx, float vy) {
    return vx >= x - w/2.0 && vx <= x + w/2.0 && vy >= y - h/2.0 && vy <= y + h/2.0;
  }
}

static class Point{
  int x, y;
  Point(int x, int y){
    this.x = x;
    this.y = y;
  }
  Point Clone(){
    return new Point(x,y);
  }
  static Point Add(Point A, Point B){
    return new Point(A.x + B.x, A.y + B.y);
  }
}

class Line {
  ArrayList<PVector> indices;
  int x1_original;
  int y1_original;
  int x0_original;
  int y0_original;
  public Line(int x1_, int y1_, int x0_, int y0_) {
    this.x1_original = x1_;
    this.y1_original = y1_;
    this.x0_original = x0_;
    this.y0_original = y0_;
    indices = new ArrayList<PVector>();
    MakeIndices(x1_, y1_, x0_, y0_);
    SortIndices();
  }
  
  void Reverse(){
    ArrayList<PVector> newIndices = new ArrayList<PVector>();
    for(int i = indices.size() - 1; i >= 0; i--)
      newIndices.add(indices.get(i));
    indices = newIndices;
  }

  void MakeIndices(int x1, int y1, int x0, int y0) {
    int dx = abs(x1-x0);
    int dy = -abs(y1-y0);
    int sx = x0 < x1 ? 1 : -1;
    int sy = y0 < y1 ? 1 : -1;
    int err = dx+dy;
    while (true) {
      PVector p = new PVector(x0, y0);
      if (!indices.contains(p)) {
        indices.add(p);
      }
      if (x0 == x1 && y0 == y1) {
        break;
      }
      int e2 = 2 * err;
      if (e2 >= dy) {
        err += dy;
        x0 += sx;
      }
      if (e2 <= dx) {
        err += dx;
        y0 += sy;
      }
    }
  }

  void SortIndices() {
    ArrayList<PVector> newindices = new ArrayList<PVector>();
    newindices.add(new PVector(x1_original, y1_original));
    while (!indices.isEmpty()) {
      int lowestDistanceIndex = -1;
      float record = 100;
      for (int i = 0; i < indices.size(); i++) {
        if (newindices.get(newindices.size()-1).dist(indices.get(i)) < record) {
          record = newindices.get(newindices.size()-1).dist(indices.get(i));
          lowestDistanceIndex = i;
        }
      }
      newindices.add(indices.get(lowestDistanceIndex));
      indices.remove(lowestDistanceIndex);
    }
    indices = newindices;
  }

  void ReduceRange(int r) {
    while (indices.get(0).dist(indices.get(indices.size()-1)) > r) {
      indices.remove(indices.size() - 1);
    }
  }
}
