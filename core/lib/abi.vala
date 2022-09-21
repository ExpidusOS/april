namespace April {
  public struct ABITarget {
    public int major;
    public int minor;

    public ABITarget(int major, int minor) {
      this.major = major;
      this.minor = minor;
    }

    public double get_value() {
      return double.parse("%d.%d".printf(this.major, this.minor));
    }

    public static ABITarget get_default() {
      return ABITarget(VERSION_MAJOR, VERSION_MINOR);
    }

    public static ABITarget from_string(string str) {
      var split = str.split(".");
      assert(split.length == 2);
      return ABITarget(int.parse(split[0]), int.parse(split[1]));
    }

    public static ABITarget from_value(double v) {
      return ABITarget.from_string(v.to_string());
    }
  }

  public enum ABICompatLevel {
    NONE,
    MIN,
    MAX,
    FULL
  }

  public interface ABIBound : GLib.Object {
    public abstract ABITarget abi_max { get; }
    public abstract ABITarget abi_min { get; }
    public abstract ABICompatLevel abi_compat { get; }

    public ABICompatLevel check_abi_compat(ABITarget target) {
      var min = this.abi_min;
      var max = this.abi_max;

      assert(min.major < max.major);
      assert(min.minor < max.minor);
      assert(min.get_value().is_normal());
      assert(max.get_value().is_normal());

      if (max.get_value() == target.get_value() && min.get_value() == target.get_value()) return ABICompatLevel.FULL;
      if (min.get_value() <= target.get_value()) return ABICompatLevel.MIN;
      if (max.get_value() <= target.get_value()) return ABICompatLevel.MAX;
      return ABICompatLevel.NONE;
    }
  }
  
  public class ABIBoundedObject : GLib.Object, ABIBound {
    public virtual ABITarget abi_max {
      get {
        return ABITarget(1, 0);
      }
    }

    public virtual ABITarget abi_min {
      get {
        return ABITarget(0, 1);
      }
    }

    public virtual ABICompatLevel abi_compat {
      get {
        return this.check_abi_compat(ABITarget.get_default());
      }
    }
  }
}
