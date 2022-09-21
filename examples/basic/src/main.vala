namespace ExampleApplication {
  public class MyView : April.View {
    public MyView(April.Application application) {
      Object(application: application);
    }

    public override void create() {}
  }

  public class MyApplication : April.Application {
    public override void launch(GLib.HashTable<string, GLib.Variant> args) {
      new MyView(this);
    }
  }
}
