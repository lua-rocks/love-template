local lg = love.graphics
local Drawable = require("src.proto.drawable")

---@class src.proto.text:src.proto.drawable
---@field text string
---@field text_obj? love.Text
---@field wrap? boolean
---@field shadow? boolean
local Text = proto.link({}, Drawable, "src.proto.text")

function Text:init()
  if not self.colors then
    if self.parent.colors then
      self.colors = { self.parent.colors[1] .. "+2" }
    end
  end
  Drawable.init(self)
  self:update()
  return self
end

function Text:update()
  self.text_obj = lg.newText(self.parent.app.fonts.current, self.text)
  self.abs_size = { self.text_obj:getDimensions() }
  self:update_geometry()
  return self
end

function Text:draw()
  Drawable.draw(self)
  local x, y = unpack(self.abs_pos)
  x, y = x + 1, y - 1
  if self.shadow then
    lg.setColor(self.abs_colors[2])
    lg.draw(self.text_obj, x, y + 1)
    lg.setColor(self.abs_colors[1])
  end
  lg.draw(self.text_obj, x, y)
  return self
end

return Text
