[CCode (array_length = false, array_null_terminated = true)]
private static string[]? arg_kv_pair = null;

private const GLib.OptionEntry[] options = {
  { "arg", 'a', GLib.OptionFlags.NONE, GLib.OptionArg.STRING_ARRAY, ref arg_kv_pair, "Append the application launch argument in a key-value (string:GVariant) pair" },
  { null },
};

public static int main(string[] args) {
  try {
    var optctx = new GLib.OptionContext(" - APRIL Platform for ExpidusOS");
    optctx.set_help_enabled(true);
    optctx.add_main_entries(options, null);
    optctx.parse(ref args);
  } catch (GLib.OptionError e) {
    GLib.error("%s:%d: %s", e.domain.to_string(), e.code, e.message);
  }

  var metadata_path = args[1];

  if (metadata_path == null) {
    stderr.printf("%s: missing metadata argument\n", args[0]);
    return 1;
  }

  try {
    var comp = new AppStream.Component();
    var ctx = new AppStream.Context();
    ctx.set_filename(metadata_path);
    ctx.set_style(AppStream.FormatStyle.METAINFO);

    string metadata;
    GLib.FileUtils.get_contents(metadata_path, out metadata);
    comp.load_from_xml_data(ctx, metadata);

    var platform = new AprilExpidus.Platform();

    var service = platform.get_service(typeof (April.ApplicationLauncherPlatformService));
    assert(service != null);

    var app_launch_service = service as April.ApplicationLauncherPlatformService;
    assert(app_launch_service != null);

    var arg_tbl = new GLib.HashTable<string, GLib.Variant>(GLib.str_hash, GLib.str_equal);

    foreach (string kv_pair in arg_kv_pair) {
      var split = kv_pair.split(":", 2);
      assert(split.length == 2);

      var key = split[0];
      var rawval = split[1];

      var val = GLib.Variant.parse(null, rawval);
      arg_tbl.insert(key, val);
    }

    app_launch_service.launch(comp, arg_tbl);
    return 0;
  } catch (GLib.Error e) {
    GLib.error("%s:%d: %s", e.domain.to_string(), e.code, e.message);
  }
}
