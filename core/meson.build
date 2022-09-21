libapril_build_vala = configure_file(input: 'lib/build.vala.in', output: 'build.vala',
  configuration: conf_data)

libapril_src = ['lib/abi.vala', 'lib/application.vala', 'lib/platform.vala', 'lib/platform/service.vala',
  'lib/platform/service/application-launcher.vala', 'lib/platform/service/application.vala', libapril_build_vala]
libapril_deps = [gobject, vadi, appstream, gmodule]

libapril_shlib = shared_library('april', libapril_src,
  c_args: ['-DG_LOG_DOMAIN="April"'],
  vala_gir: 'April-@0@.gir'.format(shortver.split('-')[0]),
  dependencies: libapril_deps,
  version: shortver.split('-')[0],
  install: true,
  install_dir: [true, true, true, true])
libapril = declare_dependency(link_with: libapril_shlib,
  dependencies: libapril_deps,
  compile_args: '-I' + meson.current_build_dir())
