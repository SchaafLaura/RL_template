float RandomNormal(float mu, float sigma) {
  float f = random(0, 1);
  float z = -log((1/f) - 1)/1.702;
  return mu + z * sigma;
}

void ChangeGameState() {
  switch(gameState) {
  case LOADING:
    break;
  case MAINMENU:
    break;
  case PLAYING:
    /*
    if (player.health <= 0) {
      switchToGameState(GameState.GAMEOVER);
    }*/
    break;
  case GAMEOVER:
    break;
  case HIGHSCORE:
    break;
  case CONTENTWARNING:
    if (frameCount > 120)  SwitchToGameState(GameState.MAINMENU);
    break;
  }
}
