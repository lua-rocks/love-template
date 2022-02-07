---@class src.app.palettes
---@field main lib.image.palette
---@field name_to_color table<string,lib.image.color>
---@field name_to_index table<string,integer>
---@field names string[]

---@type src.app.palettes|lib.image.palettes
local palettes = require("lib.image.palettes.load")(
  "res/img/palettes/db16/db16.png"
)

palettes.main = palettes[5]
palettes.name_to_color = {}
palettes.name_to_index = {}
palettes.names = {
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

for index, name in ipairs(palettes.names) do
  palettes.name_to_color[name] = palettes.main[index]
  palettes.name_to_index[name] = index
end

return palettes
