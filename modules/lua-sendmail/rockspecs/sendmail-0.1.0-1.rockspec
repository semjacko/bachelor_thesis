package = "sendmail"
version = "0.1.0-1"
source = {
  url = "https://github.com/moteus/lua-sendmail/archive/v0.1.0.zip",
  dir = "lua-sendmail-0.1.0",
}

description = {
  summary = "Simple wrapper around luasoket smtp.send",
  detailed = [[
  ]],
  homepage = "https://github.com/moteus/lua-sendmail",
  -- license = ""
}

dependencies = {
  "lua >= 5.1",
  "luasocket >= 2.0",
}

build = {
  type = "builtin",
  copy_directories = {"docs"},
  modules = {
    ["sendmail" ] = "lua/sendmail.lua",
  }
}