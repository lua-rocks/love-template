local lg = love.graphics
local li = love.image
local Grid = require("lib.image.grid")

---If grid is not provided, it will be created with default quad size: 4x4.
---
---`marks` can be used in `grid.grid_pos` to shift grid between marked regions:
---
---```lua
---grid.grid_pos = skin.marks["red"]
---```
---@class src.proto.skin
---@field image love.Image
---@field file? string
---@field data? love.ImageData
---@field grid? lib.image.grid
---@field marks? table<any, { [1]:integer, [2]:integer }>
local Skin = proto.set_name({}, "src.proto.skin")

function Skin:init()
  if self.file then
    self.data = self.data or li.newImageData(self.file)
  end
  self.image = self.image or lg.newImage(self.data)
  self.grid = self.grid or proto.new(Grid, {})
  self.grid.image_size = self.grid.image_size or { self.image:getDimensions() }
  self.grid.quad_size = self.grid.quad_size or { 4, 4 }
  return self
end

---Create new multicolor skin, based on self's subpart.
---@param pos_in_quads? {[1]:integer, [2]:integer}
---@param size_in_quads? {[1]:integer, [2]:integer}
---@param pal lib.image.palette
---@param all_pals lib.image.palettes
---@param names? string[] Names for marks to travel across different parts.
function Skin:recolor_part(pos_in_quads, size_in_quads, pal, all_pals, names)
  local palettes = require("lib.image.palettes")
  local x, y = unpack(pos_in_quads)
  local w, h = unpack(size_in_quads)
  local gx, gy = unpack(self.grid.grid_pos or { 0, 0 })
  local qw, qh = unpack(self.grid.quad_size)
  w, h = (w + 1) * qw, (h + 1) * qh
  x, y = x * w * gx, y * h * gy
  local newdata = li.newImageData(w, h)
  newdata:paste(self.data, 0, 0, x, y, w, h)
  newdata = palettes.apply(newdata, pal, all_pals)
  local marks = {}
  for index, name in ipairs(names) do
    marks[name] = { 0, (index - 1) * h }
  end
  return proto.new(Skin, { data = newdata, marks = marks })
end

return Skin
