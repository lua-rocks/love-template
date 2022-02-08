local lg = love.graphics
local Grid = require("lib.image.grid")

---If grid is not provided, it will be created with default quad size: 4x4.
---
---`marks` can be used in `grid.grid_pos` to shift grid between marked regions:
---
---```lua
---grid.grid_pos = skin.marks["red"]
---```
---@class src.proto.skin
---@field atlas love.Drawable|string
---@field grid? lib.image.grid
---@field marks? table<any, { [1]:integer, [2]:integer }>
local Skin = proto.set_name({}, "src.proto.skin")

function Skin:init()
  if type(self.atlas) == "string" then
    self.atlas = lg.newImage(self.atlas)
  end
  self.grid = self.grid or proto.new(Grid, {})
  self.grid.image_size = self.grid.image_size or { self.atlas:getDimensions() }
  self.grid.quad_size = self.grid.quad_size or { 4, 4 }
  return self
end

return Skin
