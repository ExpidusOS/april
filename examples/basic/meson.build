configure_file(input: 'data/com.example.basic.desktop.in', output: 'com.example.basic.desktop',
  configuration: conf_data)
example_basic_metainfo = configure_file(input: 'data/com.example.basic.metainfo.xml.in', output: 'com.example.basic.metainfo.xml',
  configuration: conf_data)

if ascli.found()
  test('com.example.basic validate metainfo file', ascli, args: ['validate', '--no-net', '--pedantic', example_basic_metainfo])
endif

shared_module('com.example.basic', 'src/main.vala',
  dependencies: [libapril],
  name_prefix: '')
