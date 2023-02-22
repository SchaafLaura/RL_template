class Player extends Actor {
  Player(int x, int y) {
    super(x, y);
    health = 1000;
    maxHealth = 1000;
  }
  void DecideOnAction() {
  }
  
  void TakeAction(Action a){
    if (actionStack.size() != 0)
      return;
    actionStack.push(a);
  }
  
  
  
  Action GetAction() {
    if (actionStack.size() != 0)
      return actionStack.pop();
    return null;
  }
}
