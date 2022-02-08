local Skin = require("src.proto.skin")

---@class src.app.skins
---@field gui src.proto.skin All GUI.
---@field mc_gui_rect src.proto.skin Multicolor GUI rectangle.
local skins = proto.set_name({}, "src.app.skins")

---@param pals src.app.palettes
function skins:init(pals)
  self.gui = proto.new(Skin, { file = "res/img/skins/gui.png" })
  local c = pals.name_to_color
  local sub_colors = {
    { c.white, c.pink, c.red, c.brown, c.black },
    { c.white, c.yellow, c.orange, c.wood, c.black },
    { c.white, c.yellow, c.grass, c.green, c.black },
    { c.white, c.cyan, c.water, c.blue, c.black },
    { c.white, c.silver, c.gray, c.rock, c.black },
    { c.yellow, c.orange, c.wood, c.brown, c.black },
  }
  local sub_names = {
    "red",
    "orange",
    "grass",
    "water",
    "gray",
    "wood",
  }
  self.mc_gui_rect = self.gui:recolor_part(
    { 0, 0 },
    { 2, 2 },
    sub_colors[1],
    sub_colors,
    sub_names
  )
  return self
end

return skins
