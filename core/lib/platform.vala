namespace April {
  public abstract class Platform : ABIBoundedObject {
    private Vdi.Container _container;

    public Vdi.Container container {
      get {
        return this._container;
      }
    }

    construct {
      this._container = new Vdi.Container();
      this._container.bind_factory(typeof (ApplicationLauncherPlatformService), container => new ApplicationLauncherPlatformService(this));
    }

    public April.PlatformService? get_service(GLib.Type t) {
      return this.container.get(t) as April.PlatformService;
    }
  }
}
