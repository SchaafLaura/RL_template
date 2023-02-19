import java.util.ArrayDeque;
import processing.sound.*;
import java.util.stream.Collectors;

Level currentLevel;
Player player;

PImage[] actorTileSet;
PImage[] otherTileSet;
void setup() {
  size(1600, 900);
  smooth(0);
  currentLevel = new Level(0);
  player = new Player(currentLevel.map.w/2, currentLevel.map.h/2);
  currentLevel.AddActor(player);
  currentActor = player;
  player.speed = 50;

  for (int i = 0; i < 100; i++) {
    Enemy bla = new Enemy((int)random(2,currentLevel.map.w-2), (int)random(2,currentLevel.map.h-2));
    bla.speed = (int) random(30, 100);
    currentLevel.AddActor(bla);
  }

  tileSet = new Tile[]{
    new Tile("groundTile.png", true),
    new Tile("wallTile.png", false)
  };

  actorTileSet = new PImage[]{
    loadImage("player.png"),
    loadImage("enemy.png")
  };

  otherTileSet = new PImage[]{
    loadImage("mapHighlight.png")
  };


  gameState = GameState.PLAYING;
  previousGameState = GameState.PLAYING;
}
