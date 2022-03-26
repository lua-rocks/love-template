local lg = love.graphics
local Drawable = require("src.proto.drawable")

---@class src.proto.rect:src.proto.drawable
---@field skin? string
---@field image? love.Drawable|string
local Rect = proto.link({}, Drawable, "src.proto.rect")

Rect.updaters = {
  image = function(self)
    if type(self.image) == "string" then
      self.image = lg.newImage(self.image)
      return
    end
    if self.skin then
      local skin = self.app.skins.mc_gui_rect
      local batch = lg.newSpriteBatch(skin.image)
      local grid = skin.grid
      grid.grid_pos = skin.marks[self.skin]
      local sx, sy = self.abs_size[1] - 4, self.abs_size[2] - 4
      batch:add(grid:get_quad(0, 0), 0, 0)
      batch:add(grid:get_quad(2, 0), sx, 0)
      batch:add(grid:get_quad(0, 2), 0, sy)
      batch:add(grid:get_quad(2, 2), sx, sy)
      for y = 4, sy - 4, 4 do
        batch:add(grid:get_quad(0, 1), 0, y)
        batch:add(grid:get_quad(2, 1), sx, y)
      end
      for x = 4, sx - 4, 4 do
        batch:add(grid:get_quad(1, 0), x, 0)
        batch:add(grid:get_quad(1, 2), x, sy)
      end
      self.image = batch
    end
  end,
  size = function(self)
    Drawable.updaters.size(self)
    Rect.updaters.image(self)
  end,
}

function Rect:init()
  if self.skin and not self.colors then
    self.colors = { self.skin }
  end
  Drawable.init(self)
  self:update("image")
  return self
end

function Rect:draw()
  Drawable.draw(self)
  local x, y = unpack(self.abs_pos)
  local w, h = unpack(self.abs_size)
  lg.rectangle("fill", x, y, w, h)
  if self.image then
    lg.setColor(1, 1, 1)
    lg.draw(self.image, x, y)
  end
end

return Rect
