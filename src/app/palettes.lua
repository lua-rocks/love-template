---@class src.app.palettes
---@field main lib.image.palette
---@field name_to_color table<string,lib.image.color>
---@field name_to_index table<string,integer>
---@field names string[]

---@type src.app.palettes|lib.image.palettes
local palettes = require("lib.image.palettes.load")(
  "res/img/palettes/db16/db16.png"
)

function palettes:init()
  self.main = self[5]
  self.name_to_color = {}
  self.name_to_index = {}
  self.names = {
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
  for index, name in ipairs(self.names) do
    self.name_to_color[name] = self.main[index]
    self.name_to_index[name] = index
  end
  return self
end

return palettes
