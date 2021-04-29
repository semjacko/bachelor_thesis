package = "xml"
version = "1.0.0-1"
source = {
  url = 'https://github.com/lubyk/xml/archive/REL-1.0.0.tar.gz',
  dir = 'xml-REL-1.0.0',
}
description = {
  summary = "Very fast xml parser based on RapidXML",
  detailed = [[
    This module is part of the Lubyk project.

    Main features are:
     - Fast and easy to use
     - Complete documentation
     - Based on proven code (RapidXML)
     - Full test coverage

     Read the documentation at http://doc.lubyk.org/xml.html.
  ]],
  homepage = "http://doc.lubyk.org/xml.html",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1, < 5.3",
  "lub >= 1.0.3, < 1.1",
}
build = {
  type = 'builtin',
  modules = {
    -- Plain Lua files
    ['xml'            ] = 'xml/init.lua',
    ['xml.Parser'     ] = 'xml/Parser.lua',
    -- C++ modules
    ['xml.core'       ] = {
      sources = {
        'src/bind/dub/dub.cpp',
        'src/bind/xml_core.cpp',
        'src/bind/xml_Parser.cpp',
        'src/Parser.cpp',
      },
      incdirs = {'include', 'src/bind', 'src/vendor'},
      libraries = {'stdc++'},
    },
  },
}


