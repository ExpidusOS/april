namespace April {
  public abstract class ViewPlatformService : April.PlatformService {
    public override ABICompatLevel abi_compat {
      get {
        return this.check_abi_compat(ABITarget.from_string(ViewPlatformService.VERSION));
      }
    }

    public override ABITarget abi_max {
      get {
        return ABITarget.from_string(ViewPlatformService.VERSION);
      }
    }

    public const string VERSION = "0.1";
    
    public abstract void add_view(View view);
    public abstract void remove_view(View view);
  }
}
