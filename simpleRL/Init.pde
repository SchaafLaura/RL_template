import java.util.ArrayDeque;
import processing.sound.*;
import java.util.stream.Collectors;

Level currentLevel;
Actor player;

PImage[] actorTileSet;
PImage[] otherTileSet;
void setup() {
  size(1600, 900);
  smooth(0);
  currentLevel = new Level(0);
  player = new Player(currentLevel.map.w/2, currentLevel.map.h/2);
  currentLevel.AddActor(player);

  Enemy bla = new Enemy(10, 10);
  currentLevel.AddActor(bla);

  tileSet = new Tile[]{
    new Tile("groundTile.png", true),
    new Tile("wallTile.png", false)
  };
  
  actorTileSet = new PImage[]{
    loadImage("player.png")
  };
  
  otherTileSet = new PImage[]{
    loadImage("mapHighlight.png")
  };


  gameState = GameState.PLAYING;
  previousGameState = GameState.PLAYING;
}
