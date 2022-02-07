local Skin = require("src.app.drawable.skin")
local palettes = require("lib.image.palettes")
local li = love.image
local lg = love.graphics

---@class src.app.skins
---@field gui src.app.drawable.skin
---@field mc_gui_rect src.app.drawable.skin
local skins = proto.set_name({}, "src.app.skins")

---@param pals src.app.palettes
function skins:init(pals)
  self.gui = proto.new(Skin, { atlas = "res/img/skins/gui.png" })
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
  local imgdata = li.newImageData(12, 12)
  local from = li.newImageData("res/img/skins/gui.png")
  imgdata:paste(from, 0, 0, 0, 0, 12, 12)
  imgdata = palettes.apply(imgdata, sub_colors[1], sub_colors)
  local marks = {}
  for index, name in ipairs(sub_names) do
    marks[name] = { 0, (index - 1) * 12 }
  end
  self.mc_gui_rect = proto.new(
    Skin,
    { atlas = lg.newImage(imgdata), marks = marks }
  )
  return self
end

return skins
