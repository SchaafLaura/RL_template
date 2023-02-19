void keyPressed() {
  switch(gameState) {
  case PLAYING:
    HandleKeyPlaying(key);
    break;
  }
}

void HandleKeyPlaying(char c) {
  if (c == 'w')
    player.TakeAction(new MovementAction(player, new Point(0, -1)));
  if (c == 's')
    player.TakeAction(new MovementAction(player, new Point(0, 1)));
  if (c == 'a')
    player.TakeAction(new MovementAction(player, new Point(-1, 0)));
  if (c == 'd')
    player.TakeAction(new MovementAction(player, new Point(1, 0)));
}

void mousePressed() {
}
