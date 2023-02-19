Actor currentActor;
int currentActorIndex;
void gameLoop() {
  
  if (currentActor.HasEnoughEnergy()) {
    var action = currentActor.GetAction();
    if (action == null) return; // should only happen when it's the players turn and they haven't input anything
    println("performing");
    println(player.x);
    while (true) {
      var result = action.Perform();
      if (!result.succeeded) return; // invalid action
      if (result.alternative == null) break;
      action = result.alternative;
    }
  } else {
    currentActor.GainEnergy();
  }

  currentActorIndex = (currentActorIndex + 1) % currentLevel.actorList.size();
  currentActor = currentLevel.GetActor(currentActorIndex);
}

void UpdateGame() {
  if (currentActorIndex == 0 || player.actionStack.size() > 0) {
    gameLoop();
    currentLevel.Update();
  }
  while (currentActorIndex != 0)
    gameLoop();
}

PGraphics mapView;
PImage TESTING;
void DisplayMap() {
  if (somethingChanged)
    mapView = currentLevel.GetMapView(0, 0, 60, 35);
  float mapX = 24;
  float mapY = 24;
  image(mapView, mapX, mapY);
  image(TESTING, 48, 48);
}

boolean somethingChanged = true;
float timePassed = 0;
void draw() {
  ChangeGameState();
  switch(gameState) {
  case LOADING:
    DisplayLoadingScreen();
    break;
  case MAINMENU:
    DisplayMainMenu();
    break;
  case PLAYING:
    UpdateGame();
    DisplayGame();
    break;
  case GAMEOVER:
    DisplayGameOverScreen();
    break;
  case HIGHSCORE:
    break;
  case CONTENTWARNING:
    DisplayContentWarning();
    break;
  }
  
}

void DisplayUI() {
  float mapX = 24;
  float mapY = 24;
  float tileSize = 24;

  float relX = mouseX - mapX;
  float relY = mouseY - mapY;

  float tileX = floor(relX/tileSize);
  float tileY = floor(relY/tileSize);

  if (mouseX > mapX && mouseX < mapX + mapView.width && mouseY > mapY && mouseY < mapY + mapView.height) {
    noFill();
    stroke(255);
    image(otherTileSet[0], mapX + tileX * tileSize, mapY + tileY * tileSize);
  }

  Actor actorAtMousePosition = currentLevel.TryGetActorAt((int)tileX, (int)tileY);
  if (actorAtMousePosition != null)
    println("detected " + frameCount);
}

void DisplayGame() {
  background(20);
  DisplayMap();
  DisplayAnimations();
  somethingChanged = true;
  DisplayUI();
}

void DisplayAnimations(){
  float t = millis();
  if(t - timePassed > 1000){
    println("second passed");
    timePassed = t;
  }
}

void DisplayGameOverScreen() {
}

void DisplayContentWarning() {
}
