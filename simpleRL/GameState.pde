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
