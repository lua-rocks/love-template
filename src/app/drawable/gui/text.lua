local lg = love.graphics
local Drawable = require("src.app.drawable")

---If limit is a negative number
---@class src.app.drawable.gui.text:src.app.drawable
---@field text string
---@field wrap? boolean
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
  return self
end

function text:draw()
  Drawable.draw(self)
  local x, y = unpack(self.abs_pos)
  if self.wrap or self.align or self.limit then
    local limit = self.parent.abs_size[1] - self.rel_pos[1] - (self.limit or 0)
    lg.printf(self.text, x, y, limit, self.align)
  else
    lg.print(self.text, x, y)
  end
  return self
end

return text
