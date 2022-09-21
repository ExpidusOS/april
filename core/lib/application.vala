namespace April {
  public abstract class Application : GLib.Object {
    public abstract void launch(GLib.HashTable<string, GLib.Value?> args);
  }
}
