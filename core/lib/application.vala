namespace April {
  public abstract class Application : GLib.Object {
    private Platform _platform;
    private AppStream.Component _metadata;

    public Platform platform {
      get {
        return this._platform;
      }
      construct {
        this._platform = value;
      }
    }

    public AppStream.Component metadata {
      get {
        return this._metadata;
      }
      construct {
        this._metadata = value;
      }
    }

    construct {
      var service = this.platform.get_service(typeof (ApplicationPlatformService));
      assert(service != null);

      var application_service = service as ApplicationPlatformService;
      assert(service != null);

      application_service.register_application(this);
    }

    ~Application() {
      var service = this.platform.get_service(typeof (ApplicationPlatformService));
      assert(service != null);

      var application_service = service as ApplicationPlatformService;
      assert(service != null);

      application_service.unregister_application(this);
    }

    public abstract void launch(GLib.HashTable<string, GLib.Variant> args);
  }
}
