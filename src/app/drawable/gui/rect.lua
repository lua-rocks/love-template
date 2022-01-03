local lg = love.graphics
local Drawable = require("src.app.drawable")

---@class src.app.drawable.gui.rect:src.app.drawable
---@field skin? string
---@field image? love.Drawable|string
local rect = proto.link({}, Drawable, "src.app.drawable.gui.rect")

function rect:init()
  if self.skin and not self.colors then
    self.colors = { self.skin }
  end
  Drawable.init(self)
  self:make_batch()
  if type(self.image) == "string" then
    self.image = lg.newImage(self.image)
  end
  return self
end

function rect:make_batch()
  if self.skin then
    local skins = self.app.skins
    local batch = lg.newSpriteBatch(lg.newImage(skins.gui))
    local grid = skins.gui_grids4x4[self.skin]
    local sx, sy = self.size[1] - 4, self.size[2] - 4
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
end

function rect:draw()
  local x, y = unpack(self.pos)
  local w, h = unpack(self.size)
  lg.rectangle("fill", x, y, w, h)
  if self.image then
    lg.setColor(1, 1, 1)
    lg.draw(self.image, x, y)
  end
end

return rect
