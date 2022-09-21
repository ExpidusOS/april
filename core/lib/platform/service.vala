namespace April {
  public abstract class PlatformService : ABIBoundedObject {
    private Platform _platform;

    public Platform platform {
      get {
        return this._platform;
      }
      construct {
        this._platform = value;
      }
    }

    public override ABITarget abi_min {
      get {
        return ABITarget.from_string(this.version);
      }
    }

    public abstract string version { get; }
  }
}
