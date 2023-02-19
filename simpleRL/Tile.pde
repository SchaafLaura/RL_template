Tile[] tileSet;
class Tile {
  boolean passable = true;
  PImage img;
  public Tile(String path, boolean b){
    this.passable = b;
    this.img = loadImage(path);
  }
}
