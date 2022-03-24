-- luacheck: no global

quiet = 1

new_globals = {
  "_",
  "_L",
  "love",
  "proto",
  "inspect",
  "dump",
  "devmode",
  "log",
}

exclude_files = { "**/.**", "git/**" }

std = "max"
