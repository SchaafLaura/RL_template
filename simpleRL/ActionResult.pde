ActionResult success = new ActionResult(true);
ActionResult failure = new ActionResult(false);
public class ActionResult {
  public Action alternative;
  public Boolean succeeded;


  public ActionResult(Boolean succeeded) {
    this.succeeded = succeeded;
    this.alternative = null;
  }

  public ActionResult(Action alternative) {
    this.alternative = alternative;
    this.succeeded = true;
  }
}
