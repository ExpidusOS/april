namespace April {
  private delegate GLib.Type ApplicationLauncherPlatformServiceType();

  public class ApplicationLauncherPlatformService : PlatformService {
    public override string version {
      get {
        return ApplicationLauncherPlatformService.VERSION;
      }
    }

    public override ABICompatLevel abi_compat {
      get {
        return this.check_abi_compat(ABITarget.from_string(ApplicationLauncherPlatformService.VERSION));
      }
    }

    public override ABITarget abi_max {
      get {
        return ABITarget.from_string(ApplicationLauncherPlatformService.VERSION);
      }
    }

    public const string VERSION = "0.1";

    public ApplicationLauncherPlatformService(Platform platform) {
      Object(platform: platform);
    }

    public Application? launch(AppStream.Component comp, GLib.HashTable<string, GLib.Variant> args) throws GLib.Error {
      var launchable = comp.get_launchable(AppStream.LaunchableKind.DESKTOP_ID);
      assert(launchable != null);

      var entry = launchable.get_entries().get(0);
      assert(entry != null);

      GLib.debug("Loading desktop file from %s", entry);

      var kf = new GLib.KeyFile();
      kf.load_from_file(entry, GLib.KeyFileFlags.KEEP_TRANSLATIONS);

      var module_path = kf.get_string(GLib.KeyFileDesktop.GROUP, "X-APRIL-Module");
      GLib.debug("Loading module from %s", module_path);

      var module = GLib.Module.open(module_path, GLib.ModuleFlags.LOCAL);
      var app_type_fn_name = args.contains("entrypoint") ? args.get("entrypoint").get_string() : kf.get_string(GLib.KeyFileDesktop.GROUP, "X-APRIL-ApplicationType");

      void* function;
      assert(module.symbol(app_type_fn_name, out function));

      var app_type_fn = (ApplicationLauncherPlatformServiceType)function;
      var app_type = app_type_fn();
      GLib.debug("Found application type: %s", app_type.name());

      var app = GLib.Object.new(app_type, "platform", this.platform, "metadata", comp) as April.Application;
      assert(app != null);

      var service = this.platform.get_service(typeof (ApplicationPlatformService));
      assert(service != null);

      var application_service = service as ApplicationPlatformService;
      assert(service != null);

      application_service.launch(app, args);
      return app;
    }
  }
}
