namespace AprilExpidus {
  public class Platform : April.Platform {
    construct {
      this.container.bind_factory(typeof (April.ApplicationPlatformService), container => new AprilExpidus.ApplicationPlatformService(this));
      this.container.bind_factory(typeof (April.ViewPlatformService), container => new AprilExpidus.ViewPlatformService(this));
    }
  }
}
