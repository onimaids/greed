package = "greed"
version = "0.1.2-1"
source = {
  url = "git+ssh://git@github.com/onimaids/greed.git"
}

description = {
  detailed = "Greed is another Lua library that enhances the standard library.",
  -- homepage = "*** please enter a project homepage ***",
  -- license = "*** please specify a license ***"
}

dependencies = {
  "lua >= 5.1, < 5.5"
}

build = {
  type = "builtin",

  modules = {
    greed = "greed.lua",
    ["greed.result"] = "src/result.lua",
    ["greed.string"] = "src/string.lua",
    ["greed.table"] = "src/table.lua",
    ["greed.types"] = "src/types.lua"
  },
}
