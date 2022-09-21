namespace April {
  public abstract class View : ABIBoundedObject {
    private Application _application;
    private int _width;
    private int _height;

    public Application application {
      get {
        return this._application;
      }
      construct {
        this._application = value;
      }
    }

    public Platform platform {
      get {
        return this._application.platform;
      }
    }

    public int width {
      get {
        return this._width;
      }
    }

    public int height {
      get {
        return this._height;
      }
    }

    construct {
      var service = this.platform.get_service(typeof (ViewPlatformService));
      assert(service != null);

      var view_service = service as ViewPlatformService;
      assert(view_service != null);

      view_service.add_view(this);
    }

    ~View() {
      var service = this.platform.get_service(typeof (ViewPlatformService));
      assert(service != null);

      var view_service = service as ViewPlatformService;
      assert(view_service != null);

      view_service.remove_view(this);
    }

    public abstract void create();

    public signal void size_announce(int width, int height) {
      this._width = width;
      this._height = height;
    }
  }
}
