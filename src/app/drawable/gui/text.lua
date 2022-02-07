local lg = love.graphics
local Drawable = require("src.app.drawable")

---@class src.app.drawable.gui.text:src.app.drawable
---@field text string
---@field text_obj? love.Text
---@field wrap? boolean
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
  self.text_obj = lg.newText(self.parent.app.fonts.current, self.text)
  self.abs_size = { self.text_obj:getDimensions() }
  self:update_geometry()
  return self
end

function text:draw()
  Drawable.draw(self)
  lg.draw(self.text_obj, unpack(self.abs_pos))
  return self
end

return text
