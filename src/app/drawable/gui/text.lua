local lg_draw = love.graphics.draw
local lg_text = love.graphics.newText
local Drawable = require("src.app.drawable")

---@class src.app.drawable.gui.text:src.app.drawable
---@field text string
---@field text_object love.Text
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
  self.text_object = lg_text(self.app.fonts.current, self.text)
  return self
end

function text:draw()
  local x, y = unpack(self.pos)
  lg_draw(self.text_object, x, y)
end

return text
