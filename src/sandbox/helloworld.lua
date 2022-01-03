require("src.globals")
require("globals.development")

local user = execute("echo $USER")
local message = lume.format("Hello, {1}!", { user }):gsub("\n", "")

dump(message)
