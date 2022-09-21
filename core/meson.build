libapril_src = ['lib/application.vala']
libapril_deps = [gobject]

libapril_shlib = shared_library('april', libapril_src,
  vala_gir: 'April-@0@.gir'.format(shortver.split('-')[0]),
  dependencies: libapril_deps,
  version: shortver.split('-')[0],
  install: true,
  install_dir: [true, true, true, true])
libapril = declare_dependency(link_with: libapril_shlib,
  dependencies: libapril_deps,
  compile_args: '-I ' + meson.current_build_dir())
