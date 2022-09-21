namespace AprilExpidus {
  private class ViewPlatformServiceWrap : TokyoGtk.ApplicationWindow {
    private April.View _view;

    public April.View view {
      get {
        return this._view;
      }
      construct {
        this._view = value;
      }
    }

    public ViewPlatformServiceWrap(April.View view) {
      var service = view.platform.get_service(typeof (April.ApplicationPlatformService));
      assert(service != null);

      var application_service = service as AprilExpidus.ApplicationPlatformService;
      assert(service != null);

      Object(application: application_service.get_gtk_application(view.application), view: view);
    }

    construct {
      this.show();
    }
  }

  public class ViewPlatformService : April.ViewPlatformService {
    private GLib.List<ViewPlatformServiceWrap> _views;

    public override string version {
      get {
        return April.ViewPlatformService.VERSION;
      }
    }

    construct {
      this._views = new GLib.List<ViewPlatformServiceWrap>();
    }

    public ViewPlatformService(Platform platform) {
      Object(platform: platform);
    }

    public override void add_view(April.View view) {
      GLib.debug("Adding view");
      this._views.append(new ViewPlatformServiceWrap(view));
    }

    public override void remove_view(April.View view) {
      foreach (var wrap in this._views) {
        if (wrap.view == view) {
          GLib.debug("Removing view");
          this._views.remove(wrap);
          break;
        }
      }
    }
  }
}
