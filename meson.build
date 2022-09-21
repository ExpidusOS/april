project('april', 'vala', 'c', license: 'GPL-3.0-only', version: '0.1.0-prealpha')

gnome = import('gnome')
pkg = import('pkgconfig')
fs = import('fs')

prefix = get_option('prefix')
bindir = prefix / get_option('bindir')
datadir = prefix / get_option('datadir')
libdir = prefix / get_option('libdir')
libexecdir = prefix / get_option('libexecdir')
localstatedir = get_option('localstatedir')

longver = '@0@'.format(meson.project_version())
shortver = longver
git = find_program('git', native: true, required: false)
if git.found()
  git_commit = run_command([git, 'rev-parse', '--short', 'HEAD'])
  git_branch = run_command([git, 'rev-parse', '--abbrev-ref', 'HEAD'])
  if git_commit.returncode() == 0 and git_branch.returncode() == 0
    shortver = '@0@-@1@'.format(meson.project_version(), git_commit.stdout().strip())
    longver = '@0@ (branch \'@1@\')'.format(shortver, git_branch.stdout().strip())
  endif
endif

message('long: @0@, short: @1@'.format(longver, shortver))

gobject = dependency('gobject-2.0')
vadi = dependency('vadi-0.0')
appstream = dependency('appstream')
gmodule = dependency('gmodule-2.0')
libtokyo = dependency('tokyo-gtk4', required: false)

ascli = find_program('appstreamcli', required: false)

conf_data = configuration_data()
conf_data.set('PREFIX', prefix)
conf_data.set('BINDIR', bindir)
conf_data.set('DATADIR', datadir)
conf_data.set('LIBDIR', libdir)
conf_data.set('LIBEXECDIR', libexecdir)
conf_data.set('VERSION', longver)
conf_data.set('BUILDDIR', meson.current_build_dir())
conf_data.set('SOURCEDIR', meson.current_source_dir())
conf_data.set('SMALL_VERSION', shortver.split('-')[0])
conf_data.set('VERSION_MAJOR', shortver.split('-')[0].split('.')[0])
conf_data.set('VERSION_MINOR', shortver.split('-')[0].split('.')[1])
conf_data.set('VERSION_PATCH', shortver.split('-')[0].split('.')[2])
conf_data.set('VERSION_TAG', shortver.strip(shortver.split('-')[0] + '-'))

if target_machine.system() == 'darwin'
  conf_data.set('MOD_EXT', 'dylib')
elif target_machine.system() == 'windows'
  conf_data.set('MOD_EXT', 'dll')
else
  conf_data.set('MOD_EXT', 'so')
endif

subdir('core')
subdir('platforms')
subdir('examples')
