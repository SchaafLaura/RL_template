import java.util.ArrayDeque;
import processing.sound.*;
import java.util.stream.Collectors;

Level currentLevel;
Player player;
SoundFile step;

PImage[] actorTileSet;
PImage[] otherTileSet;

int maximumBrightness = 12;
void setup() {
  size(1600, 900);
  smooth(0);
  currentLevel = new Level(0);
  player = new Player(currentLevel.map.w/2, currentLevel.map.h/2);
  currentLevel.AddActor(player);
  currentActor = player;
  player.speed = 50;

  for (int i = 0; i < 100; i++) {
    Enemy bla = new Enemy((int)random(2, currentLevel.map.w-2), (int)random(2, currentLevel.map.h-2));
    bla.speed = (int) random(10, 30);
    currentLevel.AddActor(bla);
  }
  
  for(int i = 0; i < 10; i++){
    Light L = new Light((int)random(0, currentLevel.map.w), (int)random(0, currentLevel.map.h));
    L.range = maximumBrightness;
    L.c = color(random(200, 255), random(200, 255), random(200, 255));
    currentLevel.lights.add(L);
  }
  currentLevel.UpdateLights();
  
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

  TESTING = loadImage("2x2Enemy.png");
  
  String soundPath = dataPath("sound/player");
  step = new SoundFile(this, soundPath + "/step2.wav");

  gameState = GameState.PLAYING;
  previousGameState = GameState.PLAYING;
}


GameState gameState;
GameState previousGameState;
enum GameState {
  LOADING,
    MAINMENU,
    PLAYING,
    GAMEOVER,
    HIGHSCORE,
    CONTENTWARNING
}

void SwitchToGameState(GameState state) {
  previousGameState = gameState;
  gameState = state;
}
