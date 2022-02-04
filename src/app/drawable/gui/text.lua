local lg = love.graphics
local Drawable = require("src.app.drawable")

---@class src.app.drawable.gui.text:src.app.drawable
---@field text string
---@field text_obj? love.Text
---@field align? "center"|"justify"|"left"|"right" = "left"
---@field limit? number Wrap the line after this many horizontal pixels.
local text = proto.link({}, Drawable, "src.app.drawable.gui.text")

---@generic S
---@param self S|src.app.drawable.gui.text
---@return S|src.app.drawable.gui.text self
function text:init()
  if not self.colors then
    if self.parent.colors then
      self.colors = { self.parent.colors[1] .. "+2" }
    end
  end
  Drawable.init(self)
  self:update()
  return self
end

function text:update()
  if self.align and self.limit then
    return self
  end
  self.text_obj = lg.newText(self.parent.app.fonts.current, self.text)
  self.abs_size = { self.text_obj:getDimensions() }
  self:update_geometry()
  return self
end

function text:draw()
  Drawable.draw(self)
  local x, y = unpack(self.abs_pos)
  if self.align or self.limit then
    local limit = self.parent.abs_size[1] - self.rel_pos[1] - (self.limit or 0)
    lg.printf(self.text, x, y, limit, self.align)
  else
    lg.draw(self.text_obj, x, y)
  end
  return self
end

return text
