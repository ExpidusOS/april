namespace AprilExpidus {
  private class ApplicationPlatformServiceWrapped : TokyoGtk.Application {
    private April.Application _application;
    private GLib.HashTable<string, GLib.Variant> _args;

    public April.Application application {
      get {
        return this._application;
      }
      construct {
        this._application = value;
      }
    }

    public ApplicationPlatformServiceWrapped(April.Application application) {
      Object(application: application, application_id: application.metadata.id);
    }

    public override void activate() {
      GLib.debug("Launching application");
      this.application.launch(this._args);
    }

    public new void run(GLib.HashTable<string, GLib.Variant> args) {
      var argv = args.contains("gapplication.arguments") ? args.get("gapplication.arguments").get_strv() : new string[1];
      this._args = args;
      base.run(argv);
    }
  }

  public class ApplicationPlatformService : April.ApplicationPlatformService {
    private GLib.HashTable<string, ApplicationPlatformServiceWrapped> _applications;

    public override string version {
      get {
        return April.ApplicationPlatformService.VERSION;
      }
    }

    construct {
      this._applications = new GLib.HashTable<string, ApplicationPlatformServiceWrapped>(GLib.str_hash, GLib.str_equal);
    }

    public ApplicationPlatformService(Platform platform) {
      Object(platform: platform);
    }

    public override void register_application(April.Application application) {
      GLib.debug("Registering application: %s", application.metadata.id);

      this._applications.set(application.metadata.id, new ApplicationPlatformServiceWrapped(application));
    }

    public override void unregister_application(April.Application application) {
      GLib.debug("Unregistering application: %s", application.metadata.id);

      this._applications.remove(application.metadata.id);
    }

    public override void launch(April.Application application, GLib.HashTable<string, GLib.Variant> args) {
      this._applications.get(application.metadata.id).run(args);
    }
  }
}
