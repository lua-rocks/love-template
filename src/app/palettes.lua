local names = {
  "white",
  "silver",
  "gray",
  "rock",
  "blue",
  "water",
  "cyan",
  "grass",
  "green",
  "wood",
  "orange",
  "yellow",
  "pink",
  "red",
  "brown",
  "black",
}

local lib_palettes = require("lib.image.palettes")

---@class src.app.palettes
---@field db16 lib.image.palettes
---@field db16x5 lib.image.palettes
---@field db16_name_to_color table<string,lib.image.color>
---@field db16_name_to_index table<string,integer>
local palettes = {
  db16_name_to_color = {},
  db16_name_to_index = {},
}

local dir = "res/img/palettes/db16/"
palettes.db16 = lib_palettes.load(dir .. "db16.png")
palettes.db16x5 = lib_palettes.load(dir .. "db16x5.png")
for index, name in ipairs(names) do
  palettes.db16_name_to_color[name] = palettes.db16[5][index]
  palettes.db16_name_to_index[name] = index
end

return palettes
