---@class src.app.skins
---@field gui love.ImageData
---@field gui_init_w integer
---@field gui_init_h integer
---@field gui_y_to_name table<integer,string>
---@field gui_name_to_y table<string,integer>
---@field gui_grids4x4 table<string,lib.image.grid>

---@class src.app.skins-name
---|'"red"'
---|'"orange"'
---|'"grass"'
---|'"water"'
---|'"gray"'

local names = {
  "red",
  "orange",
  "grass",
  "water",
  "gray",
}

local lib_palettes = require("lib.image.palettes")
local Grid = require("lib.image.grid")

return function()
  ---@type src.app.skins
  local skins = {
    gui_y_to_name = {},
    gui_name_to_y = {},
    gui_grids4x4 = {},
  }
  local imgdata = love.image.newImageData("res/img/skins/gui.png")
  local gui_init_w, gui_init_h = imgdata:getDimensions()
  local x5 = lib_palettes.load("res/img/palettes/db16/db16x5.png")
  skins.gui = lib_palettes.apply(imgdata, x5[1], x5)
  for index, name in ipairs(names) do
    local y = (index - 1) * gui_init_h
    skins.gui_y_to_name[y] = name
    skins.gui_name_to_y[name] = y
    skins.gui_grids4x4[name] = proto.new(Grid, {
      grid_pos = { 0, y },
      image_size = { skins.gui:getDimensions() },
      quad_size = { 4, 4 },
    })
  end
  skins.gui_init_w, skins.gui_init_h = gui_init_w, gui_init_h
  return skins
end
