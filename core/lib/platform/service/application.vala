namespace April {
  public abstract class ApplicationPlatformService : PlatformService {
    public override ABICompatLevel abi_compat {
      get {
        return this.check_abi_compat(ABITarget.from_string(ApplicationPlatformService.VERSION));
      }
    }

    public override ABITarget abi_max {
      get {
        return ABITarget.from_string(ApplicationPlatformService.VERSION);
      }
    }

    public const string VERSION = "0.1";

    public abstract void register_application(Application application);
    public abstract void unregister_application(Application application);
    public abstract void launch(Application application, GLib.HashTable<string, GLib.Variant> args);
  }
}
